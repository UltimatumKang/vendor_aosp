SUPERUSER_EMBEDDED := true
SUPERUSER_PACKAGE_PREFIX := com.android.settings.superuser

# brand
PRODUCT_BRAND ?= Ultimatum

# overrides
PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/ukg/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/ukg/prebuilt/common/etc/mkshrc:system/etc/mkshrc

# packages
PRODUCT_PACKAGES += \
    Camera \
    Development \
    CellBroadcastReceiver \
    DashClock \
    DefaultUKGWallpapers \
    Galaxy4 \
    HALO \
    HoloSpiralWallpaper \
    LiveWallpapers \
    Launcher2 \
    LiveWallpapersPicker \
    NoiseField \
    PermissionsManager \
    PhaseBeam \
    PhotoTable \
    Superuser \
    su \
    Torch \
    uTool \
    VoicePlus \
    Wallpapers

# dspmanager
PRODUCT_PACKAGES += \
    DSPManager \
    libcyanogen-dsp \
    audio_effects.conf

# prebuilts
PRODUCT_PACKAGES += \
    GooManager \
    LatinIME \

PRODUCT_PACKAGES += \
    e2fsck \
    mke2fs \
    tune2fs \
	nano \
	htop \
	powertop \
	lsof \
	mount.exfat \
	fsck.exfat \
	mkfs.exfat \
	ntfsfix \
	ntfs-3g

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# languages
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# themes
include vendor/ukg/config/theme_chooser.mk

#korean
$(call inherit-product-if-exists, external/naver-fonts/fonts.mk)

# overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/ukg/overlay/dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/ukg/overlay/common

# bin
PRODUCT_COPY_FILES += \
    vendor/ukg/prebuilt/common/bin/sysinit:system/bin/sysinit

# etc
PRODUCT_COPY_FILES += \
    vendor/ukg/prebuilt/common/etc/init.ukg.rc:root/init.ukg.rc

# prebuilt
PRODUCT_COPY_FILES += \
    vendor/ukg/prebuilt/common/xbin/sysro:system/xbin/sysro \
    vendor/ukg/prebuilt/common/xbin/sysrw:system/xbin/sysrw \
    vendor/ukg/prebuilt/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/ukg/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

#backup tool
UKG_BUILD = true
PRODUCT_COPY_FILES += \
    vendor/ukg/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/ukg/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/ukg/prebuilt/common/bin/50-ukg.sh:system/addon.d/50-ukg.sh \
    vendor/ukg/prebuilt/common/bin/blacklist:system/addon.d/blacklist

# sip/voip
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# nfc
PRODUCT_COPY_FILES += \
    vendor/ukg/config/permissions/com.ultimatum.android.xml:system/etc/permissions/com.ultimatum.android.xml \
    vendor/ukg/config/permissions/com.ultimatum.nfc.enhanced.xml:system/etc/permissions/com.ultimatum.nfc.enhanced.xml

# zram
PRODUCT_COPY_FILES += \
    vendor/ukg/prebuilt/common/bin/compcache:system/bin/compcache \
    vendor/ukg/prebuilt/common/bin/handle_compcache:system/bin/handle_compcache

#Set UKG_BUILDTYPE and goo.im properties
ifdef UKG_EXPERIMENTAL
    UKG_BUILDTYPE := EXPERIMENTAL
    PRODUCT_PROPERTY_OVERRIDES += \
#        ro.goo.rom=ukgexp \
#        ro.goo.developerid=ultimatumkang \
#        ro.goo.version=$(shell date -u +%Y%m%d)
endif
ifdef UKG_RELEASE
    UKG_BUILDTYPE := RELEASE
    PRODUCT_PROPERTY_OVERRIDES += \
#        ro.goo.rom=ukgrelease \
#        ro.goo.developerid=ultimatumkang \
#        ro.goo.version=$(shell date -u +%Y%m%d)
endif
#Set Unofficial if no buildtype set (Buildtype should ONLY be set by Xylon Devs!)
ifdef UKG_BUILDTYPE
else
    UKG_BUILDTYPE := RELEASE
    UKG_VERSION_MAJOR :=
    UKG_VERSION_MINOR :=
    UKG_VERSION_MAINTAINENCE :=
endif

# version
RELEASE = false
UKG_VERSION_MAJOR = 2
UKG_VERSION_MINOR = 9
UKG_VERSION_MAINTAINENCE = 8

#Set Ultimatum version
ifdef UKG_RELEASE
    UKG_VERSION := "uXYLON-JB422-$(UKG_BUILDTYPE)"-$(shell date +%Y%m%d-%H%M)
else
    UKG_VERSION := "uXYLON-JB422-v"$(UKG_VERSION_MAJOR).$(UKG_VERSION_MINOR).$(UKG_VERSION_MAINTAINENCE)-$(shell date +%Y%m%d-%H%M)
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.ukg.version=$(UKG_VERSION)
