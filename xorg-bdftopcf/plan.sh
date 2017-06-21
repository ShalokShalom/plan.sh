pkg_origin=cosmos

pkg_name=xorg-bdftopcf
pkg_version=1.0.5
pkg_description="Convert X font from Bitmap Distribution Format to Portable Compiled Format"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('libxfont')
pkg_build_deps=('xorg-util-macros' 'xproto')
groups=('xorg' 'xorg-apps')
pkg_source=("http://xorg.freedesktop.org/archive/individual/app/bdftopcf-${pkg_version}.tar.bz2")
pkg_shasum=('53a48e1fdfec29ab2e89f86d4b7ca902')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install

  install -Dm644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/COPYING
}
