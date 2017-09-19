$(call inherit-product, device/softwinner/tulip-common/tulip_64_bit.mk)
$(call inherit-product, device/softwinner/tulip-common/tulip-common.mk)
$(call inherit-product, hardware/realtek/bluetooth/firmware/rtlbtfw_cfg.mk)

KERNEL_SRC_DIR ?= $(ANDROID_BUILD_TOP)/linux/kernel-tulip
KERNEL_CFG_NAME ?= sun50iw1p1smp_android
TARGET_KERNEL_ARCH ?= arm64

MALI_EXTRA_DEFINES := -DCONFIG_MALI400=1 -DCONFIG_MALI450=1 \
  -DCONFIG_MALI400_PROFILING=1 -DCONFIG_MALI_DMA_BUF_MAP_ON_ATTACH \
  -DCONFIG_MALI_DT

MALI_BUILD_FLAGS := CONFIG_MALI400=m CONFIG_MALI450=y CONFIG_MALI400_PROFILING=y \
  CONFIG_MALI_DMA_BUF_MAP_ON_ATTACH=y CONFIG_MALI_DT=y \
  EXTRA_DEFINES="$(MALI_EXTRA_DEFINES)"

# Check for availability of kernel source
ifneq ($(wildcard $(KERNEL_SRC_DIR)/Makefile),)
  # Give precedence to TARGET_PREBUILT_KERNEL
  ifeq ($(TARGET_PREBUILT_KERNEL),)
    TARGET_KERNEL_BUILT_FROM_SOURCE := true
  endif
endif

ifneq ($(TARGET_KERNEL_BUILT_FROM_SOURCE), true)
# Use prebuilt kernel
ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/softwinner/tulip-chiphd/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
PRODUCT_COPY_FILES += $(TARGET_PREBUILT_KERNEL_MODULES)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

endif # TARGET_KERNEL_BUILT_FROM_SOURCE

PRODUCT_PACKAGES += \
    hdmi_cec.tulip \
    power.tulip \
    input.evdev.default \
    busybox \
    static_busybox \
    ethtool \
    Camera \
    Bluetooth
    
##$(call inherit-product, vendor/ayufan-pine64/apps/vendor.mk)

DEVICE_PACKAGE_OVERLAYS += \
    device/softwinner/tulip-chiphd/overlay

PRODUCT_COPY_FILES += \
    device/softwinner/tulip-chiphd/fstab.sun50iw1p1:root/fstab.sun50iw1p1

PRODUCT_COPY_FILES += \
    device/softwinner/tulip-chiphd/init.sun50iw1p1.rc:root/init.sun50iw1p1.rc \
    device/softwinner/tulip-chiphd/init.recovery.sun50iw1p1.rc:root/init.recovery.sun50iw1p1.rc \
    device/softwinner/tulip-chiphd/ueventd.sun50iw1p1.rc:root/ueventd.sun50iw1p1.rc \
    device/softwinner/tulip-chiphd/initialize_disk.sh:root/initialize_disk.sh \
    device/softwinner/tulip-chiphd/configure_system.sh:system/bin/configure_system.sh \
    device/softwinner/tulip-chiphd/recovery.fstab:recovery.fstab

PRODUCT_COPY_FILES += \
    device/softwinner/tulip-chiphd/twrp.fstab:recovery/root/etc/twrp.fstab

PRODUCT_COPY_FILES += \
    device/softwinner/tulip-chiphd/bluetooth/rtkbt.conf:system/etc/bluetooth/rtkbt.conf

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.hdmi.cec.xml:system/etc/permissions/android.hardware.hdmi.cec.xml \

PRODUCT_COPY_FILES += \
    device/softwinner/tulip-chiphd/configs/gsensor.cfg:system/usr/gsensor.cfg \
    device/softwinner/tulip-chiphd/configs/media_profiles.xml:system/etc/media_profiles.xml \
    device/softwinner/tulip-chiphd/configs/sunxi-keyboard.kl:system/usr/keylayout/sunxi-keyboard.kl \
    device/softwinner/tulip-chiphd/configs/sunxi_ir_recv.kl:system/usr/keylayout/sunxi_ir_recv.kl \
    device/softwinner/tulip-chiphd/configs/gt9xxf_ts.idc:system/usr/idc/gt9xxf_ts.idc

