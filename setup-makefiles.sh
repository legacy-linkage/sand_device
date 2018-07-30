#!/bin/bash

VENDOR=asus
DEVICE=T00P
OUTDIR=vendor/$VENDOR/$DEVICE
MAKEFILE=../../../$OUTDIR/asus-blobs.mk

(cat << EOF) > $MAKEFILE
# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh
PRODUCT_COPY_FILES += \\
EOF

LINEEND=" \\"
COUNT=`cat proprietary-files.txt | grep -v ^# | grep -v ^$ | wc -l | awk {'print $1'}`
for FILE in `cat proprietary-files.txt | grep -v ^# | grep -v ^$ | sed -e 's#^/system/##g'`; do
    COUNT=`expr $COUNT - 1`
    if [ $COUNT = "0" ]; then
        LINEEND=""
    fi
    if [[ ! "$FILE" =~ ^-.* ]]; then
        FILE=`echo $FILE | sed -e "s/^-//g"`
        echo "    $OUTDIR/proprietary/$FILE:system/$FILE$LINEEND" >> $MAKEFILE
    fi
done

(cat << EOF) > ../../../$OUTDIR/$DEVICE-vendor.mk
# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

# Pick up overlay for features that depend on non-open-source files
DEVICE_PACKAGE_OVERLAYS := vendor/$VENDOR/$DEVICE/overlay

PRODUCT_PACKAGES += \\
    qcrilmsgtunnel \\
    shutdownlistener \\
    libtime_genoff \\
    libTimeService \\
    TimeService \\
    libqmi \\
    libqmiservices \\
    libidl \\
    libqcci_legacy \\
    libdiag \\
    libqmi_client_qmux \\
    libdsutils \\
    libmdmdetect \\
    libqmi_cci

\$(call inherit-product, vendor/$VENDOR/$DEVICE/asus-blobs.mk)
EOF

(cat << EOF) > ../../../$OUTDIR/BoardConfigVendor.mk
# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

USE_CAMERA_STUB := false
EOF

(cat << EOF) > ../../../$OUTDIR/Android.mk
# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

LOCAL_PATH := \$(call my-dir)

ifeq (\$(TARGET_BOARD_PLATFORM),msm8226)

ifeq (\$(QCPATH),)

