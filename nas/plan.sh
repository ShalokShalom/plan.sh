pkg_origin=cosmos

pkg_name=nas
pkg_version=1.9.3
pkg_description='Network Audio System is a network transparent, client/server audio transport system'
pkg_upstream_url='http://radscan.com/nas.html'
pkg_license=('custom')
pkg_deps=('libxaw')
pkg_build_deps=('imake')
pkg_source=("http://downloads.sourceforge.net/sourceforge/${pkg_name}/${pkg_name}-${pkg_version}.src.tar.gz"
        'license.txt')
pkg_shasum=('ecd01a3b4e17a9d464efa83a03618025'
         'f11eb8c3fb83946e66e60f7532e8d5da')

do_build() {

  xmkmf
  make World
}

do_package() {
  make DESTDIR="${pkg_prefix}" USRLIBDIR=/usr/lib install

  install -D -m644 "${CACHE_PATH}/license.txt" "${pkg_prefix}/usr/share/licenses/${pkg_name}/license"
}
