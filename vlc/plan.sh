pkg_origin=cosmos

pkg_name=vlc
pkg_version=2.2.85
_pkg_version=3.0.0-20170522-0246-git
pkg_description="Free and open source cross-platform multimedia player and framework that plays most multimedia files and various streaming protocols."
pkg_upstream_url="https://www.videolan.org/vlc/"
pkg_license=('GPL')
pkg_deps=('a52dec' 'fluidsynth' 'libmtp' 'libdvbpsi' 'libxpm' 'libcdio' 'libdca' 'libproxy'
         'sdl_image' 'libdvdnav' 'mesa' 'v4l-utils' 'libcddb' 'samba' 'libmatroska' 'zvbi'
         'taglib' 'sysfsutils' 'libmpcdec' 'ffmpeg' 'faad2' 'libupnp' 'libshout' 'libmad' 'fribidi'
         'libmpeg2' 'libmodplug' 'opus' 'ttf-freefont' 'libxv' 'libass' 'xdg-utils'
         'desktop-file-utils' 'xcb-util-keysyms' 'pulseaudio' 'chromaprint' 
         'qt5-x11extras' 'x265' 'lua' 'mpg123' 'protobuf')
pkg_build_deps=('avahi' 'pkgconfig' 'libnotify' 'libbluray' 'flac' 'libtheora' 'alsa-lib'
             'jack' 'systemd' 'libraw1394' 'libdc1394' 'libavc1394' 'libva' 
             'gnutls' 'libcaca' 'librsvg' 'live-media' 'qt5-tools')
optpkg_deps=('avahi: for service discovery using bonjour protocol'
            'libnotify: for notification plugin'
            'ncurses: for ncurses interface support'
            'libdvdcss: for decoding encrypted DVDs'
            'libavc1394: for devices using the 1394ta AV/C'
            'libdc1394: for IEEE 1394 plugin'
            'libbluray: for Blu-Ray disks')
backup=('usr/share/vlc/http/.hosts'
        'usr/share/vlc/http/dialogs/.hosts'
        'usr/share/vlc/lua/http/.hosts'
        'usr/share/vlc/lua/http/dialogs/.hosts')
groups=('multimedia')
install="vlc.install"
#pkg_source=("http://download.videolan.org/pub/videolan/vlc/${_pkg_version/a}/${pkg_name}-${_pkg_version}.tar.xz")
pkg_source=("https://nightlies.videolan.org/build/source/${pkg_name}-${_pkg_version}.tar.xz")
pkg_shasum=('78f14a01539fcac602d852d755ec8e87')

do_prepare() {
  
  #patch -p1 -i "${CACHE_PATH}/ffmpeg24.patch"
  #sed -i -e 's|5.5.0|5.5.4|' configure.ac
  #autoreconf -fi
}

do_build() {
  
  #CXXFLAGS="-std=c++11"

  sed -i -e 's:truetype/freefont:TTF:g' modules/text_renderer/freetype/freetype.c
  ./bootstrap

  ./configure --prefix=/usr \
              --sysconfdir=/etc \
              --disable-rpath \
              --enable-faad \
              --enable-nls \
              --enable-upnp \
              --enable-realrtsp \
              --enable-bluray \
              --enable-opus \
              --enable-ncurses \
              --enable-lua \
              --enable-mpg123 \
              RCC=/usr/bin/rcc-qt5
  make
}

do_package() {

  make DESTDIR=${CACHE_PATH} install

  for res in 16 32 48 128; do
    install -D -m644 ${CACHE_PATH}/vlc-3.0.0-git/share/icons/${res}x${res}/vlc.png \
        ${CACHE_PATH}/usr/share/icons/hicolor/${res}x${res}/apps/vlc.png
  done
}

