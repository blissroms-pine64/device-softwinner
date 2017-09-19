# Boot animation
TARGET_SCREEN_HEIGHT := 480	
TARGET_SCREEN_WIDTH := 800

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/bliss/config/common.mk)

# Inherit device configuration
$(call inherit-product, device/softwinner/tulip-chiphd/tulip-chiphd.mk)

## Device identifier. This must come after all inclusions
PRODUCT_BRAND := Allwinner
PRODUCT_NAME := bliss_tulip_chiphd
PRODUCT_MODEL := PINE A64
PRODUCT_MANUFACTURER := Allwinner

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=fugu \
    BUILD_FINGERPRINT=google/fugu/fugu:7.1.2/N2G47H/3783593:user/release-keys \
    PRIVATE_BUILD_DESC="fugu-user 7.1.2 N2G47H 3783593 release-keys"
