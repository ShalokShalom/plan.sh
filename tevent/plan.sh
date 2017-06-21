pkg_origin=cosmos

pkg_name=tevent
pkg_version=0.9.31
pkg_description="An event system based on the talloc memory management library"
pkg_upstream_url="https://tevent.samba.org/"
pkg_license=('GPL3')
pkg_deps=('talloc' 'python2')
pkg_source=("http://samba.org/ftp/tevent/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('5453847664ae6bc4ec0153e59ac635b9')

do_build() {

	./configure --prefix=/usr
}

do_package() {
	
	make
	make DESTDIR=${CACHE_PATH}/ install
	
	install -D -m644 tevent_internal.h ${CACHE_PATH}/usr/include/tevent_internal.h
}

