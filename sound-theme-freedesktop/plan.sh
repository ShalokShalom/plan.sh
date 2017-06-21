pkg_origin=cosmos

pkg_name=sound-theme-freedesktop
pkg_version=0.8
pkg_description="Freedesktop sound theme"
pkg_upstream_url="https://freedesktop.org/wiki/Specifications/sound-theme-spec"
pkg_license=('custom')
pkg_build_deps=('intltool')
pkg_source=("http://people.freedesktop.org/~mccann/dist/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('d7387912cfd275282d1ec94483cb2f62')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  install -Dm644 CREDITS ${CACHE_PATH}/usr/share/licenses/${pkg_name}/CREDITS
}
