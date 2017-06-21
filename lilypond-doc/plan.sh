pkg_origin=

pkg_name=lilypond-doc
pkg_version=2.19.62
_pkg_version=2.19.62-1
pkg_description='Documentation of Lilypond'
pkg_upstream_url='http://lilypond.org/'
pkg_license=('GPL')
pkg_deps=('lilypond')
pkg_source=("http://lilypond.org/downloads/binaries/documentation/lilypond-${_pkg_version}.documentation.tar.bz2")
pkg_shasum=('1036a03d2edc6cc4c29d7608eca57124')

do_package() {
	cd ${CACHE_PATH}
	mkdir -p ${pkg_prefix}/usr/
	mv share/ ${pkg_prefix}/usr/
	install -Dm644 license/${pkg_name} ${pkg_prefix}/usr/share/licences/${pkg_name}/LICENSE
}