PRODUCT_COPY_FILES += \
    device/softwinner/tulip-chiphd/wifi_efuse_8723bs-vq0.map:system/etc/wifi/wifi_efuse_8723bs-vq0.map \
    device/softwinner/tulip-chiphd/wifi_efuse_8723cs.map:system/etc/wifi/wifi_efuse_8723cs.map

#PRODUCT_COPY_FILES += \
    device/softwinner/tulip-chiphd/hawkview/sensor_list_cfg.ini:system/etc/hawkview/sensor_list_cfg.ini

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.boot.console=console

PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.8723b_bt.used=true

PRODUCT_PROPERTY_OVERRIDES += \
    persist.fw.force_adoptable=1 \
    persist.sys.usb.config=mtp,adb \
    ro.sf.lcd_density=120 \
    ro.adb.secure=0 \
    rw.logger=0 \
    persist.sys.root_access=3 # restore root and adb access

PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.firmware=v1.2.5

PRODUCT_PROPERTY_OVERRIDES += \
    ro.zygote.disable_gl_preload=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.spk_dul.used=false \

PRODUCT_PROPERTY_OVERRIDES += \
    persist.ota.server.ip=ota.pine64.org

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.timezone=America/Los_Angeles \
    persist.sys.country=US \
    persist.sys.language=en

#define virtual mouse key
PRODUCT_PROPERTY_OVERRIDES += \
    ro.softmouse.left.code=16 \
    ro.softmouse.right.code=17 \
    ro.softmouse.top.code=11 \
    ro.softmouse.bottom.code=14 \
    ro.softmouse.leftbtn.code=13 \
    ro.softmouse.midbtn.code=-1 \
    ro.softmouse.rightbtn.code=-1

PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    frameworks/native/data/etc/android.software.app_widgets.xml:system/etc/permissions/android.software.app_widgets.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:system/etc/permissions/android.software.freeform_window_management.xml \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    $(LOCAL_PATH)/subs/system/bin/aopt:system/bin/aopt \

# Widevine DRM blobs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/widevine/proprietary/libdrmframework.so:system/lib/arm/libdrmframework.so \
    $(LOCAL_PATH)/widevine/proprietary/libdrmwvmplugin.so:system/vendor/lib/drm/libdrmwvmplugin.so \
    $(LOCAL_PATH)/widevine/proprietary/libdrmdecrypt.so:system/vendor/lib/libdrmdecrypt.so \
    $(LOCAL_PATH)/widevine/proprietary/liboemcrypto.so:system/vendor/lib/liboemcrypto.so \
    $(LOCAL_PATH)/widevine/proprietary/libwvdrm_L1.so:system/vendor/lib/libwvdrm_L1.so \
    $(LOCAL_PATH)/widevine/proprietary/libwvm.so:system/vendor/lib/libwvm.so \
    $(LOCAL_PATH)/widevine/proprietary/libWVStreamControlAPI_L1.so:system/vendor/lib/libWVStreamControlAPI_L1.so \
    $(LOCAL_PATH)/widevine/proprietary/libwvdrmengine.so:system/vendor/lib/mediadrm/libwvdrmengine.so \

# Some CTS tests will be skipped based on what the initial API level that
# shipped on device was.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.first_api_level=24

# Boot animation
TARGET_SCREEN_HEIGHT := 1080    
TARGET_SCREEN_WIDTH := 1920

#OpenGAPPS
GAPPS_VARIANT := micro
PRODUCT_PACKAGES += Chrome \
	KeyboardGoogle \
	LatinImeGoogle \
	Hangouts \
    GoogleTTS \
    YouTube \
    PixelIcons \
    Wallpapers \
    WebViewGoogle  
           
GAPPS_FORCE_BROWSER_OVERRIDES := true

GAPPS_EXCLUDED_PACKAGES := FaceLock

# Inherit some common Bliss stuff.
$(call inherit-product, vendor/bliss/config/common.mk)

# Get GMS
$(call inherit-product-if-exists,vendor/google/products/gms.mk)

# Get SuperSU
$(call inherit-product-if-exists, vendor/supersu/vendor.mk)

# Get tablet dalvik parameters
$(call inherit-product,frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

