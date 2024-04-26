#!/usr/bin/env bash

set -e

pushd ~/.dotfiles/nixos/

alejandra . >/dev/null

git add .

read -p "Press enter to continue"

echo "NixOS Rebuilding..."

sudo nixos-rebuild switch --flake .#default

current=$(nixos-rebuild list-generations --flake .#default --json | jq '.[0].generation')

git commit -a -m "gen: $current"

popd

notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available