# Using Nix and Go in a Development Container With Visual Code

This repository provides a skeleton for developing software in a development container with Visual Code.  The container
is based off Microsoft's Alpine Linux image, but adds [Nix](https://nixos.org/explore.html) so you can manage your 
project's dependencies using Nix Shell.

### Requirements

- [Visual Code]() -- If you use development containers with other editors, feel free to take what you want from the
  [Dockerfile]().
- [Remote Containers Extension]() -- Remote development container support for Visual Code.
- [Podman]() -- This will work with Docker, but you may need to change the settings in [devcontainer.json]().

[Visual Code]: https://code.visualstudio.com/
[Remote Containers Extension]: https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers
[Podman]:  https://podman.io
[devcontainer.json]: .devcontainer/devcontainer.json
[Dockerfile]: .devcontainer/Dockerfile

### Setup

1. Clone this repo or download a copy.
2. Copy [nix](), [.devcontainer]() and [shell.nix]() to the root of your project directory.
3. Open your project directory in Visual Code.
4. Accept the prompt to reopen your project in a container.
5. Go get a cup of coffee.
6. Run [Nix-Shell]() in your new environment.

[Nix-Shell]: https://nixos.org/manual/nix/unstable/command-ref/nix-shell.html
[nix]: ./nix
[.devcontainer]: ./.devcontainer
[shell.nix]: ./shell.nix

### TLDR

```bash
cd /tmp
wget https://github.com/swdunlop/mage-svc/archive/refs/heads/main.zip
cd ~/project
unzip /tmp/main.zip
code .
# Reopen in dev container, get coffee, open terminal in Visual Code, then:
nix-shell 
```

### Why use a Nix Shell inside a development container?

The projects I work on have a mix of disciplines, with some members using NixOS for their development environment, and
others using more common desktop operating systems.  By defining our build and development dependencies using Nix, we
can be certain that everyone, even our continuous build and deployment systems, are using the same software versions.

### Why use Alpine Linux?

Smallest MCR image that I could use to install Nix.  The packages installed by Nix do not use Alpine's libc, nor does
a container use its kernel, so Alpine makes for a nice bootstrap.  (Note that MCR images include utilities for Visual
Code integration that we are not managing with Nix.)

### How do I update Nix Packages in my shell?

Edit [nixpkgs.nix]() to move the pin to the version of [Nixpkgs]() you want.  If you do not want to pin to a specific
version using [nixpkgs.nix](), you should edit [shell.nix]() to change `nix/nixpkgs.nix` to `<nixpkgs>` so your Nix
shell just uses the Nix environment's nixpkgs channel.

[Nixpkgs]: https://github.com/nixos/nixpkgs/
[nixpkgs.nix]: nix/nixpkgs.nix
[shell.nix]: ./shell.nix

### How do I update the version of Nix or Alpine Linux?

Edit the necessary parameters in [devcontainer.json]() and rebuild the container.

[devcontainer.json]: .devcontainer/devcontainer.json

### How do I add packages to my shell?

This is not a full manual for [shell.nix](), but find the package in nixpkgs and add it to the buildInputs list in
[shell.nix]()

[shell.nix]: ./shell.nix

### Why do you not install Go tools in the Dockerfile?

The Go extension for Visual Code is extremely sensitive to the version of Gopls.  It is better to let the extension
manage installing its dependencies than try to pin them.

### License

Public domain.

> I commend my soul to any god that can find it.
-- Terry Pratchett
