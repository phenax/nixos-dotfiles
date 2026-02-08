// Autoconfig

try {
pref('general.config.sandbox_enabled', false);
pref('general.config.obscure_value', 0);
pref('svg.context-properties.content.enabled', true);
lockPref('xpinstall.signatures.required', false);
lockPref('extensions.install_origins.enabled', false);
lockPref('extensions.experiments.enabled', true);
} catch (ex) { console.error(ex); };

// Setup user chrome support
try {
  const cmanifest = Services.dirsvc.get('UChrm', Ci.nsIFile);
  cmanifest.append('utils');
  cmanifest.append('chrome.manifest');
  Components.manager.QueryInterface(Ci.nsIComponentRegistrar).autoRegister(cmanifest);
} catch (ex) { console.error(ex); };

try {
  Services.scriptloader.loadSubScript('chrome://userchromejs/content/BootstrapLoader.js');
} catch (ex) { console.error(ex); };

try {
  Services.scriptloader.loadSubScript('chrome://userchromejs/content/userChrome.js');
} catch (ex) {};

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
