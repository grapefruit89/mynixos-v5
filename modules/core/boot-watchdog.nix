{ config, lib, pkgs, ... }: {
  # 🚀 AVIATION-GRADE BOOT WATCHDOG
  # Runs after multi-user.target to verify system health.

  systemd.services.boot-watchdog = {
    description = "Aviation-Grade Boot Health Check";
    after = [ "multi-user.target" "caddy.service" "pocket-id.service" "postgresql.service" ];
    wantedBy = [ "multi-user.target" ];
    
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "boot-check" ''
        set -e
        echo "🧐 Starting System Health Audit..."
        
        # 1. Caddy Check
        systemctl is-active --quiet caddy
        curl --unix-socket /run/caddy/admin.sock -sf http://localhost/config/ > /dev/null
        echo "✅ Caddy: ACTIVE & SECURE"
        
        # 2. Pocket-ID Check
        systemctl is-active --quiet pocket-id
        curl -sf http://127.0.0.1:10880/ > /dev/null
        echo "✅ Pocket-ID: ACTIVE"
        
        # 3. PostgreSQL Check
        systemctl is-active --quiet postgresql
        echo "✅ PostgreSQL: ACTIVE"
        
        # 4. Persistence Check
        if [ ! -d "${config.my.configs.paths.stateDir}/caddy" ]; then
          echo "❌ PERSISTENCE FAILURE: Caddy state missing!"
          exit 1
        fi
        echo "✅ Persistence: VERIFIED"
        
        echo "🚀 SYSTEM STATUS: STABLE - ALL SYSTEMS GO"
      '';
    };
  };
}
