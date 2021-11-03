# Dotfiles
This Repository contains my dotfiles as well as scripts to manage the installation and configuration of various applications.

It is managed by [YADM](https://yadm.io/).

Supported/tested systems:
* MacOS
* [ManjaroLinux](https://manjaro.org/)
* [Raspberry Pi OS](https://www.raspberrypi.com/software/)


## Installation
To install the Dotfiles, run either:
```shell
# this website links to https://github.com/TheLocehiliosan/yadm/blob/master/bootstrap
curl -L bootstrap.yadm.io | bash -s -- primeapple/dotfiles
```
or use the direct link
```shell
curl -L https://github.com/TheLocehiliosan/yadm/blob/master/bootstrap | bash -s -- primeapple/dotfiles
```

If asked to run the bootstrap script, please confirm. It will take care of installing yadm, your packages, etc.


## TODO

### General
* check if the bash script to install actually works
* add tests with docker-containers

### Packages
* Raspberry Pi Packages
* Manjaro Linux Packages

### Scripts
* SSH Key Gen Script
* Packages install script into bootstrap
* Font Install Script
