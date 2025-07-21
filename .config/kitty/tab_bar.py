import os

from pathlib import Path
from dataclasses import dataclass
from typing import List

from collections.abc import Sequence
from functools import partial

from kitty.boss import get_boss
from kitty.fast_data_types import Screen, get_options
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    TabBar,
    TabBarData,
    as_rgb,
    color_as_int,
    draw_title,
)


# Inspiration from: https://github.com/kovidgoyal/kitty/discussions/4447#discussioncomment-11723638
class WeirdTabBar(TabBar):
    def __init__(self, tab_bar: TabBar):
        self.inner = tab_bar

    def __getattr__(self, attr):
        return getattr(self.inner, attr)

    def __setattr__(self, attr, value):
        if attr == "draw_data":
            return self.inner.__setattr__(attr, value)
        else:
            return super().__setattr__(attr, value)

    def destroy(self) -> None:
        self.inner.screen.reset_callbacks()
        del self.inner.screen

    def update(self, data: Sequence[TabBarData]) -> None:
        left_status = left_statusline_components()
        left_status_len = simple_components_len(left_status)
        right_status = right_statusline_components()
        right_status_len = simple_components_len(right_status)

        opts = get_options()
        screen = self.inner.screen
        orig_align = self.inner.align

        match opts.tab_bar_align:
            case "left":
                self.inner.align: Callable[[], None] = partial(
                    self.pad_left, left_status_len
                )
            case "right":
                self.inner.align: Callable[[], None] = partial(
                    self.pad_right, right_status_len
                )

        self.inner.update(data)

        screen.cursor.x = max(0, screen.columns - right_status_len)
        draw_components(screen, right_status)

        screen.cursor.x = 0
        draw_components(screen, left_status)

        self.inner.align = orig_align

    def pad_left(self, padding: int) -> None:
        self.screen.cursor.x = 0
        self.screen.insert_characters(padding)
        self.inner.cell_ranges = [
            (s + padding, e + padding) for (s, e) in self.inner.cell_ranges
        ]

    def pad_right(self, padding: int) -> None:
        if not self.inner.cell_ranges:
            return
        end = self.inner.cell_ranges[-1][1]
        if end < self.screen.columns - padding - 1:
            shift = self.screen.columns - end - padding
            self.screen.cursor.x = 0
            self.screen.insert_characters(shift)
            self.inner.cell_ranges = [
                (s + shift, e + shift) for (s, e) in self.inner.cell_ranges
            ]


def _draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_tab_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    fg = ACTIVE_TAB_FG if tab.is_active else INACTIVE_TAB_FG
    bg = ACTIVE_TAB_BG if tab.is_active else INACTIVE_TAB_BG
    options = ComponentOptions(fg, bg, True)

    max_tab_length += 1
    if max_tab_length <= 1:
        draw_components(screen, [Component("…", options)])
    elif max_tab_length == 2:
        draw_components(screen, [Component("…|", options)])
    elif max_tab_length < 6:
        draw_components(
            screen,
            tab_left_components(tab.is_active)
            + [Component("…", options)]
            + tab_right_components(tab.is_active),
        )
    else:
        draw_components(screen, tab_left_components(tab.is_active))
        draw_title(draw_data, screen, tab, index, max_tab_length)
        extra = screen.cursor.x - before - max_tab_length
        if extra >= 0:
            screen.cursor.x -= extra + 3
            draw_components(screen, [Component("…", options)])
        elif extra == -1:
            screen.cursor.x -= 2
            draw_components(screen, [Component("…", options)])
        draw_components(screen, tab_right_components(tab.is_active))

    if not is_last:
        draw_components(screen, [space_component(1)])

    return screen.cursor.x

    ### OLD

    orig_fg = screen.cursor.fg
    left_sep, right_sep = ("", "")
    slant_fg = as_rgb(color_as_int(draw_data.default_bg))

    def draw_sep(which: str) -> None:
        tab_bg = as_rgb(draw_data.tab_bg(tab))
        screen.cursor.fg = tab_bg
        screen.cursor.bg = slant_fg
        screen.draw(which)
        screen.cursor.bg = tab_bg
        screen.cursor.fg = orig_fg

    # TODO: logic based on max title length?
    max_tab_length += 1
    if max_tab_length <= 1:
        screen.draw("…")
    elif max_tab_length == 2:
        screen.draw("…|")
    elif max_tab_length < 6:
        draw_sep(left_sep)
        screen.draw("…")
        draw_sep(right_sep)
    else:
        draw_sep(left_sep)
        draw_title(draw_data, screen, tab, index, max_tab_length)
        extra = screen.cursor.x - before - max_tab_length
        if extra >= 0:
            screen.cursor.x -= extra + 3
            screen.draw("…")
        elif extra == -1:
            screen.cursor.x -= 2
            screen.draw("…")
        draw_sep(right_sep)

    if not is_last:
        draw_sep(" ")

    return screen.cursor.x


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    tm = get_boss().active_tab_manager
    if type(tm.tab_bar) is not WeirdTabBar:
        tm.tab_bar = WeirdTabBar(tm.tab_bar)

    end = _draw_tab(
        draw_data, screen, tab, before, max_title_length, index, is_last, extra_data
    )

    return end


