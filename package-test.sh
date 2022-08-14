#!/bin/bash
set -euxo pipefail

curl_test() {
    for i in {1..60}; do
        if ip netns exec protected ping -c 1 kernel.org; then
            return 0
        fi
        sleep 1
    done
    return 1
}

systemctl enable --now vpngate.service
systemctl status --no-pager vpngate.service

curl_test

systemctl stop vpngate.service