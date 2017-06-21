pkg_origin=
 
pkg_name=libdmtx
pkg_version=0.7.4
pkg_description="Open source software for reading and writing Data Matrix barcodes"
pkg_upstream_url="http://libdmtx.sourceforge.net/"
pkg_license=('GPL-2')
pkg_deps=('glibc')
pkg_source=("https://downloads.sourceforge.net/project/libdmtx/libdmtx/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('9d9d87f489f0d5b3727d00b784e04c33')

do_build() {
	cd ${pkg_name}-${pkg_version}
	
	./configure --prefix=/usr
	make
}

do_package() {
	cd ${pkg_name}-${pkg_version}
	
	make DESTDIR=${pkg_prefix}/ install 
}
