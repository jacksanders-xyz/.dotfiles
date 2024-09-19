config.load_autoconfig(False)

config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')
config.set('content.headers.accept_language', '', 'https://matchmaker.krunker.io/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:90.0) Gecko/20100101 Firefox/90.0', 'https://accounts.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36', 'https://www.youtube.com/*')
config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')
config.set('content.javascript.clipboard', 'access', 'https://www.youtube.com/*')
config.set('content.javascript.clipboard', 'access', 'https://accounts.google.com/*')
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')
config.set('content.javascript.enabled', True, 'https://www.youtube.com/*')
c.content.user_stylesheets = []
c.window.hide_decoration = False
c.colors.webpage.preferred_color_scheme = 'dark'
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
config.load_autoconfig()
import dracula.draw
dracula.draw.blood(c, {
    'spacing': {
        'vertical': 1,
        'horizontal': 2
    }
})

config.bind('<<', ':tab-move -')
config.bind('>>', ':tab-move +')
config.bind('<Ctrl+c>', 'clear-keychain ;; search ;; fullscreen --leave')
config.bind('<Ctrl+e>', 'scroll-page 0 0.3')
config.bind('<Ctrl+y>', 'scroll-page 0 -0.3')
config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')
config.bind('yt', 'tab-clone')
config.bind("<Ctrl-p>", "fake-key <Up>", "insert")
config.bind("<Ctrl-n>", "fake-key <Down>", "insert")
config.bind("<Ctrl-w>", "fake-key <Alt-Backspace>", "insert")

# Ensure Widevine is enabled
c.qt.args += ["--enable-widevine"]
c.qt.args += ["--widevine-path=~/.local/lib/WidevineCdm"]
# Enable experimental features
c.qt.args += ["--enable-features=WebRtcHideLocalIpsWithMdns"]
c.qt.args += ["--enable-features=OverlayScrollbars"]
