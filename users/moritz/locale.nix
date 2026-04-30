{ config, lib, myLib, ... }: {
 # 🌍 hardened LOCALE (hardened Identity)
 # Decoupled locale settings for user 'moritz'.

 i18n.defaultLocale = myLib.mkTracedOption "SRC-CHAT-LOCALE-001" (lib.mkOption {
 type = lib.types.str;
 default = "de_DE.UTF-8";
 description = "System default locale [Source: Fragment 002]";
 }).default;

 time.timeZone = myLib.mkTracedOption "SRC-CHAT-LOCALE-002" (lib.mkOption {
 type = lib.types.str;
 default = "Europe/Berlin";
 description = "System timezone [Source: Fragment 002]";
 }).default;

 console.keyMap = myLib.mkTracedOption "SRC-CHAT-LOCALE-003" (lib.mkOption {
 type = lib.types.str;
 default = "de-latin1";
 description = "Console keymap [Source: Fragment 002]";
 }).default;

 # Standardisierte Locale-Settings
 i18n.extraLocaleSettings = {
 LC_ADDRESS = "de_DE.UTF-8";
 LC_IDENTIFICATION = "de_DE.UTF-8";
 LC_MEASUREMENT = "de_DE.UTF-8";
 LC_MONETARY = "de_DE.UTF-8";
 LC_NAME = "de_DE.UTF-8";
 LC_NUMERIC = "de_DE.UTF-8";
 LC_PAPER = "de_DE.UTF-8";
 LC_TELEPHONE = "de_DE.UTF-8";
 LC_TIME = "de_DE.UTF-8";
 };
}
