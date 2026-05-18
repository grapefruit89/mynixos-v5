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
