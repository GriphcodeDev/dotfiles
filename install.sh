#!/bin/bash




echo " ██████╗ ██████╗ ██╗██████╗ ██╗  ██╗ ██████╗ ██████╗ ██████╗ ███████╗███████╗"
echo "██╔════╝ ██╔══██╗██║██╔══██╗██║  ██║██╔════╝██╔═══██╗██╔══██╗██╔════╝██╔════╝"
echo "██║  ███╗██████╔╝██║██████╔╝███████║██║     ██║   ██║██║  ██║█████╗  ███████╗"
echo "██║   ██║██╔══██╗██║██╔═══╝ ██╔══██║██║     ██║   ██║██║  ██║██╔══╝  ╚════██║"
echo "╚██████╔╝██║  ██║██║██║     ██║  ██║╚██████╗╚██████╔╝██████╔╝███████╗███████║"
echo " ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚══════╝"
echo "        ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗        "
echo "        ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝        "
echo "        ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗        "
echo "        ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║        "
echo "        ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║        "
echo "        ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝        "


echo "Welcome to the Dotfiles Installation Script."
echo "This script will configure your environment with the necessary dotfiles."
echo

while true; do
    read -p "Please type 'Yes' to continue or 'No' to abort the installation: " input

    # Convert input to lowercase
    input=$(echo "$input" | tr '[:upper:]' '[:lower:]')

    if [[ "$input" == "yes" ]]; then
        echo "You chose 'Yes'. Continuing with the installation..."
    
        break
    elif [[ "$input" == "no" ]]; then
        echo "You chose 'No'. Aborting the installation."
        exit 1
    else
        echo "Invalid input. Please type 'Yes' or 'No'."
    fi
done

# everything necessary!

sudo apt install neovim alacritty discord git 


#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


