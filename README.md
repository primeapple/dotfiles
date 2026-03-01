# Dotfiles
This Repository contains my dotfiles as well as scripts to manage the installation and configuration of various applications.

It is managed by [YADM](https://yadm.io/).

Used for the following systems systems:
* MacOS
* [Arch Linux](https://archlinux.org/)
* [Debian](https://www.debian.org/)

## Installation
To install the Dotfiles, install `yadm` and run:
```shell
yadm clone --no-bootstrap https://github.com/primeapple/dotfiles
```

Set the corresponding classes of the machine, if needed:
```shell
# if the machine run on nvidia gpu and needs graphical user interface
yadm config --add local.class nvidia
# if the machine is interactively used
yadm config --add local.class workstation
```

Now run the bootstrap script:
```shell
yadm bootstrap
```

You may now need to do some more things:
```shell
yadm decrypt
```

### SSH Key Generation
From fish run the following commands
```shell
eval (ssh-agent -c)
ssh-add ~/.ssh/id_ed25519
```

