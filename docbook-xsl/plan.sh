pkg_origin=cosmos

pkg_name=docbook-xsl
pkg_version=1.79.1
pkg_description="XML stylesheets for Docbook-xml transformations."
pkg_license=('custom')
pkg_upstream_url="http://scrollkeeper.sourceforge.net/docbook.shtml"
pkg_deps=('libxml2' 'libxslt' 'docbook-xml')
pkg_source=("http://downloads.sourceforge.net/sourceforge/docbook/docbook-xsl-${pkg_version}.tar.bz2")
install=docbook-xsl.install
pkg_shasum=('b48cbf929a2ad85e6672f710777ca7bc')

do_package() {
	cd ${CACHE_PATH}/${pkg_name}-${pkg_version}

	_pkgroot=${pkg_prefix}/usr/share/xml/docbook/xsl-stylesheets-${pkg_version}

        install -dm755 ${_pkgroot}
	install -m644 VERSION VERSION.xsl ${_pkgroot}

	for fn in assembly common eclipse epub epub3 fo highlighting html htmlhelp javahelp lib \
                  manpages params profiling roundtrip template website xhtml xhtml-1_1 xhtml5; do
		install -dm755 ${_pkgroot}/${fn}
		install -m644 ${fn}/*.{xml,xsl,dtd,ent} ${_pkgroot}/${fn} || true  # ignore missing files
	done

	install -dm755 ${pkg_prefix}/etc/xml
	install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
