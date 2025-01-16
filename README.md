# NixOS Dotfiles

## My Personal NixOS Config

> [!CAUTION]
> **THIS DOCUMENTATION AND THE INSTALLER SCRIPT ARE OBSOLETE.** Will update soon. Meanwhile, check out the code and **PROCEED WITH CAUTION**.

> [!NOTE]
> **Use at your own risk.** It works _for me_, but it may or may not work _for you_.

---

### Modules

- [`configuration.nix`](./configuration.nix) (and variants)

  _**System config**_: Avoid modifying unless really needed (like changing username, groups, etc.).

  _**Variants**_: `-darwin` for `nix-darwin`, and `-surface` for Surface devices

- [`system/`](./system/) (directory)

  _**Installed software config**_: Install and configure various software for the user.

- [`packages/`](./packages/) (directory)

  _**Installed software config**_: Install and configure various software for the user.

<details>

<summary><b><code>system</code> submodules</b> <i>(click to expand)</i></summary>

- [`packages/pkgslist.nix`](./packages/pkgslist.nix)

  _**List of packages to install**_: Software to install that need no further configuration.

</details>

<details>

<summary><b><code>packages</code> submodules</b> <i>(click to expand)</i></summary>

- [`packages/pkgslist.nix`](./packages/pkgslist.nix)

  _**List of packages to install**_: Software to install that need no further configuration.

</details>

---

### Installation

> [!WARNING]
> The installation scripts use `sudo`. Please **read the scripts and included comments** _before running_ to ensure you understand what they're doing and acknowledge that you trust them. Else, manually run the commands or install otherwise **at your own risk**.

#### NixOS

> [!NOTE]
> Run `export SURFACE_KERNEL=1` _before_ running the following script **if you’re using a Surface device**.

Run the [install.sh](./install.sh) script:

```sh
curl -sS "https://raw.githubusercontent.com/cybardev/nixos-dotfiles/refs/heads/main/install.sh" | bash -e
```

#### macOS

Run the [install-mac.sh](./install-mac.sh) script:

```sh
curl -sS "https://raw.githubusercontent.com/cybardev/nixos-dotfiles/refs/heads/main/install-mac.sh" | bash -e
```

---

### Screenshots

![NixOS Screenshot, showing desktop with flower background and XFCE panels](./images/screenshot_0.png "NixOS Screenshot 0")
![NixOS Screenshot, showing 3 windows of Kitty terminal in BSPWM](./images/screenshot_1.png "NixOS Screenshot 1")
![NixOS Screenshot, showing logoff dialog](./images/screenshot_2.png "NixOS Screenshot 2")
