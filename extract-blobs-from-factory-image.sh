#!/bin/sh

VENDOR=asus
DEVICE=T00P
FIRMWARE_BUILDNAME=12.4.5.57
FIRMWARE_SKU=JP
FIRMWARE_NAME=${DEVICE}-${FIRMWARE_SKU}-${FIRMWARE_BUILDNAME}
FIRMWARE_ZIP=UL-ASUS_${FIRMWARE_NAME}-user.zip

WORKING_DIR=$PWD
TMP_DIR=/tmp/${FIRMWARE_NAME}

echo "Preparing ..."
if [ ! -f ${FIRMWARE_ZIP} ]; then
    wget -nc -q "http://dlcdnet.asus.com/pub/ASUS/ZenFone/A500KL/${FIRMWARE_ZIP}"
fi

echo "Unarchiving ..."
mkdir -p ${TMP_DIR}
cd ${TMP_DIR}
unzip ${WORKING_DIR}/${FIRMWARE_ZIP}

echo "Mounting system ..."
sdat2img.py system.transfer.list system.new.dat system.ext4.img
mkdir system
sudo mount -o loop -t ext4 system.ext4.img system

echo "Extracting blobs ..."
BASE=${WORKING_DIR}/../../../vendor/$VENDOR/$DEVICE/proprietary
rm -rf $BASE/*

for FILE in `cat ${WORKING_DIR}/proprietary-files.txt | grep -v ^# | grep -v ^$ | sed -e 's#^-\(/\|\w\)#\1#g' | sed -e 's#^/system/##g' | sed -e 's#\.so|\w*$#.so#g'`; do
    DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
        mkdir -p $BASE/$DIR
    fi
    echo "cp $FILE $BASE/$FILE"
    cp system/$FILE $BASE/$FILE
done

sudo umount system

cd ${WORKING_DIR}
rm -rf ${TMP_DIR}

echo "All Done!"
