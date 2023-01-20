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


copy_languages () {
    cp -r ~/helix/languages.toml ~/.config/helix/
}


copy_runtime_components () {
    cp -r ~/helix/runtime ~/.config/helix
}

setup_lsp () {
    cd ~
    git clone https://github.com/rust-lang/rust-analyzer.git && cd rust-analyzer
    cargo xtask install --server
}

setup_helix
cp ./config.toml ~/.config/helix/
copy_languages
copy_runtime_components
setup_lsp
echo "Setup complete. Restart the shell session and run hx --health to check if the install was performed correctly. Add a config.toml to ~/.config/helix to customize."
