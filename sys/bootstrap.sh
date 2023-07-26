#!/bin/sh
set -e

xbps-install -Suy xbps
xbps-install -uy

xbps-install -y \
    vpm vsv \
    void-repo-nonfree \
    base-minimal
    # base-files musl {core,find,diff}utils util-linux iana-etc tzdata
    # dash grep sed gawk nvi which tar gzip shadow procps-ng runit-void
    # removed-packages

PKGS=$(sed 's/#.*$//' <<'EOF'
    # util: shell
    opendoas bash moreutils lsof pv less file tree ncdu nano ufetch psmisc acl-progs attr-progs
    mdocml zip unzip bzip2 xz lz4 zstd cpio rclone restic rsync binutils
    # util: net
    iproute2 iputils nftables iptables-nft traceroute openbsd-netcat socat ldns whois
    openssl openssh curl ethtool iw
    # util: disk, fs
    nvme-cli smartmontools hdparm sdparm parted gptfdisk e2fsprogs btrfs-progs dosfstools
    cryptsetup
    # util: stat, perf, boot
    htop powertop nvtop wavemon pciutils usbutils sysstat lm_sensors cpupower efibootmgr sbctl
    glxinfo Vulkan-Tools wayland-utils wlr-randr
    # util: pkg, virt
    nix proot bubblewrap
    # sys: kernel, firmware
    linux-base linux-firmware linux kmod kpartx booster wifi-firmware sof-firmware bluez
    gummiboot-efistub
    # sys: service
    socklog-void snooze eudev elogind dbus acpid tlp iwd openresolv chrony tailscale pulseaudio
    # sys: lib
    pam kbd ncurses readline zlib fuse fuse3 mesa-dri mesa-vaapi mesa-vdpau mesa-vulkan-radeon
    vulkan-loader libva libvdpau wayland xorg-server-xwayland fontconfig
    # data
    ca-certificates hwids man-pages
EOF
)

vpm install -y $PKGS
xbps-pkgdb -m manual $PKGS
vpm removerecursive -y base-voidstrap
vpm setalternative iptables-nft

ln -sf /usr/share/zoneinfo/Europe/Zagreb /etc/localtime

while read SV
do
    ln -sf /etc/sv/$SV /etc/runit/runsvdir/default/
done <<EOF
dbus
socklog-unix
nanoklogd
EOF

chmod +x /etc/kernel.d/post-install/*
chmod +x /etc/boot/firstboot/init

mkdir -p /usr/share/secureboot/keys/PK
mkdir -p /usr/share/secureboot/keys/KEK
mkdir -p /usr/share/secureboot/keys/db
sbctl import-keys \
    --pk-key /etc/boot/keys/pk.key \
    --pk-cert /etc/boot/keys/pk.crt \
    --kek-key /etc/boot/keys/kek.key \
    --kek-cert /etc/boot/keys/kek.crt \
    --db-key /etc/boot/keys/db.key \
    --db-cert /etc/boot/keys/db.crt
