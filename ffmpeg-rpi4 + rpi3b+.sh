
sudo apt build-dep ffmpeg && mkdir ffmpeg_sources && cd ~/ffmpeg_sources &&  git clone https://github.com/FFmpeg/FFmpeg.git && cd FFmpeg && \
./configure --prefix=/usr/local --enable-gpl --enable-nonfree --extra-libs="-lpthread -lm -latomic" --toolchain=hardened --enable-libvpx  \
--disable-vaapi --disable-stripping --libdir=/usr/local/lib/arm-linux-gnueabihf --incdir=/usr/local/include/arm-linux-gnueabihf \
--enable-libsoxr --enable-libpulse --enable-gnutls --enable-ladspa --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio \
--enable-libcodec2 --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libjack \
--enable-libmp3lame --enable-libmysofa --enable-libopenjpeg --enable-libopenmpt --enable-libssh --enable-librsvg  --enable-libshine \
--enable-libsnappy --enable-libspeex --enable-libopus  --enable-libtheora --enable-libtwolame --enable-libvorbis  --enable-libwebp \
--enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzmq --disable-doc --disable-htmlpages --disable-manpages --enable-libzvbi --enable-lv2 \
--enable-omx --enable-openal --enable-opengl --enable-sdl2 --enable-omx --enable-libdc1394 --enable-libdrm --enable-frei0r --enable-libx264  --enable-avisynth \
--enable-libsrt --enable-shared --enable-libfdk-aac  --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-version3  \
 --enable-libdav1d --enable-libsvtav1 --enable-lv2 --enable-libwebp --enable-libvpx --enable-libv4l2 --enable-libspeex   \
--enable-librubberband --enable-libaom   --enable-libkvazaar --enable-pthreads --enable-v4l2-m2m --cpu=cortex-a8 --arch=arm --enable-chromaprint \
--enable-libsnappy --enable-mmal --enable-omx-rpi --enable-decoder=h264_mmal --enable-decoder=mpeg2_mmal  --enable-encoder=h264_omx \
&& make -j4 && sudo make install && make tools/qt-faststart && sudo cp  tools/qt-faststart /usr/local/bin/ && sudo ldconfig
