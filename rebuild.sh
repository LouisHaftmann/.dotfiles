#!/usr/bin/env bash

set -e

pushd ~/.dotfiles/nixos/

alejandra . >/dev/null

echo "NixOS Rebuilding..."

sudo nixos-rebuild switch --flake .#default

popd

notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available