OPATH := $(dir $(lastword $(MAKEFILE_LIST)))
$(BUILD)/img/recovery.img: HOST ?= $(shell uuidgen --random)
$(BUILD)/img/recovery.img: overlay/base/layer.sh

define recovery.base =
cp -a overlay/base/etc $(TMP)
unshare -mr --map-auto sh -ec ' \
	mount --rbind /dev $(TMP)/dev; \
	mount --rbind /sys $(TMP)/sys; \
	mount --rbind /proc $(TMP)/proc; \
	mount --rbind /etc/resolv.conf $(TMP)/etc/resolv.conf; \
	mount --rbind $(BUILD)/cache $(TMP)/var/cache/xbps; \
	cat overlay/base/layer.sh | \
	chroot $(TMP) env - HOST=$(HOST) sh -l'
endef
