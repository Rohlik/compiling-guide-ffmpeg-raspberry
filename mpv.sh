
export PKG_CONFIG_PATH=/opt/vc/lib/pkgconfig && \
cd ~/.local/src/ffmpeg_sources && \
git clone --depth=1 https://github.com/mpv-player/mpv.git && \
cd mpv && \
wget "https://raw.githubusercontent.com/live-clones/recalbox/master/board/recalbox/patches/mpv/0001-mpv-no-egl-1-5-for-rpi.patch" && \
patch -p1 < 0001-mpv-no-egl-1-5-for-rpi.patch && \
./bootstrap.py && \
./waf configure --enable-rpi --enable-rpi-mmal --disable-vaapi --enable-egl-drm --enable-egl-x11  --disable-wayland --disable-android --disable-vdpau && \
./waf -j4 && sudo ./waf install 

