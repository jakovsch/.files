#!/bin/sh -l
set -e

IFS=':'
DEFAULT="/etc/greetd/environment.d:${XDG_CONFIG_HOME:-$HOME/.config}/environment.d"

for path in ${ENVPATH:-$DEFAULT}; do
    [ -d "$path" ] && for f in "$path"/*.conf; do
        set -a
        [ -r "$f" ] && . "$f"
        set +a
    done
done

[ -x "$HOME/.session" ] && exec "$HOME/.session" "$@"
