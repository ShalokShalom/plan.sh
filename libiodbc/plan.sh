pkg_origin=cosmos

pkg_name=libiodbc
pkg_version=3.52.12
pkg_description='Independent Open DataBase Connectivity for Linux'
pkg_upstream_url='http://www.iodbc.org'
pkg_license=('LGPL')
pkg_deps=('glibc' 'sh')
pkg_build_deps=('chrpath')
pkg_source=("http://downloads.sourceforge.net/sourceforge/iodbc/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('c76cab12a642a024bd1a262615a1a4a8')

do_build() {
	
	./configure --prefix=/usr \
		--disable-static \
		--includedir=/usr/include/libiodbc \
		--disable-gui \
		--disable-libodbc
	make 
}

do_package() {
	make DESTDIR=${pkg_prefix} install
	
	chrpath -d ${pkg_prefix}/usr/bin/iodbctest{,w}
	rm -rf ${pkg_prefix}/usr/share/libiodbc/
}
