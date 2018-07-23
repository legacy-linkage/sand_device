# Release name
PRODUCT_RELEASE_NAME := T00P

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/asus/T00P/device_T00P.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := T00P
PRODUCT_NAME := cm_T00P
PRODUCT_BRAND := asus
PRODUCT_MODEL := ASUS_T00P
PRODUCT_MANUFACTURER := asus

TARGET_VENDOR_PRODUCT_NAME := JP_Phone
TARGET_VENDOR_DEVICE_NAME := ASUS_T00P

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE=ASUS_T00P \
	PRODUCT_NAME=JP_Phone
