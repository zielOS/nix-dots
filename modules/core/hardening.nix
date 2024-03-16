{ config, pkgs, lib, ... }:

{

  # Firefox cache on tmpfs

  boot.kernel.sysctl = {
    "dev.tty.ldisc_autoload" = 0;
    "fs.protected_fifos" = 2;
    "fs.protected_hardlinks" = 1;
    "fs.protected_regular" = 2;
    "fs.protected_symlinks" = 1;
    "kernel.core_uses_pid" = 1;
    "kernel.dmesg_restrict" = 1;
    "kernel.perf_event_paranoid" = 3;
    "kernel.unprivileged_bpf_disabled" = 1;
    "kernel.yama.ptrace_scope" = 2;
    "kernel.kptr_restrict" = 2;
    # "kernel.sysrq" = 0;
    # "net.core.bpf_jit_enable" = false;
    "kernel.ftrace_enabled" = false;
    "net.ipv4.conf.all.log_martians" = true;
    "net.ipv4.conf.all.rp_filter" = "1";
    "net.ipv4.conf.default.log_martians" = true;
    "net.ipv4.conf.default.rp_filter" = "1";
    "net.ipv4.icmp_echo_ignore_broadcasts" = true;
    "net.ipv4.conf.all.accept_redirects" = false;
    "net.ipv4.conf.all.secure_redirects" = false;
    "net.ipv4.conf.default.accept_redirects" = false;
    "net.ipv4.conf.default.secure_redirects" = false;
    "net.ipv6.conf.all.accept_redirects" = false;
    "net.ipv6.conf.default.accept_redirects" = false;
    "net.ipv4.conf.all.send_redirects" = false;
    "net.ipv4.conf.default.send_redirects" = false;
    "net.ipv6.conf.default.accept_ra" = 0;
    "net.ipv6.conf.all.accept_ra" = 0;
    "net.ipv4.tcp_syncookies" = 1;
    "net.ipv4.tcp_timestamps" = 0;
    "net.ipv4.tcp_rfc1337" = 1;
    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";
/*     "net.core.bpf_jit_harden" = 2; */
    "net.ipv4.conf.default.accept_source_route" = 0;
  };

  boot.blacklistedKernelModules = [
    "ax25"
    "netrom"      
    "rose"
    "adfs"
    "affs"
    "bfs"
    "befs"
    "cramfs"
    "efs"
    "erofs"
    "exofs"
    "freevxfs"
    "f2fs"
    "vivid"
    "gfs2"
    "ksmbd"
    "nfsv4"
    "nfsv3"
    "cifs"
    "nfs"
    "cramfs"
    "freevxfs"
    "jffs2"
    "hfs"
    "hfsplus"
    "squashfs"
    "udf"
    "bluetooth"
    "btusb"
    "hpfs"
    "jfs"
    "minix"
    "nilfs2"
    "omfs"
    "qnx4"
    "qnx6"
    "sysv"
  ];  

  programs = {
    ssh.startAgent = false;
    firejail = {
      enable = true;
      wrappedBinaries = {
        firefox = {
          executable = "${pkgs.lib.getBin pkgs.firefox}/bin/firefox";
          profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
        };
      };
    };
  };

  systemd.coredump.enable = false;

  services = { 
    jitterentropy-rngd.enable = true;
    haveged.enable = true;
    sysstat.enable = true; };

  security = {
    protectKernelImage = false;
    lockKernelModules = false;
    allowSimultaneousMultithreading = true;
    rtkit.enable = true;
    virtualisation.flushL1DataCache = "always"; 
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = with pkgs; [
        apparmor-profiles
        apparmor-utils
        apparmor-parser
        libapparmor
      ];
    };
    audit.enable = true;
    auditd.enable = true;
    audit.rules  = [ "-a exit,always -F arch=b64 -S execve" ];
    pam.loginLimits = [
      { domain = "*"; item = "core"; type = "hard"; value = "0";}
    ]; 
  };
}
