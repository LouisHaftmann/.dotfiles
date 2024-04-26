#!/usr/bin/env bash

set -e

pushd ~/.dotfiles/nixos/

sudo nix flake update

popd


pushd ~/.dotfiles

./rebuild.sh

popd

