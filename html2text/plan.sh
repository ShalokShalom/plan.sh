pkg_origin=cosmos
# $Id: PKGBUILD 5125 2009-11-06 16:14:08Z ibiru $
# Maintainer: Giovanni Scafora <giovanni@archlinux.org>

pkg_name=html2text
pkg_version=1.3.2a
pkg_description="A HTML to text converter"
pkg_upstream_url="http://www.mbayer.de/html2text"
pkg_license=('GPL2')
pkg_deps=('gcc-libs')
pkg_source=(http://ftp.ibiblio.org/pub/linux/apps/www/converters/$pkg_name-$pkg_version.tar.gz)
pkg_shasum=('6097fe07b948e142315749e6620c9cfc')

do_build() {
  ./configure
  make || return 1
  install -D -m 755 html2text $pkg_prefix/usr/bin/html2text
  install -D -m 644 html2text.1.gz $pkg_prefix/usr/share/man/man1/html2text.1.gz
  install -D -m 644 html2textrc.5.gz $pkg_prefix/usr/share/man/man5/html2textrc.5.gz
}

