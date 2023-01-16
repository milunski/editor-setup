#! /bin/sh


# Download and install Helix
setup_helix () {
    if [ uname="Linux" ]
    then
        sudo apt update -y
        sudo apt install cargo -y
        cd ~
        echo "export PATH=$HOME/.cargo/bin:$PATH" >> ~/.bashrc
        git clone --recurse-submodules --shallow-submodules -j8 https://github.com/helix-editor/helix
        source ~/.bashrc
        cd helix
        cargo install --locked --path helix-term
    elif [ uname="Darwin" ]
    then
        brew install helix
    fi
    echo "Helix installed!"
}

setup_themes_languages () {
    if [ ! -d ~/.config/helix/themes ]
    then
        mkdir ~/.config/helix/themes
        echo "Themes directory created"
        cp -r ~/helix/runtime/themes ~/.config/helix/
    fi
    if [ ! -d ~/.config/helix/languages ]
    then
        mkdir ~/.config/helix/languages
        echo "Languages directory created"
        cp -r ~/helix/languages.toml ~/.config/helix/languages
    fi
}

os=$( uname )

if [ $os="Linux" ]
then
    echo "Setting up for Linux"
    setup_helix
    cp ./config.toml ~/.config/helix/
    setup_themes_languages
else
    echo "Nothing"
fi
echo "Setup complete. Restart the shell session and run hx --health to check if the install was performed correctly."
