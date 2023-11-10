#!/bin/sh
# arch
# arch="aarch64"
arch="x86_64"

# version
version="v1.14.0"

# binディレクトリを作成
bin_dir="./bin"
mkdir -p "$bin_dir"

# mitamae
curl -sL -o "$bin_dir"/mitamae https://github.com/itamae-kitchen/mitamae/releases/download/"$version"/mitamae-"$arch"-linux
chmod +x "$bin_dir"/mitamae
"$bin_dir"/mitamae version