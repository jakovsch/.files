#https://github.com/NixOS/nix/blob/3be58fe1bc781fd39649f616c8ba4e5be672d505/scripts/nix-profile-daemon.sh.in

if grep -q "use-xdg-base-directories = true" "${NIX_CONF_DIR:-/etc/nix}/nix.conf"; then
	NIX_LINK="${XDG_STATE_HOME:-$HOME/.local/state}/nix/"
else
	NIX_LINK="$HOME/.nix-"
fi

NIX_USER_PROFILE_DIR="/nix/var/nix/profiles/per-user/$USER"
NIX_USER_GCROOTS_DIR="/nix/var/nix/gcroots/per-user/$USER"

if ! test -e "$NIX_USER_PROFILE_DIR"; then
	mkdir -m 0755 -p "$NIX_USER_PROFILE_DIR"
fi

if ! test -O "$NIX_USER_PROFILE_DIR"; then
	echo "nix: bad ownership on $NIX_USER_PROFILE_DIR" >&2
fi

if ! test -e "$NIX_USER_GCROOTS_DIR"; then
	mkdir -m 0755 -p "$NIX_USER_GCROOTS_DIR"
fi

if ! test -O "$NIX_USER_GCROOTS_DIR"; then
	echo "nix: bad ownership on $NIX_USER_GCROOTS_DIR" >&2
fi

if test -w "$HOME"; then
	if ! test -L "$NIX_LINK"'profile'; then
		if test "$USER" != root; then
			ln -s "$NIX_USER_PROFILE_DIR/profile" "$NIX_LINK"'profile'
		else
			ln -s /nix/var/nix/profiles/default "$NIX_LINK"'profile'
		fi
	fi

	if ! test -e "$NIX_LINK"'channels'; then
		echo "https://nixos.org/channels/nixpkgs-unstable nixpkgs" > "$NIX_LINK"'channels'
	fi

	if ! test -e "$NIX_LINK"'defexpr'; then
		mkdir -p "$NIX_LINK"'defexpr'
		ln -s "$NIX_USER_PROFILE_DIR/channels" "$NIX_LINK"'defexpr/channels'
		if test "$USER" != root; then
			ln -s /nix/var/nix/profiles/per-user/root/channels "$NIX_LINK"'defexpr/channels_root'
		fi
	fi
fi

#export NIX_PATH="$NIX_LINK"'defexpr/channels'
export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
export NIX_PROFILES="/nix/var/nix/profiles/default $NIX_LINK"'profile'
export PATH="$NIX_LINK""profile/bin:/nix/var/nix/profiles/default/bin:$PATH"
export XDG_DATA_DIRS="$NIX_LINK""profile/share:/nix/var/nix/profiles/default/share:$XDG_DATA_DIRS"
