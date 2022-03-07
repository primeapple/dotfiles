###################
##### General #####
###################
# Load existing settings made via :set
config.load_autoconfig()
c.auto_save.session = True
c.editor.command = ['/usr/local/bin/kitty', '-1', 'nvim', '{file}', '-c', 'normal {line}G{column0}l']
# remembers mode per tab
c.tabs.mode_on_change = 'restore'

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

