#!/bin/sh
enable_cross_compile="disable"	# enable/disable

enable_shared_libs="disable"	# enable/disable
cross_prefix="arm-fullhan-linux-uclibcgnueabi-"
output_path="./build"
enable_x264="disable"	# enable/disable


# Fetch Sources
if [ ! -d ffmpeg/ffmpeg-3.3 ]; then
	mkdir ffmpeg && cd 	ffmpeg
	wget http://ffmpeg.org/releases/ffmpeg-3.3.tar.bz2
	tar xf ffmpeg-3.3.tar.bz2
	cd -
fi

# x264
if [ "$enable_x264" = "enable" ]; then
	sh build-x264.sh $enable_shared_libs $enable_cross_compile $cross_prefix
	x264_lib_path="../../x264/build/lib"
	x264_inc_path="../../x264/build/include"
	extra_lib_cflags="--enable-libx264 --enable-gpl --extra-cflags=-I$x264_inc_path --extra-ldflags=-L$x264_lib_path"
fi

# shared libs, default static
if [ "$enable_shared_libs" = "enable" ]; then
	shared_libs_cflags="--enable-shared --disable-static"
fi

# Cross compile cflags
if [ "$enable_cross_compile" = "enable" ]; then
	cross_pri_cflags="--cross-prefix=$cross_prefix --enable-cross-compile --target-os=linux --target-os=linux  --arch=arm"
fi

# ./configure
pri_cflags="$cross_pri_cflags
			--prefix=$output_path --disable-yasm
			--disable-ffplay --disable-ffprobe  --disable-ffserver 
			$shared_libs_cflags
			$extra_lib_cflags
			--disable-everything 
			--enable-decoder=h264 --enable-decoder=hevc
			--enable-protocol=file 
			--enable-demuxer=avi --enable-demuxer=h264 --enable-demuxer=hevc
			--enable-muxer=avi --enable-encoder=mpeg4
			--enable-parser=h264 --enable-parser=hevc
			--enable-small --disable-debug --disable-doc
			--disable-avdevice --disable-swscale --disable-postproc"

echo "sh configure $pri_cflags"
cd ffmpeg/ffmpeg-3.3 && sh configure $pri_cflags

# make & install
make -j4 && make install

[ ! $? = 0 ] && echo "#### try: make -C ffmpeg/ffmpeg-3.3 distclean"

echo "#### make install success. output path = ffmpeg/ffmpeg-3.3/build"

#
# test cmd: "./ffmpeg -i test.h264 output.avi" "./ffmpeg -i test.h265 output.avi"
# --enable-demuxer=h264 --enable-demuxer=hevc used for "Invalid data found when processing input"
# --enable-parser=h264 --enable-parser=hevc, used for input file parser.
# --enable-muxer=avi --enable-encoder=mpeg4, need for avi encoding.
# --enable-protocol=file , if add it, "./ffmpeg -i test.h264 output.avi" will be abnormal(Protocol not found).
# --disable-avfilter --disable-swresample, if add it, ffmpeg bin cannot build.
# if ./ffmpeg -version ==> "libavfilter.so.6: cannot open shared object file", try: make -C ffmpeg/ffmpeg-3.3 distclean.
#
# libx264: used for encoding h264 streams, default disable it.
#