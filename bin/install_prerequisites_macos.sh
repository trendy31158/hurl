#!/bin/bash
set -Eeuo pipefail

echo "----- install prerequisite packages -----"
### install curl 8.5.0 waiting for 8.6.1 (https://github.com/curl/curl/issues/12844)
curl -o curl.rb https://raw.githubusercontent.com/Homebrew/homebrew-core/5f1b24e9882a1c1effa559a0000ff03ae155560b/Formula/c/curl.rb
brew uninstall --force --ignore-dependencies curl
brew install -s curl.rb
brew link curl --force
curl_path="$(brew --prefix curl)/bin"
echo "curl_path=$curl_path"
PATH="$curl_path:$PATH"
export PATH
###
brew install bash pkg-config squid
sudo squid -k shutdown || true
sudo rm -v /dev/shm/squid*.shm >/dev/null 2>&1 || true

