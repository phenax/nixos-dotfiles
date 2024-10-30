{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  services.fwupd.enable = true;

  # boot.kernelPackages = pkgs.linuxPackages_6_9;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_stable;
  boot.initrd = {
    availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usb_storage"
      "thunderbolt"
      "sd_mod"
    ];
    kernelModules = [ "i915" ];
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
    "thinkpad_acpi"
    "coretemp"
  ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    acpi_call
    v4l2loopback
  ];
  boot.kernelParams = [
    "i8042.nopnp=1"
    "pci=nocrs"
    "acpi_osi=linux"
    "acpi_backlight=native"
    "i915.enable_dpcd_backlight=0"
    "i915.enable_guc=2"
    # "acpi_backlight=vendor"
    # "acpi_backlight=intel_backlight"
    # "i915.force_probe=46a8"
  ];
  boot.extraModprobeConfig = ''
    options snd slots=snd-hda-intel
    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
    options thinkpad_acpi experimental=1 fan_control=1
  '';
  boot.supportedFilesystems = [ "ntfs" ];
  # boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  services.throttled.enable = true;
  services.thermald = {
    enable = true;
    ignoreCpuidCheck = true;
  };

  services.udev = {
    packages = with pkgs; [
      alsa-utils
      android-udev-rules
      platformio-core.udev
      openocd
    ];
  };

  environment.systemPackages = with pkgs; [
    mesa
    xorg.xf86inputlibinput
    xorg.xf86videointel
  ];
  # services.xserver.videoDrivers = [ "intel" ];

  hardware = {
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;
  };

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.graphics = {
    enable = true;
    # enable32Bit = true;
    # driSupport = true;
    # driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      # intel-vaapi-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-gmmlib
      vulkan-tools
      mesa.drivers
    ];
  };
  environment.variables = {
    VDPAU_DRIVER = "va_gl";
    LIBVA_DRIVER_NAME = "iHD";
  };
  # services.xserver.videoDrivers = [ "intel" ];

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
    enable = false;
    cpuFreqGovernor = "powersave";
  };

  services.tlp.enable = lib.mkDefault false;
}
