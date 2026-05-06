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



    #Language tools
    gcc
    gnumake
    cmake
    pkg-config
    python3
    nodejs_20
    yarn
    go
    rustup

    #LSP servers (for neovim)
    lua-language-server
    pyright
    nodePackages.typescript-language-server
    nodePackages.bash-language-server
    clang-tools
    nil
    gopls

    #Formatters (for neovim/conform)
    stylua
    black
    nodePackages.prettier
    shfmt


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
