#!/bin/bash
# kola: { "exclusive": false }
set -xeuo pipefail

ok() {
    echo "ok" "$@"
}

fatal() {
    echo "$@" >&2
    exit 1
}

# Make sure that coreos-update-ca-trust kicked in and observe the result.
if ! systemctl show coreos-update-ca-trust.service -p ActiveState | grep ActiveState=active; then
    fatal "coreos-update-ca-trust.service not active"
fi
if ! grep '^# coreos.com$' /etc/pki/ca-trust/extracted/openssl/ca-bundle.trust.crt; then
    fatal "expected coreos.com in ca-bundle"
fi
ok "coreos-update-ca-trust.service"
