OPATH := $(dir $(lastword $(MAKEFILE_LIST)))
$(BUILD)/img/recovery.img: USER ?= $(error "unset: username")
$(BUILD)/img/recovery.img: PASS ?= $(error "unset: password")
$(BUILD)/img/recovery.img: overlay/user/layer.sh

define recovery.user =
unshare -mr --map-auto sh -ec ' \
	mount --rbind /dev $(TMP)/dev; \
	mount --rbind /sys $(TMP)/sys; \
	mount --rbind /proc $(TMP)/proc; \
	cat overlay/user/layer.sh | \
	chroot $(TMP) env - USER=$(USER) PASS=$(PASS) sh -l'
endef
