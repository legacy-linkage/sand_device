#!/bin/bash

export VENDOR=asus
export DEVICE=T00P
export DEVICE_COMMON=$DEVICE
export DEVICE_BRINGUP_YEAR=2018

FIRMWARE_BUILDNAME=12.4.5.57
FIRMWARE_SKU=JP
FIRMWARE_NAME=${DEVICE}-${FIRMWARE_SKU}-${FIRMWARE_BUILDNAME}
FIRMWARE_ZIP_NAME=UL-ASUS_${FIRMWARE_NAME}-user.zip
FIRMWARE_ZIP_FILE=

WORKING_DIR=$PWD
TMP_DIR=/tmp/${FIRMWARE_NAME}

echo "Preparing ..."
if [[ ! -z $1 && -f $1 ]]; then
    FIRMWARE_ZIP_FILE=$1
else
    FIRMWARE_ZIP_FILE=${TMP_DIR}/${FIRMWARE_ZIP_NAME}
    if [ ! -f FIRMWARE_ZIP_FILE ]; then
        wget -nc -q "http://dlcdnet.asus.com/pub/ASUS/ZenFone/A500KL/${FIRMWARE_ZIP_NAME}" -O "${FIRMWARE_ZIP_FILE}"
    fi
fi

echo "Unarchiving ..."
mkdir -p ${TMP_DIR}
rm -rf ${TMP_DIR}/*
cd ${TMP_DIR}
unzip ${FIRMWARE_ZIP_FILE}

echo "Mounting system ..."
sdat2img.py system.transfer.list system.new.dat system.ext4.img
mkdir system
sudo mount -o loop -t ext4 system.ext4.img system

echo "Extracting blobs ..."
#BASE=${WORKING_DIR}/../../../vendor/$VENDOR/$DEVICE/proprietary
#rm -rf $BASE/*

#for FILE in `cat ${WORKING_DIR}/proprietary-files.txt | grep -v ^# | grep -v ^$ | sed -e 's#^-\(/\|\w\)#\1#g' | sed -e 's#^/system/##g' | sed -e 's#\.so|\w*$#.so#g'`; do
#    DIR=`dirname $FILE`
#    if [ ! -d $BASE/$DIR ]; then
#        mkdir -p $BASE/$DIR
#    fi
#    echo "cp $FILE $BASE/$FILE"
#    cp system/$FILE $BASE/$FILE
#done

cd ${WORKING_DIR}
./extract-files.sh -d ${TMP_DIR}

sudo umount ${TMP_DIR}/system

rm -rf ${TMP_DIR}

echo "All Done!"
