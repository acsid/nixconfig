# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, options,... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
    ];

 # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  networking.hostName = "Bowser"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.extraHosts = "127.0.0.1 tv.rockstargames.com";
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n = {
  #   consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "cf";
  #   defaultLocale = "en_US.UTF-8";
   };

  # Set your time zone.
  time.timeZone = "America/Montreal";

 virtualisation.virtualbox.host.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   wget vim
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
   networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
 hardware.pulseaudio.package = pkgs.pulseaudioFull;
 hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.opengl.extraPackages = with pkgs; [ libGL ];
hardware.opengl.enable = true;
hardware.bluetooth.enable = true;
services.blueman.enable = true;
  # X11 windowing system.
    services.xserver = {
		enable = true;
		displayManager = {
			sddm = {
				enable = true;
			};
		};
		desktopManager = {
			plasma5 = {
				enable = true;
			};
		};
		videoDrivers = [ "nvidia" ];
		layout = "ca";
	};

	nixpkgs.config = {
		allowUnfree = true;
		retroarch = {
			enableMupen64plus = true;
			};
	};

   users.users.vikingman = {
     isNormalUser = true;
     extraGroups = [ "wheel" "audio" "cdrom"]; # Enable ‘sudo’ for the user.
   };


fileSystems."/home/vikingman/disk2" =
  { device = "/dev/disk/by-uuid/57489b56-24d4-4969-8acd-7ea1b0cd5e29";
    fsType = "ext4";
  };

#	fileSystems = {
#                "/mnt/wd1000green" = {
#                        device = "/dev/disk/by-label/wd1000green";
#                        fsType = "ntfs";
#                        options = ["rw" "uid=1000"];
#                };
#	};

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

}
