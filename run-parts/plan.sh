pkg_origin=cosmos

pkg_name=run-parts
pkg_version=4.7
pkg_description='Run scripts or programs in a directory'
pkg_upstream_url='http://packages.qa.debian.org/d/debianutils.html'
pkg_license=('GPL')
pkg_deps=('glibc')
pkg_source=("http://ftp.de.debian.org/debian/pool/main/d/debianutils/debianutils_${pkg_version}.tar.xz") 
pkg_shasum=('00186f527b35e2cecd4db593c6d512d0')

do_build() {
	cd debianutils-${pkg_version}
	
	./configure --prefix=/usr
	make run-parts
}

do_package() {
	cd debianutils-${pkg_version}
	
	install -D -m755 run-parts ${pkg_prefix}/usr/bin/run-parts
	install -D -m644 run-parts.8 ${pkg_prefix}/usr/share/man/man8/run-parts.8
}
