#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt install -y \
     gnome-terminal \
     fcitx-mozc \
     curl \
     git \
     build-essential \
     peco \
     shellcheck \
     emacs \
     emacs-goodies-el \
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
    rm -f "${HOME}/${configfile}"
    ln -s "${BASEDIR}/config/${configfile}" "${HOME}/${configfile}"
}

replace_bin "ghq"

replace_config ".bashrc"
