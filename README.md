# Nix Dotfiles

## My Personal Nix Config

> [!CAUTION]
> **OUTDATED README**: This used to be a channel-based configuration (now it's flake-based), and the installation instructions have become obsolete. Will update sometime in the near future, but until then it's best to refer to source files (except `install*.sh`).

> [!WARNING]
> **Use at your own risk.** It works _for me_, but it may not work _for you_. At least not without adjustments.

---

### Features

- **Flake-based**
- XFCE desktop environment
- BSPWM window manager
- Brave browser
- Kitty terminal
- Zsh shell
- etc.

### Components

- [`configuration.nix`](./configuration.nix) (and variants)

  _**Root config**_: Avoid modifying unless really needed (like changing username, groups, etc.).

  _**Variants**_: [`-darwin`](./configuration-darwin.nix) for `nix-darwin`, and [`-surface`](./configuration-surface.nix) for Surface devices

- [`system/`](./system/) (directory)

  _**System configs**_: Configure various system components, like home-manager, unfree software, system-wide packages, etc.

- [`packages/`](./packages/) (directory)

  _**Package configs**_: Install and configure various software for the user.

---

### Installation

> [!CAUTION]
> The installation scripts use `sudo`. Please **read the scripts and included comments** _before running_ to ensure you understand what they're doing and acknowledge that you trust them. Else, manually run the commands or install otherwise **at your own risk**.

#### NixOS

> [!IMPORTANT]
> Run `export SURFACE_KERNEL=1` _before_ running the following script _if you’re using a Surface device_ **and** _you want the `linux-surface` kernel_.

Run the [install.sh](./install.sh) script:

```sh
curl -sS "https://raw.githubusercontent.com/cybardev/nix-dotfiles/refs/heads/main/install.sh" | bash -e
```

#### macOS

Run the [install-mac.sh](./install-mac.sh) script:

```sh
curl -sS "https://raw.githubusercontent.com/cybardev/nix-dotfiles/refs/heads/main/install-mac.sh" | bash -e
```

---

### Screenshots

![NixOS Screenshot, showing desktop with flower background and XFCE panels](./images/screenshot_0.png "NixOS Screenshot 0")
![NixOS Screenshot, showing 3 windows of Kitty terminal in BSPWM](./images/screenshot_1.png "NixOS Screenshot 1")
![NixOS Screenshot, showing logoff dialog](./images/screenshot_2.png "NixOS Screenshot 2")
