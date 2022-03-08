###################
##### General #####
###################
# Load existing settings made via :set
config.load_autoconfig()
c.auto_save.session = True
c.editor.command = ['/usr/local/bin/kitty', '-1', 'nvim', '{file}', '-c', 'normal {line}G{column0}l']
# remembers mode per tab
c.tabs.mode_on_change = 'restore'

###################
##### content #####
###################
c.url.searchengines = {
    "DEFAULT": "https://www.ecosia.org/search?q={}",
    "g": "https://google.com/search?q={}",
    "a": "https://smile.amazon.de/s?k={}",
    "l": "https://dict.leo.org/englisch-deutsch/{}",
    "gh": "https://github.com/search?o=desc&q={}&s=stars",
    "m": "https://www.google.com/maps/search/{}",
    "r": "https://www.reddit.com/search?q={}",
    "yt": "https://www.youtube.com/results?search_query={}",
    "w": "https://de.wikipedia.org/wiki/{}",
    "d": "https://duckduckgo.com/?q={}&ia=web"
}


####################
##### Bindings #####
####################


############################
##### ContentFiltering #####
############################
# disable cookie banners
c.content.blocking.adblock.lists.append("https://secure.fanboy.co.nz/fanboy-cookiemonster.txt")

######################
##### Appearance #####
######################
c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.enabled = True

c.fonts.default_family = "JetbrainsMono"

# TODO: add dracula as submodule
import dracula.draw
dracula.draw.blood(c, { 'spacing': { 'vertical': 6, 'horizontal': 8 } })

