sudo apt build-dep mplayer  && cd ~/ffmpeg_sources/ && svn checkout svn://svn.mplayerhq.hu/mplayer/trunk mplayer && cd mplayer && \
./configure  --enable-faad --enable-gui   --disable-ffmpeg_a  --enable-ffmpeg_so  && make -j4 && sudo make install
