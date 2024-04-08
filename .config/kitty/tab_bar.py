import os
from pathlib import Path
from dataclasses import dataclass
from typing import List
from kitty.fast_data_types import Screen, get_boss, get_options
from kitty.tab_bar import DrawData, ExtraData, TabBarData, as_rgb
from kitty.tabs import Tab
from kitty.utils import color_as_int

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


def decorated_tab_title(tab_title: str) -> str:
    last_segment = tab_title.split().pop()
    if "/" in last_segment:
        return "[" + last_segment.split("/").pop() + "]"
    return last_segment


def single_tab_components(tab: Tab, is_active: bool) -> List[Component]:
    fg = ACTIVE_TAB_FG if is_active else INACTIVE_TAB_FG
    bg = ACTIVE_TAB_BG if is_active else INACTIVE_TAB_BG
    return (
        tab_left_components(is_active)
        + [Component(decorated_tab_title(tab.title), ComponentOptions(fg, bg, True))]
        + tab_right_components(is_active)
    )


def all_tab_components(
    screen: Screen,
    text_size_before: int,
    text_size_after: int,
    active_tab_id: int,
) -> List[Component]:
    max_text_size = max(text_size_before, text_size_after)
    available_space_in_center = screen.columns - (2 * max_text_size)

    # inserting as much tabs as possible fit without overlapping
    tab_components = [space_component(1)]
    tabs_length = simple_components_len(tab_components)
    for tab in get_boss().all_tabs:
        next_tab_components = single_tab_components(tab, tab.id == active_tab_id)
        next_tab_components.append(space_component(1))
        next_tab_length = simple_components_len(next_tab_components)
        if tabs_length + next_tab_length >= available_space_in_center:
            break
        tab_components += next_tab_components
        tabs_length += next_tab_length

    total_padding = available_space_in_center - tabs_length
    padding_left = total_padding // 2
    padding_right = total_padding - padding_left
    tab_components.insert(
        0, space_component(padding_left + max_text_size - text_size_before)
    )
    tab_components.append(
        space_component(padding_right + max_text_size - text_size_after)
    )
    return tab_components


# this is not always correct, since some symbols take multiple columns but their `len` is only 1
def simple_components_len(components: List[Component]):
    length = 0
    for component in components:
        length += len(component)
    return length


# this is always correct but may require more resources and might produce bugs
def drawing_components_len(screen: Screen, components: List[Component]):
    old_cursor_x = screen.cursor.x
    draw_components(screen, components)
    new_cursor_x = screen.cursor.x
    screen.cursor.x = old_cursor_x
    return new_cursor_x - old_cursor_x


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
                if item_format != "fg=default":
                    fg = as_rgb(int(item_format[4:10], 16))
            elif item_format.startswith("bg="):
                if item_format != "bg=default":
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


##### Utils #####
def is_nvim_active_in_tab(tab_id: int):
    tab = get_boss().tab_for_id(tab_id)
    if tab != None:
        return tab.get_exe_of_active_window() == "nvim"
    return False


##### Kitty API #####
active_tab_id = 0


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
    if tab.is_active:
        # a better solution would be to draw the whole tab bar on the active tab
        # but that produces an error (3 red dots in the most right corner),
        # since kitty expects only the last `draw_tab` function call to produce an element on the last column
        global active_tab_id
        active_tab_id = tab.tab_id

    if is_last:
        left_text_size = 0
        right_text_size = 0

        active_tab_has_nvim_running = is_nvim_active_in_tab(active_tab_id)
        if active_tab_has_nvim_running:
            left_statusline = left_statusline_components()
            right_statusline = right_statusline_components()

            draw_components(screen, left_statusline)
            left_text_size = screen.cursor.x
            draw_components(screen, right_statusline)
            right_text_size = screen.cursor.x - left_text_size
            screen.cursor.x = left_text_size
            tabs = all_tab_components(
                screen, left_text_size, right_text_size, active_tab_id
            )
            draw_components(screen, tabs)
            draw_components(screen, right_statusline)
        else:
            tabs = all_tab_components(
                screen, left_text_size, right_text_size, active_tab_id
            )
            draw_components(screen, tabs)

    return screen.cursor.x
