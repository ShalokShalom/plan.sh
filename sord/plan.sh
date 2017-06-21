pkg_origin=cosmos

pkg_name=sord
pkg_version=0.16.0
pkg_description="A lightweight C library for storing RDF data in memory"
pkg_upstream_url="http://drobilla.net/software/sord/"
pkg_license=('custom:ISC')
pkg_deps=('serd' 'pcre')
pkg_build_deps=('python2')
pkg_source=("http://download.drobilla.net/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('010313c3baf5b8a4a639e9ee45310af6')

do_build() {
  sed -i "/ldconfig/d" wscript

  python2 waf configure --prefix=/usr
  python2 waf build $MAKEFLAGS
}

do_package() {

  python2 waf install --destdir=${CACHE_PATH}

  install -Dm644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}

