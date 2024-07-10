# Dotfiles
This Repository contains my dotfiles as well as scripts to manage the installation and configuration of various applications.

It is managed by [YADM](https://yadm.io/).

Used for the following systems systems:
* MacOS
* [ManjaroLinux](https://manjaro.org/)
* [Arch Linux](https://archlinux.org/)
* [Raspberry Pi OS](https://www.raspberrypi.com/software/)

## Installation
To install the Dotfiles, install `yadm` and run:
```shell
yadm clone --no-bootstrap https://github.com/primeapple/dotfiles
```

Set the corresponding classes of the machine, if needed:
```shell
# if the machine run on nvidia gpu and needs graphical user interface
yadm config --add local.class nvidia
# if the machine needs graphical user interfaces
yadm config --add local.class workstation
```

Now run the bootstrap script:
```shell
yadm bootstrap
```

You may now need to do some more things:
```shell
yadm decrypt
chsh -s $(which fish)
```

### SSH Key Generation
From fish run the following commands
```shell
ssh-keygen -t ed25519 -C "toni.mueller.web@mailbox.org"
eval (ssh-agent -c)
ssh-add ~/.ssh/id_ed25519
```

