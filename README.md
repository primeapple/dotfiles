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

Now run the bootstrap script:
```shell
yadm bootstrap
```

You may now need to do some more things:
```shell
yadm decrypt
chsh -s $(which fish)
```
