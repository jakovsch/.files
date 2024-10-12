#!/bin/sh
set -e

test -n "$USER"
test -n "$PASS"

useradd \
    -Uu 1000 -G wheel,kvm,network,bluetooth \
    --shell /bin/bash --create-home \
    "$USER"

echo "$USER:$PASS" | chpasswd
