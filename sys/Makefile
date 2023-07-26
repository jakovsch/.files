required = curl tar zstd openssl uuidgen
_ := $(foreach cmd,$(required),$(if \
	$(shell command -v $(cmd)),,$(error "required: $(cmd)") \
))

BUILD = build
KEYDIR = efi/keys
IMGDIR = $(BUILD)/img
TMPDIR = $(BUILD)/tmp
EFIVARS = pk kek db
EFIUUID = $(BUILD)/efi.uuid
CNAME = boot.schrama.xyz
KEYS = $(EFIVARS:%=$(KEYDIR)/%.key)
SIGS = $(EFIVARS:%=$(BUILD)/%.esl)
DIRS = $(BUILD)/dl $(BUILD)/pkg $(BUILD)/root $(TMPDIR) $(KEYDIR) $(IMGDIR)

sources = \
	https://uefi.org/sites/default/files/resources/DBXUpdate.bin \
	https://www.microsoft.com/pkiops/certs/MicWinProPCA2011_2011-10-19.crt \
	https://www.microsoft.com/pkiops/certs/MicCorUEFCA2011_2011-06-27.crt \
	https://repo-default.voidlinux.org/live/20221001/void-x86_64-musl-ROOTFS-20221001.tar.xz \
	https://archlinux.org/packages/extra/any/edk2-shell/download \
	https://archlinux.org/packages/extra/any/memtest86+-efi/download \
	https://archlinux.org/packages/extra/any/shim/download \
	https://archlinux.org/packages/extra/any/refind/download \
	https://archlinux.org/packages/extra/x86_64/efitools/download
sources := $(foreach i,$(sources),$(i:https://%=$(BUILD)/dl/%))
sources := $(foreach i,$(sources),$(i:%/download=%.pkg))

all: enrollimg espimg rootfs

enrollimg: $(DIRS) $(sources) $(SIGS) $(IMGDIR)/enroll.img

espimg: $(DIRS) $(sources) $(KEYS) $(IMGDIR)/esp.img

rootfs: $(DIRS) $(sources) $(KEYS) $(IMGDIR)/rootfs.img

$(IMGDIR)/enroll.img: TMP := $(shell mktemp -dp $(TMPDIR))
$(IMGDIR)/enroll.img:
	truncate -s 16MiB $@
	parted --script -a optimal $@ -- \
		mklabel gpt \
		mkpart esp fat16 1MiB 100% \
		set 1 esp on
	mkfs.vfat -F 16 -S 512 -n ENROLL --offset=2048 $@
	mkdir -p $(TMP)/EFI/BOOT
	cp $(BUILD)/pkg/usr/share/edk2-shell/x64/Shell_Full.efi $(TMP)/EFI/BOOT/BOOTX64.EFI
	cp $(BUILD)/pkg/usr/share/efitools/efi/UpdateVars.efi $(TMP)
	cp $(BUILD)/*.esl $(TMP)
	cp $(BUILD)/*.auth $(TMP)
	cp efi/startup.nsh $(TMP)/EFI/BOOT
	mcopy -Qsi $@@@1M $(TMP)/* ::/

$(IMGDIR)/esp.img: TMP := $(shell mktemp -dp $(TMPDIR))
$(IMGDIR)/esp.img:
	truncate -s 8GiB $@
	parted --script -a optimal $@ -- \
		mklabel gpt \
		mkpart esp fat32 1MiB 321MiB \
		mkpart data btrfs 321MiB 100% \
		set 1 esp on \
		set 2 msftdata on
	mkfs.vfat -F 32 -S 4096 -n ESP --offset=256 $@
	mkdir -p $(TMP)/EFI/BOOT/drivers
	mkdir -p $(TMP)/EFI/BOOT/theme
	mkdir -p $(TMP)/EFI/tools
	cp $(BUILD)/pkg/usr/share/refind/refind_x64.efi $(TMP)/EFI/BOOT/BOOTX64.EFI
	cp $(BUILD)/pkg/usr/share/refind/drivers_x64/btrfs_x64.efi $(TMP)/EFI/BOOT/drivers
	cp $(BUILD)/pkg/usr/share/refind/drivers_x64/ext4_x64.efi $(TMP)/EFI/BOOT/drivers
	cp $(BUILD)/pkg/usr/share/refind/drivers_x64/iso9660_x64.efi $(TMP)/EFI/BOOT/drivers
	cp $(BUILD)/pkg/usr/share/edk2-shell/x64/Shell_Full.efi $(TMP)/EFI/tools
	cp $(BUILD)/pkg/usr/share/shim/mmx64.efi $(TMP)/EFI/tools
	cp $(BUILD)/pkg/boot/memtest86+/memtest.efi $(TMP)/EFI/tools
	cp -r efi/theme/icons $(TMP)/EFI/BOOT/theme/icons
	cp -r efi/theme/fonts $(TMP)/EFI/BOOT/theme/fonts
	cp efi/refind.conf $(TMP)/EFI/BOOT
	cp efi/theme.conf $(TMP)/EFI/BOOT
	find $(TMP) -name *.efi | xargs -I % sbsign \
		--key $(KEYDIR)/db.key --cert $(KEYDIR)/db.crt --output % %
	mcopy -Qsi $@@@1M $(TMP)/* ::/

$(IMGDIR)/rootfs.img: TMP := $(shell mktemp -dp $(TMPDIR))
$(IMGDIR)/rootfs.img:
	truncate -s 8GiB $@
	cp --archive $(BUILD)/root $(TMP)/base
	cp -r etc $(TMP)/base/etc
	proot \
		-0 -r $(TMP)/base -w / \
		-b /dev -b /sys -b /proc -b /run -b /etc/resolv.conf \
		-b efi/keys:/etc/boot/keys \
		-b bootstrap.sh:/root/bootstrap.sh \
		su - -c "chmod +x bootstrap.sh && ./$$_"
	mkfs.btrfs \
		--metadata dup \
		--checksum xxhash \
		--nodesize 16KiB \
		--sectorsize 4096 \
		--features free-space-tree \
		--label data \
		--rootdir $(TMP) \
		--shrink --nodiscard $@

$(DIRS):
	mkdir -p $@

$(BUILD)/dl/%:
	curl -sSL --create-dirs -o $@ "https://$*"

$(BUILD)/dl/%.tar.xz:
	curl -sSL --create-dirs -o $@ "https://$*.tar.xz"
	tar -I xz -xf $@ --directory=$(BUILD)/root

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

$(EFIUUID):
	uuidgen --random > $@

clean:
	rm -rf $(BUILD)