### MY STUFF ###

##### Kitty settings #####
options = get_options()

# colors
DEFAULT_FG = as_rgb(color_as_int(options.foreground))
DEFAULT_BG = as_rgb(color_as_int(options.background))
ACTIVE_TAB_FG = as_rgb(color_as_int(options.active_tab_foreground))
ACTIVE_TAB_BG = as_rgb(color_as_int(options.active_tab_background))
INACTIVE_TAB_FG = as_rgb(color_as_int(options.inactive_tab_foreground))
INACTIVE_TAB_BG = as_rgb(color_as_int(options.inactive_tab_background))


##### Components ######
@dataclass
class ComponentOptions:
    fg: int
    bg: int
    bold: bool = False
    blink: bool = False
    italic: bool = False


@dataclass
class Component:
    text: str
    options: ComponentOptions

    def __len__(self):
        return len(self.text)


def space_component(size: int) -> Component:
    return Component(" " * size, ComponentOptions(DEFAULT_FG, DEFAULT_BG))


def tab_left_components(is_active: bool) -> List[Component]:
    fg = ACTIVE_TAB_BG if is_active else INACTIVE_TAB_BG
    bg = ACTIVE_TAB_FG if is_active else INACTIVE_TAB_FG
    return [
        Component("", ComponentOptions(bg, fg)),
        Component("", ComponentOptions(fg, bg)),
        Component(" ", ComponentOptions(bg, fg)),
    ]


def tab_right_components(is_active: bool) -> List[Component]:
    fg = ACTIVE_TAB_BG if is_active else INACTIVE_TAB_BG
    bg = ACTIVE_TAB_FG if is_active else INACTIVE_TAB_FG
    return [
        Component(" ", ComponentOptions(bg, fg)),
        Component("", ComponentOptions(fg, bg)),
        Component("", ComponentOptions(bg, fg)),
    ]


# this is not always correct, since some symbols take multiple columns but their `len` is only 1
def simple_components_len(components: List[Component]):
    length = 0
    for component in components:
        length += len(component)
    return length


def draw_components(screen: Screen, components: List[Component]) -> None:
    for component in components:
        screen.cursor.fg = component.options.fg
        screen.cursor.bg = component.options.bg
        screen.cursor.bold = component.options.bold
        screen.cursor.blink = component.options.blink
        screen.cursor.italic = component.options.italic
        screen.draw(component.text)


##### TPIPELINE #####
def get_tpipeline_str(path: str) -> str:
    file = Path(path)
    if file.is_file():
        return file.read_text().rstrip("\n")
    else:
        return ""


def parse_statusline_str(statusline_str) -> List[Component]:
    stl_items = statusline_str.split("#[")
    stl_items.pop(0)
    parsed_statusline = []
    for item in stl_items:
        [format, text] = item.split("]", 1)
        fg = DEFAULT_FG
        bg = DEFAULT_BG
        bold = False
        blink = False
        italic = False
        for item_format in format.split(","):
            if item_format.startswith("fg="):
                if item_format != "fg=" and item_format != "fg=default":
                    fg = as_rgb(int(item_format[4:10], 16))
            elif item_format.startswith("bg="):
                if item_format != "bg=" and item_format != "bg=default":
                    bg = as_rgb(int(item_format[4:10], 16))
            elif item_format == "bold":
                bold = True
            elif item_format == "blink":
                blink = True
            elif item_format == "italics":
                italic = True
        parsed_statusline.append(
            Component(text, ComponentOptions(fg, bg, bold, blink, italic))
        )
    return parsed_statusline


def left_statusline_components() -> List[Component]:
    return parse_statusline_str(
        get_tpipeline_str("/tmp/tmux-" + str(os.getuid()) + "/default-$0-vimbridge")
    )


def right_statusline_components() -> List[Component]:
    return parse_statusline_str(
        get_tpipeline_str("/tmp/tmux-" + str(os.getuid()) + "/default-$0-vimbridge-R")
    )
