#!/bin/bash

#
# extract-files-T00P ["adb" | "ota" | <OTA image file> | <basedir of device>]
#

export VENDOR=asus
export DEVICE_CODENAME=T00P
export DEVICE=
export DEVICE_COMMON=$DEVICE_CODENAME
export DEVICE_BRINGUP_YEAR=2018

OTA_BUILDNAME=12.4.5.57
OTA_SKU=JP
OTA_NAME=${DEVICE_CODENAME}-${OTA_SKU}-${OTA_BUILDNAME}
OTA_IMAGE_NAME=UL-ASUS_${OTA_NAME}-user.zip

WORKING_DIR=$PWD
TMP_DIR=/tmp/$OTA_NAME

function begin_ota_image() {
    local OTA_FILE=

    if [[ -z $1 || $1 == "ota" ]]; then
        if [[ ! -f "$OTA_FILE" ]]; then
            echo "Downloading OTA image ..."
            OTA_FILE=${TMP_DIR}/${OTA_IMAGE_NAME}
            wget -nc "http://dlcdnet.asus.com/pub/ASUS/ZenFone/A500KL/${OTA_IMAGE_NAME}" -O "$OTA_FILE"
        fi
    else
        OTA_FILE=$1
    fi

    local LAST_DIR=$PWD
    cd "$TMP_DIR"

    echo "Unarchiving OTA image ..."
    if ! unzip "$OTA_FILE"; then
        echo "!! Could not unzip: ${OTA_FILE}"
        return 1;
    fi

    echo "Converting system image ..."
    sdat2img.py system.transfer.list system.new.dat system.ext4.img

    echo "Mounting system ..."
    mkdir system

    if ! sudo mount -o loop -t ext4 system.ext4.img system; then
        echo "!! Could not mount system."
        return 1;
    fi

    cd "$LAST_DIR"
}

function end_ota_image() {
    local MOUNT_POINT=$TMP_DIR/system
    if [[ -d "$MOUNT_POINT" ]]; then
        sudo umount "$MOUNT_POINT"
    fi
}

function copy_ota_blobs() {
    echo "Copying blobs ..."

    local DEST_BASE=$WORKING_DIR/../../../vendor/$VENDOR/$DEVICE_CODENAME/proprietary
    rm -rf "$DEST_BASE/*"

    for FILE in `cat "$WORKING_DIR/proprietary-files.txt" | grep -v ^# | grep -v ^$ | sed -e 's#^-\(/\|\w\)#\1#g' | sed -e 's#^/system/##g' | sed -e 's#\.so|\w*$#.so#g'`; do
        local DEST_DIR=$DEST_BASE/$(dirname "$FILE")
        if [ ! -d "$DEST_DIR" ]; then
            mkdir -p "$DEST_DIR"
        fi
        echo "Copying $DEST_BASE/$FILE"
        if ! cp "$TMP_DIR/system/$FILE" "$DEST_BASE/$FILE"; then
            echo "!! Failed to copy."
            return 1;
        fi
    done
}

function extract_files_from() {
    local SRC=$1
    local EXTRACT_FILES="$WORKING_DIR/extract-files.sh"

    mkdir -p "$TMP_DIR"
    rm -rf "$TMP_DIR/*"

    if [[ -z "$SRC" || "$SRC" == "adb" ]]; then
        echo "Extracting from adb ..."
        $EXTRACT_FILES
    elif [[ -d "$SRC" ]]; then
        echo "Extracting from $SRC ..."
        $EXTRACT_FILES -d "$SRC"
    else
        if begin_ota_image "$SRC"; then
            echo "Extracting from $TMP_DIR ..."
            $EXTRACT_FILES -d "$TMP_DIR"
        fi
        end_ota_image
    fi

    rm -rf "$TMP_DIR"

    echo "All Done!"
}

extract_files_from "$1"
