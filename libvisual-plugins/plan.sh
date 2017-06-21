pkg_origin=cosmos
# $Id: PKGBUILD 63448 2010-01-17 14:53:27Z jgc $
# Maintainer: damir <damir@archlinux.org>

pkg_name=libvisual-plugins
pkg_version=0.4.0
pkg_description="plugins for libvisual"
pkg_license=('GPL')
pkg_upstream_url="http://www.localhost.nl/~synap/libvisual/"
pkg_deps=('libvisual>=0.4.0' 'gtk2>=2.18.6' 'mesa>=7.7' 'alsa-lib' 'esound' 'jack-audio-connection-kit')
pkg_build_deps=(pkgconfig)
pkg_source=("http://downloads.sourceforge.net/sourceforge/libvisual/libvisual-plugins-${pkg_version}.tar.gz")
pkg_shasum=('4330e9287f9d6fae02f482f428a1e77b')

do_build() {
  ./configure --prefix=/usr  --enable-alsa --disable-gstreamer-plugin || return 1
  make || return 1
  make DESTDIR="${pkg_prefix}" install || return 1
}
