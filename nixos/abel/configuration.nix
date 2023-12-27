# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ pkgs, lib, config, ... }:
  {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ../common
    ./gpu.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "abel";

  specialisation."GPU-enable".configuration = {
    system.nixos.tags = [ "GPU-enable" ];
    gpu.enable = true;
  };

  services = {
    xserver = {
      libinput = {
        enable = true;
        touchpad = {
          scrollMethod = "twofinger";
        };
      };
    };
    logind = {
      lidSwitch = "hibernate";
      powerKey = "poweroff";
      extraConfig = ''
        IdleAction=suspend
        IdleActionSec=2m
      '';
    };
    tlp = {
      enable = true;
      settings = {
        DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE="bluetooth";
        DEVICES_TO_DISABLE_ON_LAN_CONNECT="wifi wwan";
        DEVICES_TO_DISABLE_ON_WIFI_CONNECT="wwan";

        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        PLATFORM_PROFILE_ON_AC = "balanced";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        CPU_BOOST_ON_AC=1;
        CPU_BOOST_ON_BAT=0;
        CPU_HWP_DYN_BOOST_ON_AC=1;
        CPU_HWP_DYN_BOOST_ON_BAT=0;
      };
    };
  };

  security.protectKernelImage = false;
  boot.resumeDevice = "/dev/disk/by-uuid/54bf766e-32b7-42c6-8c01-58238bf6219b";
  #filefrag -v /var/lib/swapfile| awk '{ if($1=="0:"){print $4} }
  boot.kernelParams = ["resume_offset=54437888" "mitigations=off"];

}
