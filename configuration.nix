{ pkgs, ... }:
 
 {
   nix.settings = {
     experimental-features = "nix-command flakes";
     auto-optimise-store = true;
   };
   
   environment.systemPackages = [
     pkgs.vim
     pkgs.git
     pkgs.zip
     pkgs.unzip
     pkgs.wget
   ];
   
   fileSystems."/" = {
     device = "/dev/disk/by-label/nixos";
     fsType = "ext4";
   };
   fileSystems."/boot" = {
     device = "/dev/disk/by-label/boot";
     fsType = "ext4";
   };
   swapDevices = [
     {
       device = "/dev/disk/by-label/swap";
     }
   ];
   
   documentation.nixos.enable = false;
   time.timeZone = "Asia/Singapore";
   i18n.defaultLocale = "en_US.UTF-8";
   console.keyMap = "us";
   nix.settings.trusted-users = [ "@wheel" ];
   
   boot.loader.grub.enable = true;
   boot.loader.grub.device = "/dev/sda";
   boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "ext4" ];
   
   users.users = {
     root.hashedPassword = "!"; # Disable root login
     username = {
       isNormalUser = true;
       extraGroups = [ "wheel" ];
       openssh.authorizedKeys.keys = [
         ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKBZcuHZR/khgIlU7jDIYyaiAl+YyktcwsusZgaJTLiz
       ];
     };
   };
   
   security.sudo.wheelNeedsPassword = false;
   
   services.openssh = {
     enable = true;
     settings = {
       PermitRootLogin = "no";
       PasswordAuthentication = false;
       KbdInteractiveAuthentication = false;
     };
   };
   networking.firewall.allowedTCPPorts = [ 22 ];
   
   # This value determines the NixOS release from which the default
   # settings for stateful data, like file locations and database versions
   # on your system were taken. It‘s perfectly fine and recommended to leave
   # this value at the release version of the first install of this system.
   # Before changing this value read the documentation for this option
   # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
   system.stateVersion = "24.11"; # Did you read the comment?
 }
