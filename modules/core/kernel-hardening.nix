{ config, lib, pkgs, ... }: {
  # 🛡️ AVIATION-GRADE KERNEL HARDENING (NixHome v6.0)
  # Comprehensive module blacklist and sysctl hardening for Q958 Hardware.

  config = {
    # 🏎️ KERNEL PACKAGES (Latest Coffee Lake Support)
    boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

    # 🚫 MODULE BLACKLIST (Eliminating Attack Surface)
    boot.blacklistedKernelModules = [
      # 1. Audio (Complete elimination for headless server)
      "snd_hda_intel" "snd_hda_codec_realtek" "snd_hda_codec_analog" "snd_hda_codec_idt"
      "snd_hda_codec_via" "snd_hda_codec_conexant" "snd_hda_codec_ca0132" "snd_ac97_codec"
      "ac97_bus" "snd_via82xx" "snd_ali5451" "snd_atiixp" "snd_atiixp_modem" "snd_emu10k1"
      "snd_emu10k1x" "snd_ca0106" "snd_ymfpci" "snd_cmipci" "snd_trident" "snd_cs4232"
      "snd_cs4236" "pcspkr"

      # 2. Wireless (Q958 has no wireless hardware)
      "iwlwifi" "iwlegacy" "ath9k" "ath9k_htc" "ath5k" "ath10k_core" "ath10k_pci"
      "ath11k" "rtl8180" "rtl8187" "rtl8192ce" "rtl8192cu" "rtl8192de" "rtl8188ee"
      "rtl8192se" "rtl8723bs" "rtl8821ae" "rtl8822be" "brcmfmac" "brcmsmac" "brcmutil"
      "mt76" "mt7601u" "mt76x2u" "b43" "b43legacy" "ssb" "mwifiex" "mwifiex_pcie"
      "libertas" "p54pci" "p54usb" "zd1211rw" "wl"

      # 3. Bluetooth (No hardware)
      "bluetooth" "btusb" "btrtl" "btbcm" "btintel" "bnep" "rfcomm" "hidp"

      # 4. Legacy NICs
      "ne2k_pci" "ne" "8139too" "8139cp" "3c59x" "3c515" "3c523" "e100" "tulip"
      "de4x5" "de2104x" "lance" "pcnet32" "fealnx" "sis900" "sis190" "via_rhine"
      "via_velocity" "smc91x" "smc911x" "tms380" "ibmtr" "3c359" "lanstreamer"
      "olympic" "abyss" "skfp" "defxx" "arc-rawmode" "arc-rimi" "com90io" "com90xx"
      "ax25" "netrom" "rose"

      # 5. Legacy Storage
      "floppy" "pata_acpi" "pata_ali" "pata_amd" "pata_artop" "pata_atiixp" "pata_efar"
      "pata_hpt366" "pata_hpt37x" "pata_hpt3x2n" "pata_hpt3x3" "pata_it8213" "pata_it821x"
      "pata_jmicron" "pata_marvell" "pata_mpiix" "pata_netcell" "pata_ninja32"
      "pata_ns87415" "pata_oldpiix" "pata_opti" "pata_optidma" "pata_pcmcia"
      "pata_pdc2027x" "pata_qdi" "pata_rz1000" "pata_sc1200" "pata_serverworks"
      "pata_sil680" "pata_sis" "pata_sl82c105" "pata_triflex" "pata_via" "sr_mod" "cdrom"
      "st" "osst" "aic7xxx" "aic94xx" "sym53c8xx" "megaraid" "ppa" "imm"

      # 6. Legacy Bus & Misc
      "firewire_core" "firewire_ohci" "firewire_sbp2" "firewire_net" "parport"
      "parport_pc" "lp" "ppdev" "pcmcia" "pcmcia_core" "yenta_socket" "rsrc_nonstatic"

      # 7. Non-Intel GPUs
      "nouveau" "radeon" "amdgpu" "mgag200" "ast" "cirrus" "vmwgfx" "vboxvideo"
      "uvesafb" "hyperv_drm"

      # 8. Industrial/Datacenter Hardware
      "ib_core" "ib_uverbs" "ib_cm" "ib_mad" "mlx4_ib" "mlx5_ib" "rdma_cm" "iw_cm"
      "rdma_ucm" "megaraid_sas" "hpsa" "mpt3sas" "aacraid" "lpfc" "qla2xxx" "bfa" "zfcp"

      # 9. Legacy Protocols
      "isdn" "hisax" "hysdn" "atm" "uvcvideo" "videodev" "ppp" "pppoe" "pppox" "slhc"
      "ip6table_filter"
    ];

    # 🏎️ SYSCTL SECURITY HARDENING
    boot.kernel.sysctl = {
      # Network Hardening
      "net.ipv4.conf.all.rp_filter" = 1;
      "net.ipv4.conf.default.rp_filter" = 1;
      "net.ipv4.tcp_syncookies" = 1;
      "net.ipv4.icmp_echo_ignore_broadcasts" = true;
      "net.ipv4.conf.all.accept_redirects" = false;
      "net.ipv4.conf.all.secure_redirects" = false;
      
      # Integrity & Privacy
      "kernel.kptr_restrict" = 2;
      "kernel.dmesg_restrict" = 1;
      "kernel.unprivileged_bpf_disabled" = 1; 
      "net.core.bpf_jit_enable" = 1; # Enabled for performance, restricted below
      "net.core.bpf_jit_harden" = 2; # Hardened JIT
      "kernel.ftrace_enabled" = false;
      "kernel.perf_event_paranoid" = 3;
      "kernel.sysrq" = 0; # Disable SysRQ

      # Swappiness tuning for RAM-heavy streamers
      "vm.swappiness" = 10;
    };

    # 💎 BOOT PARAMETERS (ADR 001)
    boot.kernelParams = [
      "slab_nomerge"        # Prevents heap grooming
      "init_on_free=1"      # Sanitize free'd pages (replaces deprecated page_poison)
      "init_on_alloc=1"     # Zero-init allocations
      "page_alloc.shuffle=1" # Randomizes page allocation
      "debugfs=off"         # Closes debug attack vector
      "quiet" "loglevel=3"
    ];

    # Whitelist of required modules
    boot.kernelModules = [ "kvm_intel" "nct6775" "coretemp" "veth" "i915" "nvme" ];
  };
}
