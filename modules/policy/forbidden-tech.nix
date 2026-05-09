# modules/policy/forbidden-tech.nix
# =============================================================================
# NixHome FORBIDDEN TECHNOLOGY WARNINGS ONLY
# =============================================================================
# Diese Datei erzeugt AUSSCHLIESSLICH Warnungen im Build-Log.
# Sie bricht den Build NIEMALS ab.
# =============================================================================

{ config, lib, ... }:

let
  inherit (lib) mkOption types optionalString;

  forbiddenReasons = {
    secureBoot = "Secure Boot ist zu riskant. Fehler führen zu permanentem Lockout.";
    tailscale   = "Tailscale verursacht DNS-Probleme und schafft ungewollte Abhängigkeiten.";
    docker      = "Docker widerspricht dem NixOS-Prinzip. Native systemd-Services sind Pflicht.";
    mTLS-Admin  = "mTLS für Admin ist zu komplex. Chicken-and-Egg-Problem beim Erstzugriff.";
    lanzaboote  = "Lanzaboote wurde durch schlichtes systemd-boot ersetzt.";
    oliveTin    = "OliveTin hat Shell-Injection-Risiken. Wurde durch systemd-Oneshot-Units ersetzt.";
    fapolicyd   = "fapolicyd wurde nicht weiter verfolgt und wird nicht eingesetzt.";
    iptables    = "iptables ist veraltet. Ausschließlich nftables wird verwendet.";
    cron        = "cron ist veraltet. Ausschließlich systemd-Timer werden verwendet.";
    passwords   = "SSH-Passwort-Authentifizierung ist verboten. Nur hardware-gebundene Keys.";
    dockerSock  = "Der Zugriff auf docker.sock ist gleichbedeutend mit Root-Zugriff.";
  };

in {
  options.my.policy.forbidden = {
    secureBoot = mkOption { type = types.bool; default = false; };
    tailscale   = mkOption { type = types.bool; default = false; };
    docker      = mkOption { type = types.bool; default = false; };
    mTLS-Admin  = mkOption { type = types.bool; default = false; };
    lanzaboote  = mkOption { type = types.bool; default = false; };
    oliveTin    = mkOption { type = types.bool; default = false; };
    fapolicyd   = mkOption { type = types.bool; default = false; };
    iptables    = mkOption { type = types.bool; default = false; };
    cron        = mkOption { type = types.bool; default = false; };
    passwords   = mkOption { type = types.bool; default = false; };
    dockerSock  = mkOption { type = types.bool; default = false; };
  };

  config = {
    # =========================================================================
    # NUR WARNUNGEN – KEINE ASSERTIONS, KEIN BUILD-ABBRUCH
    # =========================================================================
    warnings = [
      # Secure Boot / Lanzaboote
      (optionalString (config.boot.lanzaboote.enable or false)
        "⚠️ [POL-001] Secure Boot/Lanzaboote ist NICHT ERWÜNSCHT! Grund: ${forbiddenReasons.secureBoot}")

      # Tailscale
      (optionalString (config.services.tailscale.enable or false)
        "⚠️ [POL-002] Tailscale ist NICHT ERWÜNSCHT! Grund: ${forbiddenReasons.tailscale}")

      # Docker
      (optionalString (config.virtualisation.docker.enable or false)
        "⚠️ [POL-003] Docker ist NICHT ERWÜNSCHT! Grund: ${forbiddenReasons.docker}")

      # iptables (wenn nftables nicht aktiv)
      (optionalString (!config.networking.nftables.enable)
        "⚠️ [POL-004] iptables ist NICHT ERWÜNSCHT! Bitte aktiviere nftables. Grund: ${forbiddenReasons.iptables}")

      # cron
      (optionalString (config.services.cron.enable or false)
        "⚠️ [POL-005] cron ist NICHT ERWÜNSCHT! Bitte nutze systemd-Timer. Grund: ${forbiddenReasons.cron}")

      # SSH-Passwörter
      (optionalString (config.services.openssh.settings.PasswordAuthentication or true)
        "⚠️ [POL-006] SSH-Passwort-Authentifizierung ist NICHT ERWÜNSCHT! Grund: ${forbiddenReasons.passwords}")

      # OliveTin
      (optionalString (config.services.olivetin.enable or false)
        "⚠️ [POL-WARN] OliveTin ist NICHT ERWÜNSCHT! Grund: ${forbiddenReasons.oliveTin}")

      # fapolicyd
      (optionalString (config.services.fapolicyd.enable or false)
        "⚠️ [POL-WARN] fapolicyd ist NICHT ERWÜNSCHT! Grund: ${forbiddenReasons.fapolicyd}")
    ];
  };
}
