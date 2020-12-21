import random
from qutebrowser.config.configfiles import ConfigAPI
from qutebrowser.config.config import ConfigContainer
config = config
c = c

def compose(*args):
    return ' ;; '.join(args)

def enable(s, ask = False):
    return 'set ' + s + ' ' + ('ask' if ask else 'True')

def disable(s):
    return 'set ' + s + ' False'


def rand_numstr(a, b):
    return str(random.randint(a, b))

def random_version(a, b):
    return rand_numstr(a, b) + '.' + rand_numstr(0, 100)

def random_useragent():
    chrome_version = random_version(77, 84)
    # firefox_version = random_version(77, 80)
    build_version = random_version(1000, 3000)

    agents = [
        'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML; like Gecko) Chromium/' + chrome_version + '.0.4044.138 Chrome/' + chrome_version + '.' + build_version + ' Safari/{webkit_version}',
        'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/' + chrome_version + '.0.4147.89 Safari/{webkit_version} Hola/1.173.900',
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/' + chrome_version + '.0.2623.112 Safari/{webkit_version}'
        # 'Mozilla/5.0 (Linux x86_64; rv:78.0) Gecko/20100101 Firefox/' + firefox_version,
    ]
    return agents[random.randint(0, 2)]

c.content.cookies.accept = 'no-3rdparty'
c.content.geolocation = 'ask'
c.content.headers.do_not_track = True
c.content.headers.referer = 'never'
c.content.headers.user_agent = random_useragent()
c.content.host_blocking.enabled = True
c.content.media.audio_capture = 'ask'
c.content.media.video_capture = 'ask'
c.content.ssl_strict = 'ask'
c.content.desktop_capture = 'ask'
c.content.mouse_lock = 'ask'
c.content.javascript.can_access_clipboard = True
c.content.canvas_reading = True
# c.content.fullscreen.window = True   # Fullscreen fixed to window size

# Tor
c.aliases['tor-enable'] = 'set content.proxy "socks://localhost:9050"'
c.aliases['tor-disable'] = 'config-unset content.proxy'
c.aliases['tor-change'] = 'spawn --userscript tor_identity'

# Fingerprinting feature switches
c.aliases['clipboard-disable'] = disable('content.javascript.can_access_clipboard')
c.aliases['clipboard-enable'] = enable('content.javascript.can_access_clipboard')
c.aliases['canvas-disable'] = disable('content.canvas_reading')
c.aliases['canvas-enable'] = enable('content.canvas_reading')
c.aliases['webgl-disable'] = disable('content.webgl')
c.aliases['webgl-enable'] = enable('content.webgl')
c.aliases['location-disable'] = disable('content.geolocation')
c.aliases['location-enable'] = enable('content.geolocation', ask=True)

# Incognito identity switch
c.aliases['change-identity'] = compose('config-source', c.aliases['tor-change'])

def set_incognito(mode):
    tor = 'enable' if mode else 'disable'
    features = 'disable' if mode else 'enable'
    return compose(
        'config-source',
        c.aliases['tor-' + tor],
        c.aliases['clipboard-' + features],
        c.aliases['location-' + features],
        c.aliases['canvas-' + features],
        c.aliases['webgl-' + features],
    )

c.aliases['incognito-enable'] = set_incognito(True)
c.aliases['incognito-disable'] = set_incognito(False)


c.aliases['ask-useragent'] = 'spawn --userscript pick_useragent'

