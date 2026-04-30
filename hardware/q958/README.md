# 🦾 Fujitsu Esprimo Q958 (Hardware Silo)

This directory contains the "Hardware-Geist" (Physical Identity) of the Fujitsu Esprimo Q958 system.

## 📌 Hardware Specifications
- **CPU:** Intel Core i3-9100 (Coffee Lake / 4 Cores / 4 Threads)
- **GPU:** Intel UHD Graphics 630 (9.5th Gen)
- **Chipset:** Intel Q370
- **NIC:** Intel I219-LM (Gigabit)
- **Storage:** NVMe SSD + SATA AHCI
- **Sensor Chip:** Nuvoton NCT6775

## 🏗️ Architectural Decisions

### 1. Hardware/Logic Separation (Layer 01)
In accordance with **ADR-001 (Hardware-Geist Separation)**, all physical identifiers (UUIDs, PCIe paths, firmware) are isolated here. The Core logic (Layer 00) remains "pure" and hardware-agnostic.

### 2. Graphics & QuickSync (QSV)
- **Driver:** Using `intel-media-driver` (iHD) instead of the older `vaapi-intel` (i965) for modern Gen 9 support.
- **Firmware:** `i915.enable_guc=3` enables GuC/HuC loading, required for low-power HEVC decoding/encoding and hardware-accelerated scheduling.
- **Environment:** `LIBVA_DRIVER_NAME=iHD` is forced globally to ensure applications like Jellyfin use the modern VAAPI path.

### 3. Power Management & Stability
- **TLP & Thermald:** TLP handles the power profiles (set to `powersave` governor for intel_pstate), while Thermald prevents thermal throttling on the small form factor (SFF) chassis.
- **C-States:** `intel_idle.max_cstate=4` is used as a stability compromise. Deep C-states (C6/C7) can sometimes cause hangs on these Fujitsu boards during idle.
- **ASPM:** PCIe ASPM is enabled but set to `performance` on AC to prevent network/storage latency spikes.

### 4. Sensors & Monitoring
- **Module:** `nct6775` provides fan speed and voltage monitoring.
- **Kernel Fix:** `acpi_enforce_resources=lax` is required because the BIOS/ACPI reserves the sensor address space, preventing the Linux kernel driver from accessing it. This is safe on this specific Fujitsu hardware.

### 5. Storage
- **ZRAM:** Prioritized over physical swap to reduce SSD wear and improve responsiveness under OOM conditions.
- **Sysctl:** `vm.swappiness=10` ensures the system only swaps to ZRAM when absolutely necessary.

---
*Last Audit: 2026-04-27 | Status: hardened*
