import os
from dataclasses import dataclass
from typing import List, Optional
from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer
from kitty.tab_bar import DrawData, ExtraData, TabBarData, draw_title, as_rgb

timer_id = None


@dataclass
class ItemFormat:
    fg: str
    bg: str
    other: Optional[str]


@dataclass
class StatusItem:
    text: str
    format: ItemFormat


def parse_statusline(draw_data: DrawData, statusline: str) -> List[StatusItem]:
    stl_items = statusline.split("#[")
    stl_items.pop(0)
    parsed_statusline = []
    for item in stl_items:
        [format, text] = item.split("]", 1)
        # building the format
        # TODO get default fg and bg from kitty
        # fg = as_rgb(int(draw_data.default_fg))
        # bg = as_rgb(int(draw_data.default_bg))
        other = None
        for item_format in format.split(","):
            if item_format.startswith("fg="):
                if item_format != "fg=default":
                    fg = as_rgb(int(item_format[4:10], 16))
            elif item_format.startswith("bg="):
                if item_format != "bg=default":
                    bg = as_rgb(int(item_format[4:10], 16))
            else:
                other = item_format
        parsed_statusline.append(StatusItem(text, ItemFormat(fg, bg, other)))
    return parsed_statusline


def draw_tpipeline(screen: Screen, draw_data: DrawData):
    stl = open("/tmp/tmux-" + str(os.getuid()) + "/default-$0-vimbridge").readline()
    parsed_statusline = parse_statusline(draw_data, stl)
    print(parsed_statusline)
    for item in parsed_statusline:
        screen.cursor.fg = item.format.fg
        screen.cursor.bg = item.format.bg
        screen.draw(item.text)
    # stl = open("/tmp/tmux-" + str(os.getuid()) + "/default-$0-vimbridge-R").readline()


def redraw_tab_bar(timer_id):
    tm = get_boss().active_tab_manager
    if tm is not None:
        tm.mark_tab_bar_dirty()


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
    global timer_id
    if timer_id is None:
        timer_id = add_timer(redraw_tab_bar, 0.3, True)

    if index == 1:
        draw_tpipeline(screen, draw_data)

    return screen.cursor.x
