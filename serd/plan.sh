pkg_origin=cosmos

pkg_name=serd
pkg_version=0.26.0
pkg_description="A lightweight C library for RDF syntax which supports reading and writing Turtle and NTriples."
pkg_upstream_url="http://drobilla.net/software/serd/"
pkg_license=('custom:ISC')
pkg_deps=('glibc')
pkg_build_deps=('python2')
pkg_source=("http://download.drobilla.net/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('bf5a7627bbacb7aa75e38b0777b4517e')

do_build() {
  sed -i "/ldconfig/d" wscript

  python2 ./waf configure --prefix=/usr \
                          --mandir=/usr/share/man
  python2 ./waf
}

do_package() {
  DESTDIR=${CACHE_PATH} python2 ./waf install

  install -Dm644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}

