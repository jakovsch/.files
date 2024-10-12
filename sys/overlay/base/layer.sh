#!/bin/sh
set -e

update-ca-certificates
xbps-install -Suy xbps
xbps-install -uy void-repo-nonfree base-container
    # base-files {core,find,diff}utils util-linux iana-etc tzdata
    # dash grep sed gawk nvi which tar gzip shadow procps-ng runit-void
    # removed-packages glibc glibc-locales

PKGS=$(sed '/^\s*#/d' <<'EOF'
    # util: shell
    # lsof pv less file tree ncdu nano psmisc acl-progs attr-progs libcap-progs
    # zip unzip bzip2 xz lz4 zstd rclone restic rsync moreutils
    opendoas bash vpm vsv ufetch cpio binutils mdocml
    # util: net
    # iputils traceroute ldns whois openbsd-netcat socat curl openssl ethtool iw
    iproute2 nftables iptables-nft openssh
    # util: disk, fs
    # nvme-cli smartmontools hdparm sdparm parted e2fsprogs dosfstools
    gptfdisk btrfs-progs cryptsetup
    # util: stat, perf, boot
    # htop powertop nvtop wavemon pciutils usbutils efibootmgr
    sbctl sysstat lm_sensors cpupower glxinfo Vulkan-Tools libva-utils wayland-utils
    # util: pkg, virt
    # proot bubblewrap flatpak podman
    nix
    # sys: kernel, firmware
    linux-base linux-firmware linux kmod kpartx booster wifi-firmware sof-firmware
    systemd-boot-efistub
    # sys: service
    socklog-void snooze eudev elogind dbus polkit greetd acpid tlp bluez iwd nscd
    openresolv chrony tailscale
    # sys: lib
    acl attr pam kbd ncurses readline zlib fuse fuse3 vulkan-loader ocl-icd
    # mesa-dri mesa-vulkan-radeon mesa-vaapi mesa-vdpau libva libvdpau
    # sys: gui
    tuigreet
    # wayland xorg-server-xwayland wlr-randr fontconfig pulseaudio
    # data
    ca-certificates hwids man-pages mime-types
EOF
)

xbps-install -y $PKGS
xbps-pkgdb -m manual $PKGS
xbps-reconfigure -f glibc-locales
xbps-alternatives -s iptables-nft

rm /etc/*.new-* /etc/runit/runsvdir/default/*
ln -s /usr/share/zoneinfo/Europe/Zagreb /etc/localtime

test -n "$HOST"
echo "$HOST" > /etc/hostname
sed -i 's/localhost.*$/\0 '"$HOST/" /etc/hosts

chmod 0400 /etc/doas.conf
chmod +x /etc/boot/recovery/init
chmod +x /etc/kernel.d/post-install/*
chmod +x /etc/greetd/session.d/user.sh

usermod --lock root

while read SV
do
    ln -s /etc/sv/$SV /etc/runit/runsvdir/default/
done <<EOF
acpid
agetty-tty1
chronyd
dbus
ead
elogind
greetd
iwd
nanoklogd
nftables
nix-daemon
nscd
polkitd
rtkit
snooze-*
socklog-unix
sshd
tailscaled
tlp
udevd
EOF

kernel="$(ls /usr/lib/modules | head -1)"

booster build \
    --universal \
    --kernel-version=$kernel \
    --init-binary=/etc/boot/recovery/init \
    --config=/etc/boot/recovery/booster.yaml \
    recovery.img
sbctl bundle \
    --kernel-img /boot/vmlinuz-$kernel \
    --initramfs recovery.img \
    --cmdline /etc/boot/recovery/cmdline \
    --efi-stub /usr/lib/systemd/boot/efi/linuxx64.efi.stub \
    --save /boot/recovery.efi

rm recovery.img
rm -rf /media /tmp/* /run/*
ln -sr run/media /media
