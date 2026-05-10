# 🔐 Remote Admin SOP: SSH SOCKS5 Proxy

To maintain a zero-trust architecture, administrative services (Admin-Hangar zone) are restricted to the local network and the loopback interface. Remote access is achieved via a temporary, encrypted SSH tunnel using SOCKS5 dynamic port forwarding.

## 🚀 Initiation (Admin Workstation)

Run the following command to establish the tunnel. This requires your **YubiKey** for authentication.

```bash
# Command Format
ssh -D 9999 -N -i <path-to-your-sk-key> moritz@nix.m7c5.de -p 53844

# Breakdown:
# -D 9999: Creates a local SOCKS5 proxy on port 9999.
# -N: Do not execute a remote command (port forwarding only).
# -p 53844: The hardened high-port for SSH.
```

## 🌐 Browser Configuration

To access services through the tunnel, configure your browser to use the SOCKS5 proxy:

1. **Firefox (Recommended):**
   - Settings -> Network Settings -> Settings...
   - Select **Manual proxy configuration**.
   - **SOCKS Host:** `127.0.0.1` | **Port:** `9999`
   - Ensure **SOCKS v5** is selected.
   - Check **Proxy DNS when using SOCKS v5** (Critical for `*.nix.m7c5.de` resolution).

2. **Access:**
   - Navigate to any Admin service (e.g., `https://admin.nix.m7c5.de` for Cockpit).
   - The browser will route traffic through the server, appearing as a LAN request.

## 🛑 Termination

Simply close the SSH session (Ctrl+C). The proxy will be destroyed, and remote access to the Admin-Hangar is immediately revoked.
