pkg_origin=

pkg_name=gnugo
pkg_version=3.8
pkg_description='Program that plays the game of Go'
pkg_upstream_url='http://www.gnu.org/software/gnugo/'
pkg_license=('GPL3' 'custom')
pkg_deps=('ncurses')
pkg_source=("https://ftp.gnu.org/gnu/gnugo/${pkg_name}-${pkg_version}.tar.gz"
        'LICENSE')
pkg_shasum=('6db0a528df58876d2b0ef1659c374a9a'
         '4df5819356804397c553c95ea8164f11')

do_build() {
	cd ${pkg_name}-${pkg_version}
	
	./configure --prefix=/usr
	make
}

do_package() {
	cd ${pkg_name}-${pkg_version}
	make DESTDIR=${pkg_prefix} install
	
	rm -r ${pkg_prefix}/usr/share/info
	install -Dm644 ../LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
