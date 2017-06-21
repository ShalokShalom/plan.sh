pkg_origin=cosmos

pkg_name=schroedinger
pkg_version=1.0.11
pkg_description="An implemenation of the Dirac video codec in ANSI C code"
pkg_upstream_url="https://github.com/Distrotech/dirac"
pkg_license=('GPL2' 'LGPL2' 'MPL' 'MIT')
pkg_deps=('orc')
pkg_build_deps=('pkgconfig')
pkg_source=("https://github.com/Distrotech/dirac/archive/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('c30534f8b21b3f20b305e1a3e3e0ace3')

do_prepare() {

  sed -i -e 's|--enable-gtk-doc|--disable-gtk-doc|' autogen.sh
}

do_build() {
  
  ./autogen.sh
  ./configure --prefix=/usr 
  make
}

do_package() {

  make DESTDIR=${CACHE_PATH} install
  install -m644 -D COPYING.MIT ${CACHE_PATH}/usr/share/licenses/${pkg_name}/COPYING.MIT
}
