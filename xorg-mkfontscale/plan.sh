pkg_origin=cosmos

pkg_name=xorg-mkfontscale
pkg_version=1.1.2
pkg_description="Create an index of scalable font files for X"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('freetype2' 'libfontenc')
pkg_build_deps=('xorg-util-macros' 'xproto')
groups=('xorg-apps' 'xorg')
pkg_source=("http://xorg.freedesktop.org/archive/individual/app/mkfontscale-${pkg_version}.tar.bz2")
pkg_shasum=('9bdd6ebfa62b1bbd474906ac86a40fd8')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR="${CACHE_PATH}" install
  
  install -m755 -d "${CACHE_PATH}/usr/share/licenses/${pkg_name}"
  install -m644 COPYING "${CACHE_PATH}/usr/share/licenses/${pkg_name}/"
}
