pkg_origin=cosmos

pkg_name=gd
pkg_version=2.2.4
_pkg_version=2.2.4
pkg_description="Library for the dynamic creation of images by programmers"
pkg_upstream_url="https://www.libgd.org/"
pkg_license=('custom')
pkg_deps=('libpng' 'fontconfig' 'libjpeg-turbo' 'libtiff')
#pkg_build_deps=('cmake')
pkg_source=("https://github.com/libgd/libgd/archive/gd-${_pkg_version}.tar.gz")
pkg_shasum=('38fc1fc8ca12023bae0c2c7ecfbd2c62')

do_build() {

  ./bootstrap.sh
  ./configure --prefix=/usr --without-xpm
  make
}

check() {

  make check
 }

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
