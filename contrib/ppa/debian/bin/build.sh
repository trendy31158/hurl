#!/bin/bash
set -Eeuo pipefail

echo "## untar pxf vendor.tar.xz:"
tar pxf vendor.tar.xz

echo "## install rustc and cargo"
echo "# actual rustc and cargo"
which rustc || true
which cargo || true
rustc --version || true
cargo --version || true
rust_version=$(grep '^rust-version' packages/hurl/Cargo.toml | cut -f2 -d'"')
rust_arch=$(uname -m)
package=rust-$rust_version-$rust_arch-unknown-linux-gnu
echo rust_version=$rust_version
echo rust_architecture=$rust_arch
echo package=$package
tar xf $package.tar.gz
mkdir -p /tmp/rust
./$package/install.sh --verbose --destdir=/tmp/rust --disable-ldconfig
export PATH="/tmp/rust/usr/local/bin:$PATH"
echo "# now rustc and cargo"
which rustc || true
which cargo || true
rustc --version || true
cargo --version || true

echo "## .cargo/config:"
cat .cargo/config

echo "## build:"
cargo build --release --frozen --verbose --package hurl
