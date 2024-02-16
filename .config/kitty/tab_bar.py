import os
from dataclasses import dataclass
from typing import List, Optional
from kitty.fast_data_types import Screen, get_options
from kitty.tab_bar import DrawData, ExtraData, TabBarData, as_rgb
from kitty.utils import color_as_int

@dataclass
class ItemFormat:
    fg: str
    bg: str
    other: Optional[str]

@dataclass
class StatusItem:
    text: str
    format: ItemFormat

options = get_options()

DEFAULT_FG = as_rgb(color_as_int(options.foreground))
DEFAULT_BG = as_rgb(color_as_int(options.background))

def parse_statusline(statusline: str) -> List[StatusItem]:
    stl_items = statusline.split("#[")
    stl_items.pop(0)
    parsed_statusline = []
    for item in stl_items:
        [format, text] = item.split("]", 1)
        fg = DEFAULT_FG
        bg = DEFAULT_BG
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

def draw_statusline(screen: Screen, statusline: List[StatusItem]):
    print(statusline)
    for item in statusline:
        screen.cursor.fg = item.format.fg
        screen.cursor.bg = item.format.bg
        screen.draw(item.text)

def draw_left_statusline(screen: Screen):
    statusline_str = open("/tmp/tmux-" + str(os.getuid()) + "/default-$0-vimbridge").readline()
    parsed_statusline = parse_statusline(statusline_str)
    draw_statusline(screen, parsed_statusline)
    # TODO draw separators

def draw_right_statusline(screen: Screen):
    statusline_str = open("/tmp/tmux-" + str(os.getuid()) + "/default-$0-vimbridge-R").readline()
    parsed_statusline = parse_statusline(statusline_str)
    # TODO draw separators
    draw_statusline(screen, parsed_statusline)

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
    if index == 1:
        draw_left_statusline(screen)

    # TODO draw_tab()

    if is_last:
        draw_right_statusline(screen)

    return screen.cursor.x
