{ pkgs, ... }:

{

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-music
    epiphany    
    geary       
    gnome-characters
    tali        
    iagno       
    hitori      
    atomix      
    gnome-maps
    gnome-contacts
    gnome-weather
    gnome-logs
    gnome-system-monitor
  ]);

  services.xserver.excludePackages = [ pkgs.xterm ];
}
