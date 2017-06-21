pkg_origin=cosmos

pkg_name=mplayer
pkg_version=37905
pkg_description="Multimedia player."
pkg_deps=('a52dec' 'aalib' 'alsa-lib' 'bzip2' 'directfb' 'enca' 'faac' 'faad2'
         'fontconfig' 'freetype2' 'fribidi' 'gcc-libs' 'giflib' 'glibc' 'gsm' 'jack' 'ladspa' 'lame'
         'libass' 'libbluray' 'libcaca' 'libcdio-paranoia' 'libdca' 'libdv' 'libdvdnav' 'libgl' 
         'libjpeg-turbo' 'libmad' 'libmng' 'libmpeg2' 'libogg' 'libpng'
         'pulseaudio' 'libtheora' 'libvdpau' 'libvpx' 'libx11' 'libxext' 'libxinerama'
         'libxss' 'libxv' 'libxxf86dga' 'libxxf86vm' 'live-media' 'opus'
         'lzo2' 'mpg123' 'ncurses' 'openal' 'opencore-amr' 'orc' 'rtmpdump'  # not ready for 2.0 'openjpeg'
         'schroedinger' 'sdl' 'samba' 'speex' 'ttf-dejavu' 'x264' 'xvidcore' 'zlib' 'gnutls')
pkg_build_deps=('mesa' 'unzip' 'yasm')
pkg_license=('GPL2')
pkg_upstream_url="http://www.mplayerhq.hu/"
groups=('multimedia')
backup=('etc/mplayer/codecs.conf' 'etc/mplayer/input.conf')
pkg_source=("http://sourceforge.net/projects/kaosx/files/sources/${pkg_name}/${pkg_name}-${pkg_version}.tar.xz"
        'mplayer.desktop'
        'mplayer.png'
        'cdio-includes.patch')
pkg_shasum=('0002d43eba52c6d243d21be3b1a4f872'
         '62f44a58f072b2b1a3c3d3e4976d64b3'
         'd00874ccc644b7f43d6ef1c942fcef28'
         '7b5be7191aafbea64218dc4916343bbc')

# create tarball: source PKGBUILD && mksource

mksource() {
    rm -vRf ${pkg_name}
    echo "checkout mplayer"
    _pkg_version=`svn info svn://svn.mplayerhq.hu/mplayer/trunk | grep Revision: | cut -d' ' -f2`
    svn co svn://svn.mplayerhq.hu/mplayer/trunk --config-dir ./ ${pkg_name} || return 1
    echo "checkout ffmpeg"
    #git clone git://git.videolan.org/ffmpeg.git ffmpeg
    git clone https://github.com/FFmpeg/FFmpeg ffmpeg
    echo "clean checkout"
    rm -vRf ffmpeg/.git
    find . -name ".svn" -exec rm -rf {} \;
    pushd ${pkg_name}
    popd
    echo "pack checkout"
    tar -cvJf ${pkg_name}-${_pkg_version}.tar.xz ${pkg_name}/*
    md5sum ${pkg_name}-${_pkg_version}.tar.xz
    echo "change pkg_version to ${_pkg_version}"
}

do_build() {
    #patch -p0 -i ${CACHE_PATH}/cdio-includes.patch
    
    ./configure \
      --confdir=/etc/mplayer \
      --enable-runtime-cpudetection \
      --language=all \
      --enable-radio \
      --enable-radio-capture \
      --prefix=/usr

    make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 etc/{codecs.conf,input.conf,example.conf} ${pkg_prefix}/etc/mplayer/               
  
  install -dm755 ${pkg_prefix}/usr/share/mplayer/           
  ln -s /usr/share/fonts/TTF/DejaVuSans.ttf ${pkg_prefix}/usr/share/mplayer/subfont.ttf             
  rm -rf ${pkg_prefix}/usr/share/mplayer/font               
  
  # Desktop Integration.
  install -Dm644 ${CACHE_PATH}/mplayer.desktop ${pkg_prefix}/usr/share/applications/mplayer.desktop             
  install -Dm644 ${CACHE_PATH}/mplayer.png ${pkg_prefix}/usr/share/pixmaps/mplayer.png
}
