#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt install -y gnome-terminal fcitx-mozc curl git build-essential peco shellcheck emacs

BASEDIR=$(cd $(dirname $0); pwd)
BINDIR=${HOME}/bin

function replace_bin() {
    binfile="$1"
    rm -f "${BINDIR}/${binfile}"
    ln -s "${BASEDIR}/bin/${binfile}" "${BINDIR}/${binfile}"
}

replace_bin "ghq"
