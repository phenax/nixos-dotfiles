// Autoconfig

try {
pref('general.config.sandbox_enabled', false);
pref('general.config.obscure_value', 0);
pref('svg.context-properties.content.enabled', true);
lockPref('xpinstall.signatures.required', false);
lockPref('extensions.install_origins.enabled', false);
lockPref('extensions.experiments.enabled', true);
} catch (ex) { console.error(ex); };

// Prefs
try {
pref('devtools.theme', 'dark');
pref('devtools.toolbox.alwaysOnTop', true);
pref('devtools.toolbox.host', 'window');
pref('devtools.chrome.enabled', true);
pref('devtools.debugger.remote-enabled', true);
pref('privacy.donottrackheader.enabled', true);
pref('identity.fxaccounts.toolbar.enabled', false);
} catch (ex) { console.error(ex); };
