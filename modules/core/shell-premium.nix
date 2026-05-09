{ config, lib, pkgs, ... }:
let
 # 🚀 NMS v4.2 Metadaten (hardened Cockpit)
 nms = {
 id = "NIXH-00-COR-029";
 title = "Shell Premium (M1 Abrams Edition)";
 description = "Hardened and optimized shell environment with Caddy health-checks and fastfetch reporting.";
 layer = 00;
 nixpkgs.category = "system/settings";
 capabilities = [ "shell/premium" "observability/motd" "system/status-checker" ];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 source_repo = "grapefruit89/mynixos";
 };

 user = config.my.configs.identity.user;
 domain = config.my.configs.identity.domain;
 
 # 📊 Fastfetch: hardened Dashboard
 fastfetchConfig = pkgs.writeText "fastfetch-homelab.jsonc" (builtins.toJSON {
 logo = { source = "nixos"; padding = { top = 1; left = 2; }; };
 display = { separator = " ➜ "; color = { keys = "blue"; title = "green"; }; };
 modules = [
 { type = "title"; format = "{user-name}@{host-name}"; } "separator"
 { type = "os"; key = "OS"; } { type = "kernel"; key = "Kernel"; } { type = "uptime"; key = "Uptime"; }
 { type = "packages"; key = "Pkgs"; } { type = "shell"; key = "Shell"; } "break"
 { type = "cpu"; key = "CPU"; } { type = "gpu"; key = "GPU"; } { type = "memory"; key = "Mem"; }
 { type = "disk"; key = "Disk (/)"; folders = "/"; } "break"
 { type = "localip"; key = "LAN"; compact = true; }
 { type = "custom"; format = "https://${domain}"; key = "Base"; }
 { type = "custom"; format = "https://admin.${domain}"; key = "Admin"; } "break" "colors"
 ];
 });
 
 # 🔧 Health-Check (Aligned with Layer 10/20/30)
 serviceStatusScript = pkgs.writeShellScriptBin "check-services" ''
 #!/usr/bin/env bash
 # Services aus 10-gtw, 20-infra, 30-media
 CRITICAL_SERVICES=("sshd:SSH" "caddy:Proxy" "tailscaled:VPN" "jellyfin:Jellyfin" "postgresql:Database")
 echo -e "\n🛡️ hardened Service Status:\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
 for entry in "''${CRITICAL_SERVICES[@]}"; do
 service="''${entry%%:*}"; label="''${entry##*:}"
 if systemctl is-active --quiet "$service"; then
 echo -e " ✅ \e[32m$label\e[0m"
 else
 echo -e " ❌ \e[31m$label (DOWN!)\e[0m"
 fi
 done
 echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
 '';
in
{
 options.my.meta.shell_premium = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for shell-premium module";
 };

 config = lib.mkIf (config.my.shell.premium.enable && user == "moritz") {
 # 🏎️ Essential Aliases (The Workflow)
 programs.bash.shellAliases = {
 # Nix-Rebuild shortcuts
 nsw = "sudo nixos-rebuild switch --flake .#nixhome";
 ntest = "sudo nixos-rebuild test --flake .#nixhome";
 ndry = "sudo nixos-rebuild dry-run --flake .#nixhome";
 
 # Maintenance
 nup = "nix flake update";
 nclean = "sudo nix-collect-garbage --delete-older-than 14d && sudo nix-store --optimise";
 nopt = "sudo nix-store --optimise";
 nlog = "journalctl -xef";
 
 # Modern Tooling (hardened)
 ls = "${pkgs.eza}/bin/eza --icons";
 ll = "${pkgs.eza}/bin/eza -la --icons --git";
 tree = "${pkgs.eza}/bin/eza --tree --icons";
 cat = "${pkgs.bat}/bin/bat --paging=never";
 sysinfo = "${pkgs.fastfetch}/bin/fastfetch --config ${fastfetchConfig}";
 services = "${serviceStatusScript}/bin/check-services";
 ports = "sudo ss -tulpn | grep LISTEN";
 
 # Git Shortcuts
 gs = "git status -sb";
 ga = "git add";
 gc = "git commit -m";
 gp = "git push";
 };
 
 # 🏁 Shell Init
 programs.bash.interactiveShellInit = ''
 # Don't run in non-interactive sessions
 if [[ $- == *i* ]]; then
 ${pkgs.fastfetch}/bin/fastfetch --config ${fastfetchConfig}
 ${serviceStatusScript}/bin/check-services
 echo "💡 Hint: 'nsw' to rebuild, 'nlog' for logs, 'services' for health."
 fi
 '';
 
 environment.systemPackages = with pkgs; [
 bat eza ripgrep fd duf dust htop btop
 nix-tree nix-diff nixfmt-classic nix-output-monitor
 fastfetch micro git curl wget tree serviceStatusScript
 ];
 };
}
