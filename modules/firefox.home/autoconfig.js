// Autoconfig

pref('general.config.sandbox_enabled', false);
pref('general.config.obscure_value', 0);
lockPref('xpinstall.signatures.required', false);
lockPref('extensions.install_origins.enabled', false);
lockPref("extensions.experiments.enabled", true);

// Setup user chrome support
try {
  const cmanifest = Services.dirsvc.get('UChrm', Ci.nsIFile);
  cmanifest.append('utils');
  cmanifest.append('chrome.manifest');
  Components.manager.QueryInterface(Ci.nsIComponentRegistrar).autoRegister(cmanifest);
} catch (ex) { };

try {
  Services.scriptloader.loadSubScript('chrome://userchromejs/content/BootstrapLoader.js');
} catch (ex) { };

try {
  ChromeUtils.import('chrome://userchromejs/content/userChrome.jsm');
} catch (ex) { };

