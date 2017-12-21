#!/bin/bash 
NDK=/Users/yaocui/Documents/adt-bundle-mac-x86_64-20140702/android-ndk-r13b
#NDK=/Users/yaocui/Documents/adt-bundle-mac-x86_64-20140702/sdk/ndk-bundle
SYSROOT=$NDK/platforms/android-21/arch-arm/
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
#TOOLCHAIN=$NDK/prebuilt/darwin-x86_64

function build_one {
./configure \
--prefix=$PREFIX \
--cc=$TOOLCHAIN/bin/arm-linux-androideabi-gcc \
--nm=$TOOLCHAIN/bin/arm-linux-androideabi-nm \
--enable-asm \
--enable-neon \
--enable-static \
--disable-shared \
--disable-doc \
--disable-asm \
--disable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--disable-ffserver \
--disable-postproc \
--disable-avdevice \
--disable-symver \
--disable-stripping \
--disable-muxers \
--disable-encoders \
--enable-encoder=aac \
--disable-decoders \
--enable-decoder=aac \
--disable-demuxers \
--enable-demuxer=aac \
--disable-parsers \
--enable-parser=aac \
--cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
--target-os=linux \
--arch=arm \
--cpu=armv7-a \
--enable-runtime-cpudetect \
--enable-gpl \
--enable-small \
--enable-cross-compile \
--sysroot=$SYSROOT \
--extra-cflags="-fPIC -DANDROID -mfpu=neon -mfloat-abi=softfp -I$NDK/platforms/android-21/arch-arm/usr/include -I$SYSROOT/usr/include" \
--extra-ldflags="$ADDI_LDFLAGS"

sed -i '' 's/HAVE_LRINT 0/HAVE_LRINT 1/g' config.h
sed -i '' 's/HAVE_LRINTF 0/HAVE_LRINTF 1/g' config.h
sed -i '' 's/HAVE_ROUND 0/HAVE_ROUND 1/g' config.h
sed -i '' 's/HAVE_ROUNDF 0/HAVE_ROUNDF 1/g' config.h
sed -i '' 's/HAVE_TRUNC 0/HAVE_TRUNC 1/g' config.h
sed -i '' 's/HAVE_TRUNCF 0/HAVE_TRUNCF 1/g' config.h
sed -i '' 's/HAVE_CBRT 0/HAVE_CBRT 1/g' config.h
sed -i '' 's/HAVE_RINT 0/HAVE_RINT 1/g' config.h
sed -i '' 's/HAVE_LOG2 1/HAVE_LOG2 0/g' config.h
sed -i '' 's/HAVE_LOG2F 1/HAVE_LOG2F 0/g' config.h

make clean
make -j4
make install

#--enable-libopencore-amrnb \
#--enable-libopencore-amrwb \
#--enable-libopus \
#--enable-gpl \
#--enable-nonfree \
#--enable-decoder=amrnb \
#--enable-decoder=amrwb \
#--enable-muxer=mov \
#--enable-muxer=mp4 \
#--enable-muxer=avi \
#--enable-decoder=aac \
#--enable-decoder=h264 \
#--enable-decoder=mpeg4 \
#--enable-demuxer=h264 \
#--enable-demuxer=avi \
#--enable-parser=aac \
#--enable-parser=h264 \
#需要在configure.h修改LOG2

}
#CPU=arm
#PREFIX=$(pwd)/android/$CPU
# arm v7vfp
CPU=armv7-a
OPTIMIZE_CFLAGS="-mfloat-abi=softfp -mfpu=vfp -marm -march=$CPU "
PREFIX=./android/$CPU-vfp
ADDI_CFLAGS="-marm"
build_one
