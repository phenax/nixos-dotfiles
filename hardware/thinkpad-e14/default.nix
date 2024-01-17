{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  services.fwupd.enable = true;

  # 2-Sep-2023, Bug: https://nixpk.gs/pr-tracker.html?pr=252605
  boot.kernelPackages = pkgs.linuxPackages_6_6;
  boot.initrd = {
    availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usb_storage"
      "thunderbolt"
      "sd_mod"
    ];
    kernelModules = [ ];
  };
  boot.kernelModules = [
    "kvm-intel"
    "rtw88_8822ce"
    "sd_mod"
    "snd-seq"
    "snd-rawmidi"
    "uinput"
    "v4l2loopback"
    "acpi_call"
  ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    acpi_call
  ];
  boot.kernelParams = [
    "i8042.nopnp=1"
    "pci=nocrs"
    "acpi_osi=linux"
    "acpi_backlight=native"
    "i915.enable_dpcd_backlight=0"
    # "acpi_backlight=vendor"
    # "acpi_backlight=intel_backlight"
    # "i915.force_probe=46a8"
  ];
  boot.extraModprobeConfig = ''
    options snd slots=snd-hda-intel
    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
  '';
  boot.supportedFilesystems = [ "ntfs" ];
  # boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  services.throttled.enable = true;

  services.udev = {
    packages = [
      pkgs.android-udev-rules
      pkgs.platformio-core.udev
    ];
  };

  hardware = {
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;
    # firmware = with pkgs; [ wireless-regdb rtw88-firmware ];
  };

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      # intel-ocl
      intel-media-driver
      intel-gmmlib
      vulkan-tools
      mesa.drivers
    ];
  };

  # Bootloader
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 30;
    };
    timeout = 1;
    efi.canTouchEfiVariables = true;
  };

  # File system
  boot.initrd.luks.devices."crypted".device = "/dev/disk/by-uuid/17ac9757-d710-4456-9a94-7b6086a35638";
  fileSystems = {
    "/" = {
      device = "/dev/mapper/crypted";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };
  swapDevices = [{ device = "/dev/disk/by-label/swap"; }];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  networking.useDHCP = lib.mkDefault true;
  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "powersave";
  };
}
