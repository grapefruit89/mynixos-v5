# ---
# nms_id: APP-TOOLS-OLIVETIN
# title: OliveTin Web CLI
# capabilities: ["tools/cli"]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
{
  config,
  lib,
  pkgs,
  myLib,
  ...
}: let
  # 🚀 NMS v4.1 Metadaten
  nms = {
    id = "NIXH-30-AUT-005";
    title = "OliveTin (Hardened)";
    description = "Web-based control panel with strict sandboxing and secure command pinning.";
    layer = 30;
    nixpkgs.category = "web/apps";
    capabilities = ["automation/shell" "system/control-panel" "security/sandboxing"];
    audit.last_reviewed = "2026-04-30";
    audit.complexity = 2;
  };

  port = config.my.ports.olivetin;
  mtlsGenScript = "/etc/nixos/00-core/scripts/mtls-generator.sh";
  sopsScript = "/etc/nixos/00-core/scripts/add-sops-secret.sh";
in {
  options.my.meta.olivetin = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
    description = "NMS metadata for olivetin module";
  };

  config = lib.mkIf config.my.services.olivetin.enable (lib.mkMerge [
    # 🎬 1. AVIATION-GRADE SERVICE FABRIK
    (myLib.mkService {
      inherit config;
      name = "olivetin";
      port = port;
      useSSO = true;
      persist = true;
      description = "OliveTin Web CLI (Hardened)";
      extraServiceConfig = {
        # OliveTin needs specific path and sudo access
        Environment = "PATH=${lib.makeBinPath config.services.olivetin.path}:/run/wrappers/bin";
      };
    })

    # 🔧 2. OLIVETIN SPECIFICS
    {
      services.olivetin = {
        enable = true;
        path = with pkgs; [
          bash openssl jq coreutils gnused systemd
          nixos-rebuild nix-output-monitor curl sops
        ];
        settings = {
          ListenAddressSingleHTTPFrontend = "127.0.0.1:${toString port}";
          actions = [
            {
              title = "SOPS: Neues Secret";
              shell = "sudo ${sopsScript} '{{ secret_key }}' '{{ secret_value }}'";
              icon = "&#128272;";
              arguments = [ { name = "secret_key"; type = "ascii"; } { name = "secret_value"; type = "ascii"; } ];
            }
            {
              title = "mTLS: Client Zertifikat erstellen";
              shell = "sudo ${mtlsGenScript} '{{ client_name }}'";
              icon = "🔑";
              arguments = [ { name = "client_name"; type = "ascii"; } ];
            }
            {
              title = "System Update";
              shell = "sudo ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch 2>&1 | ${pkgs.nix-output-monitor}/bin/nom";
              icon = "&#128259;";
            }
          ];
        };
      };

      # 🛡️ PERMISSIONS
      security.sudo.extraRules = [
        {
          users = ["olivetin"];
          commands = [
            { command = "${pkgs.nixos-rebuild}/bin/nixos-rebuild"; options = ["NOPASSWD"]; }
            { command = mtlsGenScript; options = ["NOPASSWD"]; }
          ];
        }
      ];

      # Path Enforcement für Zertifikate
      systemd.tmpfiles.rules = [
        "d /var/www/landing-zone/certs 0755 caddy caddy -"
      ];
    }
  ]);
}
