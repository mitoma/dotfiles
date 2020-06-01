#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt install -y \
     fcitx-mozc \
     curl \
     git \
     build-essential \
     peco \
     shellcheck \
     vim \
     emacs emacs-goodies-el \
     screen

BASEDIR=$(cd "$(dirname "$0")" || return; pwd)
BINDIR=${HOME}/bin

function replace_bin() {
    binfile="$1"
    rm -f "${BINDIR}/${binfile}"
    ln -s "${BASEDIR}/bin/${binfile}" "${BINDIR}/${binfile}"
}

function replace_config() {
    configfile="$1"
    configdir=$(dirname "$configfile")
    mkdir -p "${HOME}/${configdir}"
    rm -f "${HOME}/${configfile}"
    ln -s "${BASEDIR}/config/${configfile}" "${HOME}/${configfile}"
}

replace_bin "ghq"
replace_bin "terraform"

replace_config ".bashrc"
replace_config ".gitconfig"
replace_config ".screenrc"
replace_config ".emacs.d/init.el"
replace_config ".config/peco/config.json"
