# Nix Home Manager Setup

First, install nix from [here](https://zero-to-nix.com/start/install).
Second, install `home-manager` from [here](https://nix-community.github.io/home-manager/index.xhtml#ch-installation).

Clone this repository to `~/.config/home-manager`.

Allow experimental features:
```
mkdir -p ~/.config/nix
cat <<EOF >> ~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF
```

Install by running:
```
home-manager switch
```

For completion in neovim with Codeium, start nvim and run Codeium Auth to import a token.
