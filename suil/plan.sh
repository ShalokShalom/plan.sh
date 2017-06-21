pkg_origin=cosmos

pkg_name=suil
pkg_version=0.8.4
pkg_description="A lightweight C library for loading and wrapping LV2 plugin UIs"
pkg_upstream_url="http://drobilla.net/software/suil/"
pkg_license=('custom:ISC')
pkg_deps=('lv2')
pkg_build_deps=('python2')
pkg_source=("http://download.drobilla.net/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('50598cc44f419f60805862272abe881c')

do_build() {
  sed -i "/ldconfig/d" wscript

  python2 waf configure --prefix=/usr
  python2 waf
}

do_package() {

  python2 waf install --destdir=${CACHE_PATH}

  install -Dm644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}