include \$(CLEAR_VARS)
LOCAL_MODULE := qcrilmsgtunnel
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_SRC_FILES := proprietary/app/qcrilmsgtunnel/qcrilmsgtunnel.apk
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := \$(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_MODULE_CLASS := APPS
LOCAL_CERTIFICATE := platform
include \$(BUILD_PREBUILT)

include \$(CLEAR_VARS)
LOCAL_MODULE := shutdownlistener
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_SRC_FILES := proprietary/app/shutdownlistener/shutdownlistener.apk
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := \$(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_MODULE_CLASS := APPS
LOCAL_CERTIFICATE := platform
include \$(BUILD_PREBUILT)

include \$(CLEAR_VARS)
LOCAL_MODULE := libtime_genoff
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_SRC_FILES := proprietary/vendor/lib/libtime_genoff.so
LOCAL_MODULE_PATH := \$(TARGET_OUT_VENDOR_SHARED_LIBRARIES)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
include \$(BUILD_PREBUILT)

include \$(CLEAR_VARS)
LOCAL_MODULE := TimeService
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_SRC_FILES := proprietary/app/TimeService/TimeService.apk
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := \$(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_MODULE_CLASS := APPS
LOCAL_CERTIFICATE := platform
include \$(BUILD_PREBUILT)

include \$(CLEAR_VARS)
LOCAL_MODULE := com.qualcomm.location
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_SRC_FILES := proprietary/priv-app/com.qualcomm.location/com.qualcomm.location.apk
LOCAL_CERTIFICATE := platform
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := \$(COMMON_ANDROID_PACKAGE_SUFFIX)
# LOCAL_PRIVILEGED_MODULE := true
include \$(BUILD_PREBUILT)

include \$(CLEAR_VARS)
LOCAL_MODULE := qcnvitems
LOCAL_MODULE_OWNER := asus
LOCAL_SRC_FILES := proprietary/framework/qcnvitems.jar
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := .jar
include \$(BUILD_PREBUILT)

include \$(CLEAR_VARS)
LOCAL_MODULE := qcrilhook
LOCAL_MODULE_OWNER := asus
LOCAL_SRC_FILES := proprietary/framework/qcrilhook.jar
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := .jar
include \$(BUILD_PREBUILT)

include \$(CLEAR_VARS)
LOCAL_MODULE := libTimeService
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_SRC_FILES := proprietary/vendor/lib/libTimeService.so
LOCAL_MODULE_PATH := \$(TARGET_OUT_VENDOR_SHARED_LIBRARIES)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
include \$(BUILD_PREBUILT)

include \$(CLEAR_VARS)
LOCAL_MODULE := libqmi
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_SRC_FILES := proprietary/vendor/lib/libqmi.so
LOCAL_ADDITIONAL_DEPENDENCIES := libdiag libqmi_client_qmux libdsutils libmdmdetect
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := \$(TARGET_OUT_VENDOR_SHARED_LIBRARIES)
LOCAL_MULTILIB := both
include \$(BUILD_PREBUILT)

include \$(CLEAR_VARS)
LOCAL_MODULE := libqmiservices
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_SRC_FILES := proprietary/vendor/lib/libqmiservices.so
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := \$(TARGET_OUT_VENDOR_SHARED_LIBRARIES)
include \$(BUILD_PREBUILT)

include \$(CLEAR_VARS)
LOCAL_MODULE := libidl
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_SRC_FILES := proprietary/vendor/lib/libidl.so
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := \$(TARGET_OUT_VENDOR_SHARED_LIBRARIES)
include \$(BUILD_PREBUILT)

include \$(CLEAR_VARS)
LOCAL_MODULE := libqcci_legacy
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_SRC_FILES := proprietary/vendor/lib/libqcci_legacy.so
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := \$(TARGET_OUT_VENDOR_SHARED_LIBRARIES)
LOCAL_MULTILIB := both
include \$(BUILD_PREBUILT)

include \$(CLEAR_VARS)
LOCAL_MODULE := libdiag
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_SRC_FILES := proprietary/vendor/lib/libdiag.so
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := \$(TARGET_OUT_VENDOR_SHARED_LIBRARIES)
include \$(BUILD_PREBUILT)

include \$(CLEAR_VARS)
LOCAL_MODULE := libqmi_client_qmux
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_SRC_FILES := proprietary/vendor/lib/libqmi_client_qmux.so
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := \$(TARGET_OUT_VENDOR_SHARED_LIBRARIES)
include \$(BUILD_PREBUILT)

include \$(CLEAR_VARS)
LOCAL_MODULE := libdsutils
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_SRC_FILES := proprietary/vendor/lib/libdsutils.so
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := \$(TARGET_OUT_VENDOR_SHARED_LIBRARIES)
include \$(BUILD_PREBUILT)

include \$(CLEAR_VARS)
LOCAL_MODULE := libmdmdetect
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_SRC_FILES := proprietary/lib/libmdmdetect.so
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := \$(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_PROPRIETARY_MODULE := true
include \$(BUILD_PREBUILT)

include \$(CLEAR_VARS)
LOCAL_MODULE := liblisten
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_SRC_FILES := proprietary/vendor/lib/liblisten.so
LOCAL_MODULE_PATH := \$(TARGET_OUT_VENDOR_SHARED_LIBRARIES)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
include \$(BUILD_PREBUILT)

include \$(CLEAR_VARS)
LOCAL_MODULE := libwpa_qmi_eap_proxy
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_SRC_FILES := proprietary/lib/libwpa_qmi_eap_proxy.so
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := \$(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_PROPRIETARY_MODULE := true
include \$(BUILD_PREBUILT)

include \$(CLEAR_VARS)
LOCAL_MODULE := libqmi_cci
LOCAL_MODULE_OWNER := asus
LOCAL_SRC_FILES := proprietary/vendor/lib/libqmi_cci.so
LOCAL_MODULE_PATH := \$(TARGET_OUT_VENDOR_SHARED_LIBRARIES)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_PROPRIETARY_MODULE := true
include \$(BUILD_PREBUILT)

########### Asus apps start ###########3

include \$(CLEAR_VARS)
LOCAL_MODULE := asusCamera
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_SRC_FILES := proprietary/priv-app/AsusCamera/AsusCamera.apk
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := \$(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_MODULE_CLASS := APPS
LOCAL_CERTIFICATE := platform
LOCAL_PROPRIETARY_MODULE := true
LOCAL_OVERRIDES_PACKAGES := Camera2 Camera
# LOCAL_PRIVILEGED_MODULE := true
include \$(BUILD_PREBUILT)

endif

endif

EOF

