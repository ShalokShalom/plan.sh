pkg_origin=cosmos

pkg_name=intltool
pkg_version=0.51.0
pkg_description="The internationalization tool collection"
pkg_upstream_url="https://edge.launchpad.net/intltool"
pkg_license=('GPL')
pkg_deps=('perl-xml-parser')
pkg_source=("http://edge.launchpad.net/intltool/trunk/${pkg_version}/+download/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('12e517cac2b57a0121cda351570f1e63')

do_build() {
	cd ${CACHE_PATH}/${pkg_name}-${pkg_version}

	./configure --prefix=/usr 
	make 
}

do_package() {
	cd ${CACHE_PATH}/${pkg_name}-${pkg_version}
	
	make DESTDIR=${pkg_prefix} install 
        install -Dm644 doc/I18N-HOWTO ${pkg_prefix}/usr/share/doc/${pkg_name}/I18N-HOWTO 
}
