pkg_origin=cosmos

pkg_name=sg3_utils
pkg_version=1.42
pkg_description="Generic SCSI utilities"
pkg_upstream_url="http://sg.danny.cz/sg/sg3_utils.html"
pkg_license=('GPL' 'custom:BSD')
pkg_deps=('glibc')
pkg_source=("http://sg.danny.cz/sg/p/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('913ac2c9069d2ba44e05565a445810ab')

do_build() {

  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  install -m755 -d ${CACHE_PATH}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/
}
