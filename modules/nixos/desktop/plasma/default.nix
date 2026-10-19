{ pkgs, ... }:

let
  sddmTheme = pkgs.runCommand "sddm-breeze-wallpaper" { } ''
    theme=$out/share/sddm/themes/breeze-wallpaper
    mkdir -p $out/share/sddm/themes
    cp -r ${pkgs.kdePackages.plasma-desktop}/share/sddm/themes/breeze $theme
    chmod -R u+w $theme
    sed -i 's|^background=.*|background=${../../../home-manager/misc/wallpaper/cat-leaves.png}|' $theme/theme.conf
  '';
in
{
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    theme = "breeze-wallpaper";
    extraPackages = [ sddmTheme ];
  };
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
    wl-clipboard
    xclip
    sddmTheme
  ];
}
