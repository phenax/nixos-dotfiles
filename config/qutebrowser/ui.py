import subprocess
from qutebrowser.config.configfiles import ConfigAPI
from qutebrowser.config.config import ConfigContainer
config = config
c = c

def read_xresources(prefix):
    props = {}
    x = subprocess.run(['xrdb', '-query'], stdout=subprocess.PIPE)
    lines = x.stdout.decode().split('\n')
    for line in filter(lambda l : l.startswith(prefix), lines):
        prop, _, value = line.partition(':\t')
        props[prop] = value
    return props

xresources = read_xresources('*')

c.fonts.default_family = 'JetBrains Mono'
c.fonts.default_size = '12px'
c.colors.webpage.prefers_color_scheme_dark = True
c.colors.webpage.bg = "white"
c.colors.webpage.darkmode.enabled = True

## Hints
c.colors.hints.bg = 'yellow'
c.hints.border = '1px solid #000000'


#  c.colors.statusbar.normal.bg = xresources['*.background']
## Context menu styles
c.colors.contextmenu.menu.bg = xresources['*.background']
c.colors.contextmenu.menu.fg = xresources['*.foreground']
c.colors.contextmenu.selected.bg = xresources['*.accent']
c.colors.contextmenu.selected.fg = xresources['*.foreground']

## Completion
c.colors.completion.category.bg = xresources['*.background']
c.colors.completion.category.fg = xresources['*.accent']
c.colors.completion.even.bg = xresources['*.background']
c.colors.completion.odd.bg = xresources['*.color0']
c.colors.completion.item.selected.fg = xresources['*.foreground']
c.colors.completion.item.selected.bg = xresources['*.accent']
c.colors.completion.item.selected.border.bottom = xresources['*.accent']
c.colors.completion.item.selected.border.top = xresources['*.accent']
c.colors.statusbar.insert.bg = 'red'
c.colors.statusbar.insert.fg = 'white'

## Tabs
c.tabs.padding = { 'bottom': 2, 'top': 2, 'left': 5, 'right': 5 }

## Unselected tabs
c.colors.tabs.even.bg = xresources['*.background']
c.colors.tabs.even.fg = xresources['*.foreground']
c.colors.tabs.odd.bg = c.colors.tabs.even.bg
c.colors.tabs.odd.fg = c.colors.tabs.even.fg

## Selected tab
c.colors.tabs.selected.even.bg = xresources['*.accent']
c.colors.tabs.selected.even.fg = xresources['*.foreground']
c.colors.tabs.selected.odd.bg = c.colors.tabs.selected.even.bg
c.colors.tabs.selected.odd.fg = c.colors.tabs.selected.even.fg

# Pinned tab
c.colors.tabs.pinned.even.bg = xresources['*.background']
c.colors.tabs.pinned.even.fg = c.colors.tabs.even.fg
c.colors.tabs.pinned.odd.bg = xresources['*.background']
c.colors.tabs.pinned.odd.fg = c.colors.tabs.odd.fg

c.colors.tabs.pinned.selected.even.bg = c.colors.tabs.selected.even.bg
c.colors.tabs.pinned.selected.even.fg = c.colors.tabs.selected.even.fg
c.colors.tabs.pinned.selected.odd.bg = c.colors.tabs.selected.odd.bg
c.colors.tabs.pinned.selected.odd.fg = c.colors.tabs.selected.odd.fg

