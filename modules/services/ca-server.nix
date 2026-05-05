{ config, pkgs, ... }: {
  # --- CA Server Service ---
  # Provides a minimalist web UI for signing TPM-based CSRs.
  
  systemd.services.ca-server = {
    description = "Dendritic Minimal CA Web UI";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    
    serviceConfig = {
      User = "ca-server";
      Group = "ca-server";
      WorkingDirectory = "/var/lib/ca-server";
      # 🚀 SOCKET-FIRST INGRESS via Gunicorn
      ExecStart = "${pkgs.python3.withPackages (ps: [ ps.flask ps.gunicorn ])}/bin/gunicorn --bind unix:/run/ca-server/ca.sock ca-server:app";
      Restart = "always";
      StateDirectory = "ca-server";
      RuntimeDirectory = "ca-server";
      RuntimeDirectoryMode = "0770";
      PrivateTmp = true;
      ProtectSystem = "strict";
      ReadWritePaths = "/var/lib/ca-server";
      # The CA Cert and Key are needed. Key is decrypted to /run/secrets/ca.key
      ReadOnlyPaths = [ "/etc/caddy/ca.crt" "/run/secrets/ca.key" ];
    };
    environment.variables.PYTHONPATH = "${./.}";
  };

  # Give Caddy access to the ca-server group to read the socket
  users.users.caddy.extraGroups = [ "ca-server" ];

  # Dependency for signing
  environment.systemPackages = [ pkgs.openssl ];

  users.users.ca-server = {
    isSystemUser = true;
    group = "ca-server";
  };
  users.groups.ca-server = {};

  # Ensure the CA key extraction service runs before ca-server
  # This assumes sops-nix is configured to decrypt 'ca-key' to /run/secrets/ca-keys.yaml
  systemd.services.ca-key-extract = {
    description = "Extract CA private key from sops secret";
    wantedBy = [ "ca-server.service" ];
    before = [ "ca-server.service" ];
    serviceConfig.Type = "oneshot";
    script = ''
      if [ -f /run/secrets/ca-keys.yaml ]; then
        ${pkgs.yq}/bin/yq -r '.ca' /run/secrets/ca-keys.yaml > /run/secrets/ca.key
        chown ca-server /run/secrets/ca.key
        chmod 400 /run/secrets/ca.key
      fi
    '';
  };
}
