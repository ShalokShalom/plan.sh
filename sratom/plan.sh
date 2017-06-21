pkg_origin=cosmos

pkg_name=sratom
pkg_version=0.6.0
pkg_description="An LV2 Atom RDF serialisation library"
pkg_upstream_url="http://drobilla.net/software/sratom/"
pkg_license=('custom:ISC')
pkg_deps=('lv2' 'sord')
pkg_build_deps=('python2')
pkg_source=("http://download.drobilla.net/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('76f085e6d41bba57f4dc2a5ffeff9dde')

do_build() {
  sed -i '/ldconfig/d' wscript

  python2 waf configure --prefix=/usr
  python2 waf build $MAKEFLAGS
}

do_package() {

  python2 waf install --destdir=${CACHE_PATH}

  install -Dm644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
