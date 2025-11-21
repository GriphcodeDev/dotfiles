{ config, pkgs, ... }:

{
services.xserver.enable = true;

services.xserver.displayManager.sddm.enable = true;


services.xserver.windowManager.i3 = {
enable = true;
package = pkgs.i3-gaps;
};


networking.networkmanager.enable = true;

environment.systemPackages = with pkgs; [ i3 i3status i3blocks dmenu picom alacritty nitrogen networkmanagerapplet ly ];


}
