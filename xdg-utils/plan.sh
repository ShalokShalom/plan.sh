pkg_origin=cosmos

pkg_name=xdg-utils
pkg_version=1.1.2
_pkg_version=1.1.2
_gitver=f0df41402e827051ec16bac212c8eaf08ada75e4
pkg_description='Command line tools that assist applications with a variety of desktop integration tasks.'
pkg_upstream_url='http://www.freedesktop.org/wiki/Software/xdg-utils/'
pkg_deps=('sh')
pkg_build_deps=('docbook-xsl' 'w3m' 'xmlto')
pkg_license=('MIT')
#pkg_source=("http://cgit.freedesktop.org/xdg/xdg-utils/snapshot/xdg-utils-${_gitver}.tar.gz")
pkg_source=("https://portland.freedesktop.org/download/xdg-utils-${_pkg_version}.tar.gz"
        'xdg-mime.patch')
pkg_shasum=('361e75eb76c94d19f6f4f330d8ee626b'
         '7bc92bf7a65e50a50c0d3aa10bea95fd')

do_build() {
	#patch -p1 -i ${CACHE_PATH}/xdg-mime.patch
	
	./configure --prefix=/usr --mandir=/usr/share/man
	make 
}

do_package() {
	
	make DESTDIR=${CACHE_PATH} install
	install -D -m644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}

