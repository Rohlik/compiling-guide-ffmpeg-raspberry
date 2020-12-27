hi everybody !!!

sorry for my bad english

compilations guide for:
ALL Raspberrys and ubuntu rpi

its very easy !!!

you can play movies without overheating

CPU runtime 15 %

you can stream cammera output and audio over ssh

ssh only automatic login work

```shell=bash
ssh user@host ffmpeg -fflags nobuffer  -hide_banner -y \
  -f alsa -ac 1 -i hw:CARD=Device,DEV=0 \
  -f v4l2 -re -i /dev/video0 -c:v h264_omx -profile:v high -level 4 -pix_fmt yuv420p -g 45 -bf 2 -trellis 2 -cmp 2 -subcmp 2 -b:v 1200k -c:a libfdk_aac -profile:a aac_he -b:a 128k -movflags +faststart  \
  -f mpegts - | mpv --profile=low-latency -
```

you can find your alsa device by `aplay -L` and rename `hw:CARD`

encode and decode movies and music

convert movies and music in other formats

`x11grab` for recording desktop

```shell=bash
ffmpeg -hide_banner -f pulse -ac 2 -i default -f x11grab -framerate 25 -video_size 1920x1080 -i :0.0+0,0 -c:v h264_omx -pix_fmt yuv420p -b:v 1200k -c:a libfdk_aac -b:a 128k -ar 48000 testvideo.mp4
```

download a movie

```shell=bash
ffmpeg -i http://url -c:v copy -c:a copy output.mp4
```

# INSTALL  STEP BY STEP 

best setting is download ubuntu 20.10 groovy **32bit** (currently only availably on Server flavor)

then change the line in `/etc/fstab` that contains `/boot/firmware` to `/boot` instead

`reboot`

[Install Raspian kernel](https://www.raspberrypi.org/documentation/linux/kernel/building.md)

Link Ubuntu's directories where rpi packages expect them:

```shell=bash
ln -s /usr /opt/vc

```

Uncomment the `deb-src` lines in `/etc/apt/sources.list`, then install the dependecies for the packages:

```shell=bash
sudo apt build-dep ffmpeg mpv vlc mesa llvm mplayer
```

```shell=bash
cd ~/.local/src/ffmpeg_sources && git clone --depth=1 https://github.com/AviSynth/AviSynthPlus.git && \
cd ~/.local/src/ffmpeg_sources/AviSynthPlus && \
mkdir avisynth-build && cd avisynth-build && \
cmake ../ -DHEADERS_ONLY:bool=on && \
cd ../ && sudo make install  && sudo ldconfig
```

# FFmpeg (./ffmpeg.sh)

```shell=bash
mkdir -p ~/.local/bin && \
mkdir -p ~/.local/src/ffmpeg_sources && \
cd ~/.local/src/ffmpeg_sources && git clone --depth=1 https://github.com/FFmpeg/FFmpeg.git && cd ~/.local/src/ffmpeg_sources/FFmpeg && \
./configure --prefix=/usr --extra-version=4 --toolchain=hardened --libdir=/usr/lib/arm-linux-gnueabihf --incdir=/usr/include/arm-linux-gnueabihf --enable-gpl --disable-stripping --enable-libsoxr --enable-libpulse --enable-swresample --enable-gnutls --enable-ladspa --enable-libaom --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio --enable-libcodec2 --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libjack --enable-libmp3lame --enable-libmysofa --enable-libopenjpeg --enable-libopenmpt --enable-libopus --enable-libssh --enable-librsvg --enable-librubberband --enable-libshine --enable-libsnappy --enable-libspeex --enable-libssh --enable-libtheora --enable-libtwolame --enable-libvidstab --enable-libvorbis --enable-libvpx --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzmq --disable-doc --disable-htmlpages --disable-manpages --enable-libzvbi --enable-lv2 --enable-omx --enable-openal --enable-opengl --enable-sdl2 --enable-mmal --enable-omx-rpi --enable-decoder=h264_mmal --enable-decoder=mpeg2_mmal --enable-encoder=h264_omx --enable-libdc1394 --enable-libdrm --enable-libiec61883 --enable-chromaprint --enable-frei0r --enable-libx264 --enable-avisynth --enable-libsrt --enable-shared --enable-libfdk-aac --enable-nonfree --enable-liblensfun --enable-libopencore_amrnb --enable-version3
make -j4
sudo make install
make tools/qt-faststart && sudo cp tools/qt-faststart /usr/local/bin/ && sudo ldconfig
```

# mpv (./mpv)

```shell
cd ~/.local/src/ffmpeg_sources  && \
git clone --depth=1 https://github.com/mpv-player/mpv.git && \
cd ~/.local/src/ffmpeg_sources/mpv && \
./bootstrap.py && \
export PKG_CONFIG_PATH=/opt/vc/lib/pkgconfig && ./waf configure --enable-rpi --enable-rpi-mmal  \
--enable-egl-drm --enable-gl-x11 --enable-egl --enable-sdl2 --enable-ffmpeg-strict-abi --disable-libavdevice \
--enable-xv --enable-egl-x11 --enable-libmpv-shared && \
./waf -j4 && sudo ./waf install && sudo ldconfig
```

# vlc (./vlc)

```shell=bash
cd ~/.local/src/ffmpeg_sources  && git clone --depth=1 https://github.com/videolan/vlc.git
cd vlc && ./bootstrap && \
./configure \
--enable-mmal --enable-omxil --enable-rpi-omxil  \
--enable-fdkaac --enable-gles2 && \
make -j4 && sudo make install && sudo ldconfig
```

# mplayer (./mplayer)

```shell=bash
wget http://www.mplayerhq.hu/MPlayer/releases/mplayer-export-snapshot.tar.bz2
tar xf mplayer-export-snapshot.tar.bz2
cd mplayer-/
./configure   --enable-faad
make -j4
sudo make install
```

# PULSEEFFECTS &lsp-plugins (different to ./pulseeffects-install.sh)

```shell=bash
apt install -y libfftw3-bin libfftw3-dev && \
git clone --depth=1 https://github.com/swh/ladspa.git && \
autoreconf -i && \
./configure && \
make -j4 && \
sudo make install

apt build-dep pulseeffects

git clone --depth=1 https://github.com/wwmm/pulseeffects.git
cd pulseeffects
git checkout v4.8.0
meson _build --prefix=/usr
sudo ninja -C _build install
```

# Equalizer (./install-equalizer.sh)

```shell=bash
sudo apt install python3-pip bc swh-plugins meson && sudo pip3 install ninja && \
cd ~/.local/src/ffmpeg_sources && git clone --depth=1 https://github.com/pulseaudio-equalizer-ladspa/equalizer.git &&\
cd equalizer && \
meson build && \
cd build && \
ninja && \
sudo ninja install
```

