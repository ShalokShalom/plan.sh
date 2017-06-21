pkg_origin=cosmos

pkg_name=slv2
pkg_version=0.6.6
pkg_description="Library for LV2 hosts"
pkg_upstream_url="http://drobilla.net/software/slv2"
pkg_license=('GPL')
pkg_deps=('redland' 'lv2core' 'jack')
pkg_build_deps=('python2')
install=$pkg_name.install
pkg_source=(http://download.drobilla.net/$pkg_name-$pkg_version.tar.bz2)
pkg_shasum=('b8e8e0e82dd04324fcd533e8acd1ce85')

do_build() {

  python2 waf configure --prefix=/usr
  python2 waf build $MAKEFLAGS
}

do_package() {

  python2 waf install --destdir="$CACHE_PATH/"
}
