define NL


endef

required = curl tar zstd openssl uuidgen
$(foreach cmd,$(required),$(if \
	$(shell command -v $(cmd)),,$(error "required: $(cmd)") \
))

BUILD ?= build
KEYDIR ?= efi/keys
TMPDIR ?= $(BUILD)/tmp

EFIUUID = $(BUILD)/efi.uuid
EFIVARS = pk kek db
CNAME = boot.schrama.xyz

KEYS = $(EFIVARS:%=$(KEYDIR)/%.key)
SIGS = $(EFIVARS:%=$(BUILD)/%.esl)
DIRS = $(BUILD)/dl $(BUILD)/img $(BUILD)/pkg $(BUILD)/cache $(TMPDIR) $(KEYDIR)

overlays ?= base user
include $(foreach i,$(overlays),$(i:%=overlay/%/Makefile))

sources = \
	https://uefi.org/sites/default/files/resources/DBXUpdate.bin \
	https://www.microsoft.com/pkiops/certs/MicWinProPCA2011_2011-10-19.crt \
	https://www.microsoft.com/pkiops/certs/MicCorUEFCA2011_2011-06-27.crt \
	https://repo-default.voidlinux.org/static/xbps-static-latest.x86_64-musl.tar.xz \
	https://github.com/pbatard/efifs/releases/download/v1.10/erofs_x64.efi \
	https://archlinux.org/packages/extra/any/edk2-shell/download \
	https://archlinux.org/packages/extra/any/memtest86+-efi/download \
	https://archlinux.org/packages/extra/any/shim/download \
	https://archlinux.org/packages/extra/any/refind/download \
	https://archlinux.org/packages/extra/x86_64/efitools/download
