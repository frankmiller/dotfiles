# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    imports =
      [
        ./hardware-configuration.nix
      ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    i18n.consoleFont = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";

    networking.hostName = "nixos";
    #networking.wireless.enable = true;
    networking.networkmanager.enable = true;

    time.timeZone = "America/Chicago";

    nixpkgs.config = {
        allowUnfree = true;
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        pciutils
        htop
        vim
        neovim
        wget
        w3m
        git

        mesa
        glxinfo
        xorg.xmodmap

        networkmanagerapplet
        blueman

        firefox

        texlive.combined.scheme-full
        rubber
        evince
        pandoc

        clang-tools
    ];

    # Enable sound.
    sound.enable = true;
    hardware.pulseaudio.enable = true;

    # Enable bluetooth
    hardware.bluetooth.enable = true;

    # Enable brightness control in userspace
    hardware.brightnessctl.enable = true;
    programs.light.enable = true;

    # Enable the X11 windowing system.
    services.xserver = {
        enable = true;
        autorun = true;
        #videoDrivers = [ "nvidia" ];
        videoDrivers = [ "intel" ];
        layout = "us";
        desktopManager = {
            default = "none";
            xterm.enable = false;
        };
        windowManager.i3.enable = true;
        windowManager.default = "i3";
    };

    # Enable opengl
    hardware.opengl = {
        enable = true;
        #extraPackages = with pkgs; [
        #  vaapiIntel
        #  vaapiVdpau
        #  libvdpau-va-gl
        #  intel-media-driver
        #];
    };

    # Enable touchpad support.
    services.xserver.libinput.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.frank = {
        isNormalUser = true;
        extraGroups = [
            "wheel"
            "networkmanager"
            "video"
        ];
    };

    # This value determines the NixOS release with which your system is to be
    # compatible, in order to avoid breaking some software such as database
    # servers. You should change this only after NixOS release notes say you
    # should.
    system.stateVersion = "19.03"; # Did you read the comment?

}
