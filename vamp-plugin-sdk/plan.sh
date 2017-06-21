pkg_origin=cosmos

pkg_name=vamp-plugin-sdk
pkg_version=2.5
pkg_description="The Vamp audio analysis plugin system"
pkg_upstream_url="http://www.vamp-plugins.org/"
pkg_license=('BSD')
pkg_deps=('gcc-libs' 'libsndfile')
pkg_source=("http://code.soundsoftware.ac.uk/attachments/download/690/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('199872997f74951f6769b982bf0d0646')

do_build() {

  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install

  install -Dm644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/COPYING
}

