pkg_origin=cosmos

pkg_name=xorg-mkfontdir
pkg_version=1.0.7
pkg_description="Create an index of X font files in a directory"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('sh' 'xorg-mkfontscale')
pkg_build_deps=('xorg-util-macros')
groups=('xorg' 'xorg-apps')
pkg_source=("http://xorg.freedesktop.org/archive/individual/app/mkfontdir-${pkg_version}.tar.bz2")
pkg_shasum=('18c429148c96c2079edda922a2b67632')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR="${CACHE_PATH}" install
  
  install -m755 -d "${CACHE_PATH}/usr/share/licenses/${pkg_name}"
  install -m644 COPYING "${CACHE_PATH}/usr/share/licenses/${pkg_name}/"
}
