
if [[ $XCC -eq 1 ]];then
  JOBS="-j29"
  CC_ARGS="distcc arm-linux-gnueabihf-gcc"
  CXX_ARGS="distcc arm-linux-gnueabihf-g++"
  MAKE_EXTRA_OPTS="ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-" 
else
  JOBS="-j4"
  CC_ARGS="/usr/bin/gcc"
  CXX_ARGS="/usr/bin/g++"
  MAKE_EXTRA_OPTS=""
fi

mkdir -p ~/.local/bin && \
mkdir -p ~/.local/src/ffmpeg_sources && \
cp ffmpeg_build.patch ~/.local/src/ffmpeg_sources && \
cd ~/.local/src/ffmpeg_sources && git clone --depth=1 https://github.com/FFmpeg/FFmpeg.git || \
echo ${0##/*/}: Directory exists, so stashing changes instead of cloning!
cd ~/.local/src/ffmpeg_sources/FFmpeg && git stash; git reset --hard HEAD; make clean;

cd ~/.local/src/ffmpeg_sources/FFmpeg && \
#patch -p1 < ../ffmpeg_build.patch && \
#export CPPFLAGS="-I/usr/include/va -I/usr/include/vid.stab -I/usr/include/unicode -I/usr/lib/gcc/arm-linux-gnueabihf/10/include" && \
./configure --prefix=/usr --extra-version=4 --toolchain=hardened --libdir=/usr/lib/arm-linux-gnueabihf --incdir=/usr/include/arm-linux-gnueabihf --enable-gpl --disable-stripping --enable-libsoxr --enable-libpulse --enable-swresample --enable-gnutls --enable-ladspa --enable-libaom --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio --enable-libcodec2 --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libjack --enable-libmp3lame --enable-libmysofa --enable-libopenjpeg --enable-libopenmpt --enable-libopus --enable-libssh --enable-librsvg --enable-librubberband --enable-libshine --enable-libsnappy --enable-libspeex --enable-libssh --enable-libtheora --enable-libtwolame --enable-libvidstab --enable-libvorbis --enable-libvpx --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzmq --disable-doc --disable-htmlpages --disable-manpages --enable-libzvbi --enable-lv2 --enable-omx --enable-openal --enable-opengl --enable-sdl2 --enable-mmal --enable-omx-rpi --enable-decoder=h264_mmal --enable-decoder=mpeg2_mmal --enable-encoder=h264_omx --enable-libdc1394 --enable-libdrm --enable-libiec61883 --enable-chromaprint --enable-frei0r --enable-libx264 --enable-avisynth --enable-libsrt --enable-shared --enable-libfdk-aac --enable-nonfree --enable-liblensfun --enable-libopencore_amrnb --enable-version3 && \
time make ${JOBS} CC="${CC_ARGS}" CXX="${CXX_ARGS}" ${MAKE_EXTRA_OPTS} && \
sudo make install && \
make tools/qt-faststart && sudo cp tools/qt-faststart /usr/local/bin/ && sudo ldconfig
