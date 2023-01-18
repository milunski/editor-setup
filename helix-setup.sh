#! /bin/sh


# Download and install Helix
setup_helix () {
    if [[ "$OSTYPE" =~ ^linux ]]; then
        echo "Installing for Linux"
        sudo apt update -y
        sudo apt install cargo -y
    elif [[ "$OSTYPE" =~ ^darwin ]]; then
        echo "Installing for Mac"
        brew install rust 
    fi

    cd ~
    echo "export PATH=$HOME/.cargo/bin:$PATH" >> ~/.bashrc        
    git clone --recurse-submodules --shallow-submodules -j8 https://github.com/helix-editor/helix
    source ~/.bashrc
    cd helix
    cargo install --locked --path helix-term
    echo "Helix installed!"
}

setup_themes_languages () {
    if [[ ! -d ~/.config/helix/themes ]]; then
        mkdir ~/.config/helix/themes
        echo "Themes directory created"
        cp -r ~/helix/runtime/themes ~/.config/helix/
    fi
    if [[ ! -d ~/.config/helix/languages ]]; then
        mkdir ~/.config/helix/languages
        echo "Languages directory created"
        cp -r ~/helix/languages.toml ~/.config/helix/languages
    fi
}


setup_helix
cp ./config.toml ~/.config/helix/
setup_themes_languages
echo "Setup complete. Restart the shell session and run hx --health to check if the install was performed correctly."
