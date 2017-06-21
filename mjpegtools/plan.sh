pkg_origin=cosmos

pkg_name=mjpegtools
pkg_version=2.1.0
pkg_description="Set of tools that can do recording of videos and playback, simple cut-and-paste editing and the MPEG compression of audio and video"
pkg_license=('GPL')
pkg_upstream_url="http://mjpeg.sourceforge.net/"
pkg_deps=('libjpeg-turbo' 'libpng>=1.6.17' 'sdl' 'gcc-libs' 'libdv')
makedeends=('v4l-utils')
pkg_source=("http://downloads.sourceforge.net/sourceforge/mjpeg/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('57bf5dd78976ca9bac972a6511b236f3')

do_build() {
  sed -i -e '/ARCHFLAGS=/s:=.*:=:' configure
    
  ./configure --prefix=/usr --enable-largefile
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
  install -m0644 mpeg2enc/mpeg2syntaxcodes.h ${pkg_prefix}/usr/include/mjpegtools/mpeg2enc/
}
