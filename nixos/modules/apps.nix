{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    google-chrome
    vscode
    obs-studio
    discord
    spotify
    mpv
    discordo
    alacritty
    steam
    pkgs.gnome-tweaks


    #CLI apps
    cmatrix
    tty-clock
    cava
    ranger
    pfetch-rs

  ];
}
