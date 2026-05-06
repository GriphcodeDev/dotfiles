{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    #Dev enviornment
    neovim
    unzip
    fd
    fastfetch
    tree
    htop
    btop
    ripgrep
    jq



    #Lanuage tools
    gcc
    gnumake
    cmake
    pkg-config
    python3
    nodejs_20
    yarn
    go
    rustup


    #Shell utils
    zsh
    oh-my-zsh
    starship
    bat
    fzf


    #Hacking tools
    ghidra
    gdb
    capstone
    wireshark
    tcpdump
    nmap
    netcat
    aircrack-ng
    iw
    john
    hashcat
    metasploit
    exploitdb
    sleuthkit
    autopsy
    volatility3
    hping


    #osint
    theharvester
    snscrape
    exiftool
    mapscii

  ];
}
