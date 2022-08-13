#!/bin/sh
set -eu

mkdir -p package/usr/lib/vpngate
for f in vpngate-client namespaced-openvpn; do
    install -m 0755 "$f" "package/usr/lib/vpngate/$f"
done

tag=$(git describe --tags || echo "0.0.0")
version=${tag%%-*}

for type in deb "$@"; do
    fpm --input-type dir --output-type "${type}" --depends "openvpn" --architecture all -C package/ -n "$(basename `git rev-parse --show-toplevel`)" --version "${version}"
done