# Cluster 40: Storage Strategy

### Inhalt aus `GUIDE-ABC-Storage-Tiering.md`

---
title: 🏗️ ABC-Storage-Tiering (The Hybrid ZFS + MergerFS Standard)
category: architecture/storage
status: [ACTIVE-SSoT]
capabilities: [zfs-integrity, mergerfs-flexibility, hybrid-pooling, snapraid-parity]
sources: [https://perfectmediaserver.com/02-tech-stack/nixos/]
---

# 🏗️ ABC-Storage-Tiering: Das Hybride Storage-Manifest

Dieses System kombiniert das Beste aus zwei Welten: Die absolute Datensicherheit von ZFS und die einfache Skalierbarkeit von MergerFS.

## 🔴 Tier A: Critical Data (ZFS Native)
- **Inhalt:** Unersetzbare Daten (Fotos, Dokumente, Sops-Secrets, DBs).
- **Technik:** ZFS Mirror oder RaidZ.
- **Vorteil:** Schutz vor Bit-Rot, atomare Snapshots, einfache Remote-Replikation via Syncoid.

## 🔵 Tier C: Bulk Media (MergerFS + SnapRAID)
- **Inhalt:** Ersetzbare Medien (Linux ISOs, Filme, Serien).
- **Technik:** MergerFS pooling von Mismatch-Drives + SnapRAID Parität.
- **Vorteil:** Kosteneffizient, jede Platte einzeln lesbar, kein Rebuild-Stress.

## 🧩 Die Hybride Synthese (The Master Mount)
Wir mergen die ZFS-Datasets und die JBOD-Platten zu einem einzigen logischen Pfad (`/mnt/storage`).

### NixOS Implementierung:
```nix
fileSystems."/mnt/storage" = {
  # Wir kombinieren die JBOD-Disks und das ZFS-Dataset "fuse"
  device = "/mnt/disk*:/mnt/tank/fuse";
  fsType = "fuse.mergerfs";
  options = [
    "defaults"
    "allow_other"
    "use_ino"
    "cache.files=off"
    "moveonenospc=true"
    "category.create=mfs" # Füllt alle Platten gleichmäßig
    "dropcacheonclose=true"
    "minfreespace=250G"
  ];
};
```

## 🛡️ SRE-Regeln für das Tiering
1.  **Naming-Isolation:** Halte Ordnernamen auf ZFS und JBOD eindeutig, damit MergerFS weiß, wo neue Dateien landen sollen (Create-Policy-Logic).
2.  **SnapRAID-Sync:** Ein täglicher systemd-Timer triggert den SnapRAID-Sync für den JBOD-Teil (Tier C).
3.  **Sanoid-Snapshots:** ZFS-Datasets (Tier A) werden stündlich via Sanoid gesichert.

---

### Inhalt aus `GUIDE-Data-Deduplication-SRE.md`

---
title: 🧹 Data Deduplication & Hygiene (Layer 80-monitoring)
category: architecture/storage
status: [ACTIVE-SSoT]
capabilities: [duplicate-finding, storage-optimization, headless-hygiene]
sources: [rclone dedupe docs, SRE Storage Patterns]
---

# 🧹 Daten-Hygiene: Krieg den Duplikaten

In mynixos verzichten wir auf grafische Tools wie dupeguru. Wir nutzen hocheffiziente CLI-Werkzeuge, um den Speicherplatz auf Tier C (HDDs) zu optimieren.

## 🏛️ 1. Die SSoT-Lösung: rclone dedupe
Für das Finden und Löschen von identischen Dateien in deinem Medien-Pool.
- **Befehl:** `rclone dedupe /mnt/storage/media`
- **Modi:**
    - `interactive`: Fragt bei jedem Fund nach.
    - `first`: Behält die erste Datei (schnell).
    - `newest`: Behält die neueste Datei.
    - `largest`: Behält die größte Datei.

## ⚡ 2. Warum rclone statt dupeguru?
- **Headless:** Läuft perfekt via SSH. ✅
- **Cloud-Ready:** Funktioniert auch auf deinen S3-Buckets (Garage) oder Cloud-Backups. ✅
- **Efficiency:** Verbraucht minimal RAM im Vergleich zu Qt-basierten Apps.

## ⚙️ 3. Automatisierung (SRE-Weg)
Wir können `rclone dedupe --dry-run` als monatlichen systemd-Timer (Layer 80) einrichten, der uns via Matrix (Kapitel 20) informiert, wenn signifikante Mengen an Duplikaten gefunden wurden.

## 🚀 SRE-Vorteil
Das System bleibt sauber und folgt dem **Headless-Gesetz (ADR-010)**.

---

### Inhalt aus `GUIDE-Pro-Backup-Strategies.md`

---
title: 🛡️ Pro-Backup & Storage Patterns (Aviation-Grade)
category: architecture/storage
status: [ACTIVE-SSoT]
capabilities: [ransomware-protection, cloud-mounts, append-only-backups]
sources: [https://github.com/restic/rest-server, https://github.com/rclone/rclone]
---

# 🛡️ Pro-Backup: Die Festung für deine Daten

Wir nutzen die Strategien der Profis, um Datenverlust physisch unmöglich zu machen.

## 🏛️ 1. Ransomware-Schutz via Rest-Server
Der Tower agiert als Restic-Ziel für alle deine Geräte.
- **Dienst:** `services.restic.rest-server.enable = true;`
- **Pattern:** Wir nutzen den `--append-only` Modus. Clients dürfen neue Daten schreiben, aber niemals alte Daten löschen oder überschreiben.
- **SRE-Sicherheit:** Selbst ein kompromittiertes Endgerät kann deine Backup-Historie nicht zerstören.

## ☁️ 2. Cloud-Mounting (The Rclone VFS Standard)
Für den Zugriff auf Tier-C Daten in der Cloud (z.B. S3/B2) nutzen wir optimierte Mount-Flags:
```bash
rclone mount remote:bucket /mnt/cloud \
  --vfs-cache-mode full \
  --vfs-cache-max-age 24h \
  --dir-cache-time 1000h \
  --attr-timeout 1000h
```
- **Vorteil:** Minimale API-Calls (Kostenersparnis) und sofortiger Start von Medien-Streams.

## 🔄 3. Rsync Atomic Sync
Für lokale Migrationen zwischen Platten nutzen wir:
```bash
rsync -av --inplace --sparse --progress /src /dest
```
- **Vorteil:** Schont den ZFS-ARC und ist effizient bei großen Mediendateien.

---

### Inhalt aus `GUIDE-S3-Object-Vault-Garage.md`

---
title: 📦 S3 Object Vault (Garage HQ)
category: architecture/storage
status: [ACTIVE-SSoT]
capabilities: [s3-compatible, distributed-storage, rust-efficiency, tiered-metadata]
sources: [https://github.com/deuxfleurs/garage, official nixpkgs modules]
---

# 📦 Garage: Dein privates S3-Rechenzentrum

In mynixos ist Garage der Standard für objektbasierten Speicher. Er ist die ideale Ergänzung zu ZFS/MergerFS für Anwendungen, die eine S3-API benötigen.

## 🏛️ Architektur-Entscheidungen (Tiered Mastery)
1.  **Metadata Layer:** Liegt zwingend auf Tier A (NVMe ZFS Mirror). ✅
2.  **Data Layer:** Liegt auf Tier C (HDD SnapRAID/MergerFS). ✅
3.  **Sprache:** Rust (Efficiency Mandate erfüllt). ✅

## ⚙️ Deklarative Nix-Konfiguration
Hier ist das Muster für deinen Dendriten (`modules/20-server/storage-s3.nix`):

```nix
services.garage = {
  enable = true;
  settings = {
    metadata_dir = "/persist/var/lib/garage/meta"; # Tier A
    data_dir = "/mnt/storage/garage/data";        # Tier C
    rpc_bind_addr = "[::]:3901";
    s3_api = {
      s3_region = "mynixos-local";
      api_bind_addr = "[::]:3900";
    };
  };
};
```

## 🛡️ SRE-Hardening
- **Access Control:** Wir nutzen `garage key create` für dedizierte S3-Keys pro Dienst (z.B. für Restic-Backups von anderen Geräten).
- **Ingress:** Sicherung der S3-API via Caddy über `s3.m7c5.de` mit mTLS für externe Zugriffe.

---

### Inhalt aus `GUIDE-Binary-Cache-Optimization.md`

---
title: 📦 Binary Cache Optimization (The 82% Saving)
category: architecture/storage
status: [PROPOSED]
capabilities: [binary-deduplication, git-backed-cache, storage-efficiency]
sources: [r/Nix, Nix Binary Cache Patterns 2026]
---

# 📦 Binary-Optimierung: Jedes Byte zählt

In mynixos ist der Speicherplatz auf Tier A (NVMe) kostbar. Wir nutzen moderne Deduplizierungs-Strategien, um den State unter 10GB zu halten.

## 🏛️ 1. Das Git-Backed Cache Konzept
Anstatt fertige Pakete einfach nur zu kopieren, nutzen wir ein Git-ähnliches Content-Addressing.
- **Nugget:** Identische Fragmente von Binaries (z.B. Library-Abhängigkeiten) werden nur einmal gespeichert.
- **Ergebnis:** Bis zu 82% weniger Platzverbrauch für deine lokalen Builds. ✅

## ⚙️ 2. Implementierung (SRE-Workflow)
Wir nutzen den Tower als lokalen Build-Server und optimieren den Store:
```bash
# Manuelle Store-Optimierung
nix-store --optimize
# Aktivierung der automatischen Optimierung
nix.settings.auto-optimise-store = true;
```

## 🔄 3. Offsite-Brücke
Durch die Reduzierung der Cache-Größe wird unser Cloud-Sync (Kapitel 80) massiv beschleunigt. Ein 10GB State wird so zu einem ~2GB Transfer-Paket.

## 🚀 SRE-Vorteil
Weniger I/O-Last schont deine NVMe und macht das Disaster Recovery (ADR-015) extrem schnell. Inmynixos ist Effizienz kein Zufall, sondern das Ergebnis von Deduplizierung.

---

### Inhalt aus `GUIDE-Future-Storage-Scaling.md`

---
title: 🚀 Future Storage Scaling (Tier C Evolution)
category: architecture/storage
status: [PROPOSED]
capabilities: [bitrot-protection, multi-tb-scaling, cow-filesystems, bcachefs-audit]
sources: [Linux Kernel Mailing List, Linus Torvalds Rants, Bcachefs Docs]
---

# 🚀 Skalierung: Der Weg über 5TB

Wenn dein Datenbestand auf Tier C (Medien) die 5TB Grenze überschreitet, reicht ext4 + Scrubbing nicht mehr aus. Wir planen den Umstieg auf ein modernes CoW (Copy-on-Write) Dateisystem.

## 🏛️ 1. Die Kandidaten für Tier C (Medien-Pool)

### A. Btrfs (Der vernünftige Standard)
- **Vorteil:** Nativ im Kernel, beherrscht Checksummen gegen Bitrot, unterstützt Kompression (spart Platz) und erlaubt HDD-Spindown.
- **SRE-Status:** Aviation-Grade Ready. ✅

### B. Bcachefs (Das "Rage" Dateisystem)
- **Hintergrund:** Von Linus Torvalds massiv kritisiert wegen des unsauberen Entwicklungsprozesses ("beyond ridiculous").
- **Vorteil:** Kombiniert die Performance von XFS mit der Integrität von ZFS und integriertem SSD-Caching.
- **SRE-Status:** **Bleeding Edge.** Nur für SREs, die bereit sind, Kernel-Bugs zu jagen. Momentan NICHT für Produktivdaten empfohlen. ❌

## ⚙️ 2. Zukunfts-Architektur (v9.0 Vision)
- **Tier A (NVMe):** ZFS (Single Node).
- **Tier C (HDDs):** Btrfs RAID-0 oder Einzel-Disks mit globalen Checksummen.
- **Migration:** Daten werden via `rclone` oder `rsync --inplace` (Kapitel 50) atomar umgezogen.

## 🛡️ SRE-Fazit
Wir priorisieren **Integrität vor Watt**, sobald die Datenmenge kritisch wird. Btrfs ist der sicherste nächste Schritt. Bcachefs bleibt im Monitoring-Status.

---

### Disaster Recovery

This guide provides step-by-step instructions for recovering the system from a total hardware failure or catastrophic data loss.

## 📦 Backup Sources
1.  **Local Archive:** `/mnt/archive/.restic-vault` (SSD/HDD)
2.  **Remote Cloud:** Backblaze B2 (Bucket: `nixhome-backup`)

## 🛠️ Recovery Scenarios

### Scenario 1: Reinstalling on New Hardware
1.  **Flash NixOS:** Use a standard NixOS Flake installer.
2.  **Clone Repo:** `git clone https://github.com/grapefruit89/mynixos-v5.git`
3.  **Restore Secrets:**
    -   You need your `age` master key or the original `secrets.yaml` source.
    -   If the `age` key is lost, you MUST use your emergency backup key from Tier B (if accessible).
4.  **Initial Build:** `nixos-rebuild switch --flake .#nixhome`

### Scenario 2: Restoring Persistent Data (/persist)
If the NVMe drive failed but the backup is safe:
1.  **Install Restic:** `nix-shell -p restic`
2.  **Configure B2 Credentials:**
    ```bash
    export B2_ACCOUNT_ID="<your-id>"
    export B2_ACCOUNT_KEY="<your-key>"
    export RESTIC_REPOSITORY="s3:s3.eu-central-003.backblazeb2.com/nixhome-backup"
    export RESTIC_PASSWORD_FILE="/path/to/restic-password"
    ```
3.  **Restore Files:**
    ```bash
    restic restore latest --target /
    ```
4.  **Reboot:** Since the root is stateless, the restored `/persist` will be picked up automatically.

### Scenario 3: Restoring Pocket-ID Database
Pocket-ID state is stored in `/var/lib/pocket-id` (persisted).
1.  Stop the service: `systemctl stop pocket-id`
2.  Restore the directory from restic (see Scenario 2).
3.  Fix permissions: `chown -R pocket-id:pocket-id /var/lib/pocket-id`
4.  Start the service: `systemctl start pocket-id`

## 🛡️ Verification
-   Check logs: `journalctl -u restic-backups-daily`
-   Verify Gatus dashboard for service health.

---

### Pro-Tools: Attic & Aria2 (Layer 80/20)

In mynixos nutzen wir spezialisierte Dienste für maximale Effizienz.

## ⚙️ Attic: Der Binär-Cache (Layer 80)
Attic erlaubt es uns, Build-Artefakte zwischen Tower und Clients zu teilen.
```nix
services.atticd = {
  enable = true;
  settings = {
    database.url = "postgres:///atticd";
    storage.type = "s3"; # Oder local
  };
};
```

## 📥 Aria2: Pro-Downloader (Layer 20)
Ein hocheffizienter Daemon für alle Download-Arten.
```nix
services.aria2 = {
  enable = true;
  settings = {
    rpc-listen-port = 6800;
    rpc-secret = "@ARIA_KEY@";
  };
};
```


---
### Inhalt aus MASTER-CONFIG-RCLONE.md
---
title: ðŸ“š Rclone MASTER-VARIABLE-LIST (v1.0)
category: architecture/reference
status: [ACTIVE-SSoT]
capabilities: [cloud-sync, multi-provider, vfs-cache, performance-tuning]
sources: [https://github.com/rclone/rclone (Code Extraction)]
---

# ðŸ“š Rclone: Die Cloud-Schnittstelle

Rclone bietet hunderte Variablen zur Optimierung des Datentransfers.

RCLONE_ALIAS_DESCRIPTION
RCLONE_ALIAS_REMOTE
RCLONE_ARCHIVE_DESCRIPTION
RCLONE_ARCHIVE_REMOTE
RCLONE_AUTH_KEY
RCLONE_AZUREBLOB_ACCESS_TIER
RCLONE_AZUREBLOB_ACCOUNT
RCLONE_AZUREBLOB_ARCHIVE_TIER_DELETE
RCLONE_AZUREBLOB_CHUNK_SIZE
RCLONE_AZUREBLOB_CLIENT_CERTIFICATE_PASSWORD
RCLONE_AZUREBLOB_CLIENT_CERTIFICATE_PATH
RCLONE_AZUREBLOB_CLIENT_ID
RCLONE_AZUREBLOB_CLIENT_SECRET
RCLONE_AZUREBLOB_CLIENT_SEND_CERTIFICATE_CHAIN
RCLONE_AZUREBLOB_CONNECTION_STRING
RCLONE_AZUREBLOB_COPY_CONCURRENCY
RCLONE_AZUREBLOB_COPY_CUTOFF
RCLONE_AZUREBLOB_DELETE_SNAPSHOTS
RCLONE_AZUREBLOB_DESCRIPTION
RCLONE_AZUREBLOB_DIRECTORY_MARKERS
RCLONE_AZUREBLOB_DISABLE_CHECKSUM
RCLONE_AZUREBLOB_DISABLE_INSTANCE_DISCOVERY
RCLONE_AZUREBLOB_ENCODING
RCLONE_AZUREBLOB_ENDPOINT
RCLONE_AZUREBLOB_ENV_AUTH
RCLONE_AZUREBLOB_KEY
RCLONE_AZUREBLOB_LIST_CHUNK
RCLONE_AZUREBLOB_MEMORY_POOL_FLUSH_TIME
RCLONE_AZUREBLOB_MEMORY_POOL_USE_MMAP
RCLONE_AZUREBLOB_MSI_CLIENT_ID
RCLONE_AZUREBLOB_MSI_MI_RES_ID
RCLONE_AZUREBLOB_MSI_OBJECT_ID
RCLONE_AZUREBLOB_NO_CHECK_CONTAINER
RCLONE_AZUREBLOB_NO_HEAD_OBJECT
RCLONE_AZUREBLOB_PASSWORD
RCLONE_AZUREBLOB_PUBLIC_ACCESS
RCLONE_AZUREBLOB_SAS_URL
RCLONE_AZUREBLOB_SERVICE_PRINCIPAL_FILE
RCLONE_AZUREBLOB_TENANT
RCLONE_AZUREBLOB_UPLOAD_CONCURRENCY
RCLONE_AZUREBLOB_UPLOAD_CUTOFF
RCLONE_AZUREBLOB_USE_AZ
RCLONE_AZUREBLOB_USE_COPY_BLOB
RCLONE_AZUREBLOB_USE_EMULATOR
RCLONE_AZUREBLOB_USE_MSI
RCLONE_AZUREBLOB_USERNAME
RCLONE_AZUREFILES_ACCOUNT
RCLONE_AZUREFILES_CHUNK_SIZE
RCLONE_AZUREFILES_CLIENT_CERTIFICATE_PASSWORD
RCLONE_AZUREFILES_CLIENT_CERTIFICATE_PATH
RCLONE_AZUREFILES_CLIENT_ID
RCLONE_AZUREFILES_CLIENT_SECRET
RCLONE_AZUREFILES_CLIENT_SEND_CERTIFICATE_CHAIN
RCLONE_AZUREFILES_CONNECTION_STRING
RCLONE_AZUREFILES_DESCRIPTION
RCLONE_AZUREFILES_DISABLE_INSTANCE_DISCOVERY
RCLONE_AZUREFILES_ENCODING
RCLONE_AZUREFILES_ENDPOINT
RCLONE_AZUREFILES_ENV_AUTH
RCLONE_AZUREFILES_KEY
RCLONE_AZUREFILES_MAX_STREAM_SIZE
RCLONE_AZUREFILES_MSI_CLIENT_ID
RCLONE_AZUREFILES_MSI_MI_RES_ID
RCLONE_AZUREFILES_MSI_OBJECT... (GekÃ¼rzt fÃ¼r Ãœbersicht)

## ðŸš€ SRE-Anwendung
In NixOS nutzen wir Rclone primÃ¤r als BrÃ¼cke fÃ¼r Restic. Die Variablen werden via \`services.restic.backups.<name>.rcloneConfig\` gesetzt.

---
### Inhalt aus MASTER-CONFIG-RESTIC.md
---
title: ðŸ“š Restic MASTER-VARIABLE-LIST (v1.0)
category: architecture/reference
status: [ACTIVE-SSoT]
capabilities: [encrypted-backup, deduplication, cloud-storage, automation]
sources: [https://github.com/restic/restic (Code Extraction)]
---

# ðŸ“š Restic: Konfigurations-Referenz

Diese Variablen steuern das Verhalten von Restic und kÃ¶nnen in NixOS via \`services.restic.backups.<name>.extraOptions\` oder \`EnvironmentFile\` genutzt werden.

RESTIC_ACTIVE_HELP
RESTIC_AWS_ASSUME_ROLE_ARN
RESTIC_AWS_ASSUME_ROLE_EXTERNAL_ID
RESTIC_AWS_ASSUME_ROLE_POLICY
RESTIC_AWS_ASSUME_ROLE_REGION
RESTIC_AWS_ASSUME_ROLE_SESSION_NAME
RESTIC_AWS_ASSUME_ROLE_STS_ENDPOINT
RESTIC_AZURE_TEST_LARGE_UPLOAD
RESTIC_BAR
RESTIC_BENCH_DIR
RESTIC_CACERT
RESTIC_CACHE_DIR
RESTIC_COMPRESSION
RESTIC_DEBUG_STACKTRACE_SIGINT
RESTIC_FEATURES
RESTIC_FROM_KEY_HINT
RESTIC_FROM_PASSWORD
RESTIC_FROM_PASSWORD_COMMAND
RESTIC_FROM_PASSWORD_FILE
RESTIC_FROM_REPOSITORY
RESTIC_FROM_REPOSITORY_FILE
RESTIC_HOST
RESTIC_HTTP_USER_AGENT
RESTIC_KEY_HINT
RESTIC_KEY_HINT2
RESTIC_PACK_SIZE
RESTIC_PASSWORD
RESTIC_PASSWORD2
RESTIC_PASSWORD_COMMAND
RESTIC_PASSWORD_COMMAND2
RESTIC_PASSWORD_FILE
RESTIC_PASSWORD_FILE2
RESTIC_PROGRESS_FPS
RESTIC_READ_CONCURRENCY
RESTIC_REPOSITORY
RESTIC_REPOSITORY2
RESTIC_REPOSITORY_FILE
RESTIC_REPOSITORY_FILE2
RESTIC_REST_PASSWORD
RESTIC_REST_USERNAME
RESTIC_TEST_
RESTIC_TEST_AZURE_ACCOUNT_KEY
RESTIC_TEST_AZURE_ACCOUNT_NAME
RESTIC_TEST_AZURE_ACCOUNT_SAS
RESTIC_TEST_AZURE_CONTAINER_SAS
RESTIC_TEST_AZURE_REPOSITORY
RESTIC_TEST_B2_ACCOUNT_ID
RESTIC_TEST_B2_ACCOUNT_KEY
RESTIC_TEST_B2_REPOSITORY
RESTIC_TEST_CLEANUP
RESTIC_TEST_DISALLOW_SKIP
RESTIC_TEST_FUSE
RESTIC_TEST_GS_APPLICATION_CREDENTIALS_B64
RESTIC_TEST_GS_PROJECT_ID
RESTIC_TEST_GS_REPOSITORY
RESTIC_TEST_INTEGRATION
RESTIC_TEST_OS_AUTH_URL
RESTIC_TEST_OS_PASSWORD
RESTIC_TEST_OS_REGION_NAME
RESTIC_TEST_OS_TENANT_NAME
RESTIC_TEST_OS_USERNAME
RESTIC_TEST_PASSWORD
RESTIC_TEST_PATH
RESTIC_TEST_REPO
RESTIC_TEST_REST_REPOSITORY
RESTIC_TEST_REST_SERVER
RESTIC_TEST_S3_KEY
RESTIC_TEST_S3_REPOSITORY
RESTIC_TEST_S3_SECRET
RESTIC_TEST_S3_SERVER
RESTIC_TEST_SFTPPATH
RESTIC_TEST_SWIFT
RESTIC_TEST_TMPDIR
RESTIC_TLS_CLIENT_CERT

## ðŸš€ SRE-Anwendung
Der Standard fÃ¼r mynixos ist:
- **Repository:** \`rclone:remote:path\`
- **Password:** Via Sops-Nix injiziert.
- **Pruning:** Automatisiert Ã¼ber den systemd-Timer.

---
### Inhalt aus DISASTER_RECOVERY.md
# ðŸš¨ Disaster Recovery Runbook (NixHome v6.0)

This guide provides step-by-step instructions for recovering the system from a total hardware failure or catastrophic data loss.

## ðŸ“¦ Backup Sources
1.  **Local Archive:** `/mnt/archive/.restic-vault` (SSD/HDD)
2.  **Remote Cloud:** Backblaze B2 (Bucket: `nixhome-backup`)

## ðŸ› ï¸ Recovery Scenarios

### Scenario 1: Reinstalling on New Hardware
1.  **Flash NixOS:** Use a standard NixOS Flake installer.
2.  **Clone Repo:** `git clone https://github.com/grapefruit89/mynixos-v5.git`
3.  **Restore Secrets:**
    -   You need your `age` master key or the original `secrets.yaml` source.
    -   If the `age` key is lost, you MUST use your emergency backup key from Tier B (if accessible).
4.  **Initial Build:** `nixos-rebuild switch --flake .#nixhome`

### Scenario 2: Restoring Persistent Data (/persist)
If the NVMe drive failed but the backup is safe:
1.  **Install Restic:** `nix-shell -p restic`
2.  **Configure B2 Credentials:**
    ```bash
    export B2_ACCOUNT_ID="<your-id>"
    export B2_ACCOUNT_KEY="<your-key>"
    export RESTIC_REPOSITORY="s3:s3.eu-central-003.backblazeb2.com/nixhome-backup"
    export RESTIC_PASSWORD_FILE="/path/to/restic-password"
    ```
3.  **Restore Files:**
    ```bash
    restic restore latest --target /
    ```
4.  **Reboot:** Since the root is stateless, the restored `/persist` will be picked up automatically.

### Scenario 3: Restoring Pocket-ID Database
Pocket-ID state is stored in `/var/lib/pocket-id` (persisted).
1.  Stop the service: `systemctl stop pocket-id`
2.  Restore the directory from restic (see Scenario 2).
3.  Fix permissions: `chown -R pocket-id:pocket-id /var/lib/pocket-id`
4.  Start the service: `systemctl start pocket-id`

## ðŸ›¡ï¸ Verification
-   Check logs: `journalctl -u restic-backups-daily`
-   Verify Gatus dashboard for service health.

