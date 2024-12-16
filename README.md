# nixos dotfiles

## My Personal NixOS Config

### Notes
- _May or may not work for you._
- Needs channels to be added from [NixOS/nixos-hardware](https://github.com/NixOS/nixos-hardware) and [nix-community/home-manager](https://github.com/nix-community/home-manager) _before_ applying config.
- **PS**: Make sure to use `home-manager` version `24.11`, not `master`.

### Installation

1. Make backup of current config
    ```sh
    sudo mv /etc/nixos /etc/nixos.bak
    ```

2. Clone into `~/.config`
    ```sh
    git clone "https://github.com/cybardev/nixos-dotfiles.git" ~/.config/nixos
    ```

3. Soft-link to NixOS config directory
    ```sh
    sudo ln -s $HOME/.config/nixos /etc/nixos
    ```

---
> [!IMPORTANT]
> at this stage compare `/etc/nixos.bak/hardware-configuration.nix` and `~/.config/nixos/hardware-configuration.nix` and edit the file as needed, since it can vary based on hardware
---

4. Rebuild system from new config
    ```sh
    sudo nixos-rebuild switch
    ```

### Screenshots

![NixOS Screenshot, showing desktop with flower background and XFCE panels](./images/screenshot_0.png "NixOS Screenshot 0")
![NixOS Screenshot, showing 3 windows of Kitty terminal in BSPWM](./images/screenshot_1.png "NixOS Screenshot 1")
![NixOS Screenshot, showing logoff dialog](./images/screenshot_2.png "NixOS Screenshot 2")