sources := $(foreach i,$(sources),$(i:https://%=$(BUILD)/dl/%))
sources := $(foreach i,$(sources),$(i:%/download=%.pkg))

.PHONY: all clean enroll boot recovery
all: enroll boot recovery
enroll: $(BUILD)/img/enroll.img
boot: $(BUILD)/img/esp.img
recovery: $(BUILD)/img/recovery.img

clean:
	rm -rf $(TMPDIR) $(BUILD)

$(BUILD)/%.img: $(sources) | $(DIRS)

$(BUILD)/img/enroll.img: TMP := $(shell mktemp -dp $(TMPDIR))
$(BUILD)/img/enroll.img: $(SIGS)
	truncate -s 16MiB $@
	parted -sa optimal $@ -- \
		mklabel gpt \
		mkpart esp fat16 1MiB 100% \
		set 1 esp on
	mkfs.fat -F 16 -S 512 -n ENROLL --offset=2048 $@
	mkdir -p $(TMP)/EFI/BOOT
	cp $(BUILD)/pkg/usr/share/edk2-shell/x64/Shell_Full.efi $(TMP)/EFI/BOOT/BOOTX64.EFI
	cp $(BUILD)/pkg/usr/share/efitools/efi/UpdateVars.efi $(TMP)
	cp $(BUILD)/*.esl $(TMP)
	cp $(BUILD)/*.auth $(TMP)
	cp efi/startup.nsh $(TMP)/EFI/BOOT
	mcopy -Qsi $@@@1M $(TMP)/* ::/

$(BUILD)/img/esp.img: TMP := $(shell mktemp -dp $(TMPDIR))
$(BUILD)/img/esp.img: $(KEYS)
	mkdir -p $(TMP)/EFI/tools
	mkdir -p $(TMP)/EFI/BOOT/theme
	mkdir -p $(TMP)/EFI/BOOT/drivers
	cp $(BUILD)/pkg/usr/share/refind/refind_x64.efi $(TMP)/EFI/BOOT/BOOTX64.EFI
	cp $(BUILD)/pkg/usr/share/refind/drivers_x64/btrfs_x64.efi $(TMP)/EFI/BOOT/drivers
	cp $(BUILD)/pkg/usr/share/refind/drivers_x64/ext4_x64.efi $(TMP)/EFI/BOOT/drivers
	cp $(BUILD)/pkg/usr/share/refind/drivers_x64/iso9660_x64.efi $(TMP)/EFI/BOOT/drivers
	cp $(BUILD)/pkg/usr/share/edk2-shell/x64/Shell_Full.efi $(TMP)/EFI/tools/shell.efi
	cp $(BUILD)/pkg/usr/share/shim/mmx64.efi $(TMP)/EFI/tools/mmx64.efi
	cp $(BUILD)/pkg/boot/memtest86+/memtest.efi $(TMP)/EFI/tools/memtest86.efi
	cp $(BUILD)/dl/github.com/pbatard/efifs/releases/download/v1.10/erofs_x64.efi $(TMP)/EFI/BOOT/drivers
	cp -r efi/theme/icons $(TMP)/EFI/BOOT/theme/icons
	cp -r efi/theme/fonts $(TMP)/EFI/BOOT/theme/fonts
	cp efi/refind.conf $(TMP)/EFI/BOOT
	cp efi/theme.conf $(TMP)/EFI/BOOT
	find $(TMP) -name '*.efi' ! -name 'shell.efi' | xargs -I % sbsign \
		--key $(KEYDIR)/db.key --cert $(KEYDIR)/db.crt --output % %
	mkfs.fat -F 16 -s 1 -C -S 4096 $@ 32768
	mcopy -Qsi $@ $(TMP)/* ::/

$(BUILD)/img/recovery.img: TMP := $(shell mktemp -dp $(TMPDIR))
$(BUILD)/img/recovery.img: $(KEYS)
	mkdir -p $(TMP)/var/db/xbps $(TMP)/var/cache/xbps
	cp -a $(BUILD)/pkg/var/db/xbps/keys $(TMP)/var/db/xbps
	XBPS_ARCH=x86_64 unshare -r --map-auto \
		$(BUILD)/pkg/usr/bin/xbps-install.static \
		-R https://repo-default.voidlinux.org/current \
		-c $(realpath $(BUILD))/cache -r $(TMP) -Sy base-container
	$(foreach i,$(overlays),$(recovery.$(i))$(NL))
	find $(TMP)/boot -name '*.efi' | xargs -I % sbsign \
		--key $(KEYDIR)/db.key --cert $(KEYDIR)/db.crt --output % %
	unshare -r --map-auto mkfs.erofs \
		-L recovery \
		-b4096 \
		$@ $(TMP)

$(DIRS):
	mkdir -p $@

$(BUILD)/dl/%:
	curl -sSL --create-dirs -o $@ "https://$*"

$(BUILD)/dl/%.tar.xz:
	curl -sSL --create-dirs -o $@ "https://$*.tar.xz"
	tar -I xz -xf $@ --directory=$(BUILD)/pkg

$(BUILD)/dl/%.pkg:
	curl -sSL --create-dirs -o $@ "https://$*/download"
	tar -I zstd -xf $@ --directory=$(BUILD)/pkg

%.esl: SIGNKEY = $(if $(findstring db,$(notdir $*)),kek,pk)
%.esl: $(KEYS) $(EFIUUID)
	cert-to-efi-sig-list -g "$(shell cat $(EFIUUID))" $(KEYDIR)/$(notdir $*).crt $@
	sign-efi-sig-list -t "$(shell date -u --rfc-3339=s)" \
		-k $(KEYDIR)/$(SIGNKEY).key -c $(KEYDIR)/$(SIGNKEY).crt $(notdir $*) $@ $*.auth

%.key:
	openssl req -new -newkey rsa:2048 -x509 -days 3650 -nodes -sha256 \
		-subj "/CN=$*.$(CNAME)/" -keyout $@ -out $*.crt
	openssl x509 -in $*.crt -out $*.cer -outform DER
	chmod go-rwx $@

%.uuid:
	uuidgen --random > $@
