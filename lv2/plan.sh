pkg_origin=cosmos

pkg_name=lv2
pkg_version=1.14.0
pkg_description="Successor to the LADSPA audio plug-in standard"
pkg_upstream_url="http://lv2plug.in/"
pkg_license=('LGPL' 'custom')
pkg_build_deps=('python2' 'libsndfile')
pkg_source=("http://lv2plug.in/spec/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('0b56285a77aac3c93b50c36203aa91ee')

do_build() {

	python2 waf configure --prefix=/usr
	python2 waf build $MAKEFLAGS
}

do_package() {

	python2 waf install --destdir=${pkg_prefix}

	install -Dm644 COPYING  ${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING
}
