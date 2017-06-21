pkg_origin=cosmos

pkg_name=timidity++
_pkg_name=TiMidity++
pkg_version=2.14.0
pkg_description="Open source MIDI to WAVE converter and player."
pkg_upstream_url="http://timidity.sourceforge.net"
pkg_license=('GPL')
pkg_deps=('libao' 'libvorbis' 'jack' 'ncurses')
pkg_build_deps=('tk' 'libxaw')
optpkg_deps=('xaw3d: for using the Xaw interface')
backup=('etc/timidity++/timidity.cfg')
pkg_source=("https://downloads.sourceforge.net/timidity/${_pkg_name}-${pkg_version}.tar.bz2" \
        'timidity.cfg'
        'timidity.service')
pkg_shasum=('37a8e9720928869e8adbfa6ce1c313aa'
         '3fcc8f065c959205113fa7e9ab2be3c6'
         '6e3e6080a74aa6774abfa661c6f67daa')

do_build() {
  
  ./configure --prefix=/usr \
    --mandir=/usr/share/man \
    --with-default-path=/etc/timidity++/ \
    --enable-server \
    --enable-alsaseq \
    --enable-spectrogram \
    --enable-network \
    --enable-xft \
    --enable-audio=alsa,oss,ao,vorbis,flac,esd,jack \
    --enable-dynamic=ncurses,tcltk,vt100,xaw \
    --disable-gtktest \
    --disable-gtk
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  install -D -m644 ../timidity.cfg ${CACHE_PATH}/etc/timidity++/timidity.cfg
  install -D -m644 ../timidity.service ${CACHE_PATH}/usr/lib/systemd/system/timidity.service
}
