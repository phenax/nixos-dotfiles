# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.kernelPackages = pkgs.linuxPackages_5_10;
  boot.initrd = {
    availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" ];
    kernelModules = [];
  };
  boot.kernelModules = [
    "kvm-intel"
    "rtw88_8822ce"
    "sd_mod"
    "snd-seq"
    "snd-rawmidi"
  ];
  boot.kernelParams = [ "i8042.nopnp=1" "pci=nocrs" "i915.enable_dpcd_backlight=1" "acpi_backlight=vendor" ];
  boot.extraModulePackages = [];
  boot.extraModprobeConfig = ''
    options snd slots=snd-hda-intel
  '';

  hardware = {
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;
    firmware = with pkgs; [ wireless-regdb rtlwifi_new-firmware ];
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
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };
  swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];


  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "powersave";
  };
}
