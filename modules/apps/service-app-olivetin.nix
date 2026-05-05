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
  ...
}: let
  # 🚀 NMS v4.1 Metadaten
  nms = {
    id = "NIXH-30-AUT-005";
    title = "OliveTin (SRE Exhausted)";
    description = "Web-based control panel with Wake-on-Access (Socket Activation) and secure command pinning.";
    layer = 30;
    nixpkgs.category = "web/apps";
    capabilities = ["automation/shell" "system/control-panel" "security/socket-activation"];
    audit.last_reviewed = "2026-03-03";
    audit.complexity = 2;
  };

  port = config.my.ports.olivetin;
  scriptDir = "/etc/nixos/modules/core/scripts";
  mtlsGenScript = "${scriptDir}/mtls-generator.sh";
  sopsScript = "${scriptDir}/add-sops-secret.sh";
  in {
  options.my.meta.olivetin = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
    description = "NMS metadata for olivetin module";
  };

  config = lib.mkIf config.my.services.olivetin.enable {
    services.olivetin = {
      enable = true;
      path = with pkgs; [
        bash
        openssl
        jq
        coreutils
        gnused
        systemd
        nixos-rebuild
        nix-output-monitor
        curl
        sops
      ];
      settings = {
        ListenAddressSingleHTTPFrontend = "127.0.0.1:${toString port}";
        actions = [
          {
            title = "mTLS: CSR signieren (Hardware-Key)";
            shell = "sudo ${mtlsGenScript} sign-csr '{{ client_name }}' '{{ csr_path }}'";
            icon = "🛡️";
            arguments = [
              {
                name = "client_name";
                type = "ascii";
              }
              {
                name = "csr_path";
                type = "ascii";
                description = "Pfad zum hochgeladenen .csr File";
              }
            ];
          }
          {
            title = "mTLS: Client Zertifikat erstellen (Legacy)";
            shell = "sudo ${mtlsGenScript} '{{ client_name }}'";
            icon = "🔑";
            arguments = [
              {
                name = "client_name";
                type = "ascii";
              }
            ];
          }
          {
            title = "System Update";
            shell = "sudo ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch 2>&1 | ${pkgs.nix-output-monitor}/bin/nom";
            icon = "🔄";
          }
        ];
      };
    };

    systemd.sockets.olivetin = {
      description = "OliveTin Socket";
      wantedBy = ["sockets.target"];
      listenStreams = [(toString port)];
    };

    systemd.services.olivetin = {
      wantedBy = lib.mkForce [];
      requires = ["olivetin.socket"];
      after = ["olivetin.socket"];
    };

    # 🛡️ PERMISSIONS
    security.sudo.extraRules = [
      {
        users = ["olivetin"];
        commands = [
          {
            command = "${pkgs.nixos-rebuild}/bin/nixos-rebuild";
            options = ["NOPASSWD"];
          }
          {
            command = mtlsGenScript;
            options = ["NOPASSWD"];
          }
        ];
      }
    ];

    # Path Enforcement für Zertifikate
    systemd.tmpfiles.rules = [
      "d /var/www/landing-zone/certs 0755 caddy caddy -"
    ];
  };
}
/**
* ---
 * technical_integrity:
 *   checksum: sha256:fc7921f933d43a7d565277141815729837a8dc7a55268f01c9f43de73d8de4ef
 *   eof_marker: NIXHOME_VALID_EOF* ---
*/

