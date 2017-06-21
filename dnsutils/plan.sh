pkg_origin=cosmos

pkg_name=dnsutils
# _pkver when P version used.
pkg_version=9.11.1.1
_pkg_version=9.11.1-P1
pkg_description="DNS utilities, tools, name resolver and domain name authority server"
pkg_upstream_url="https://www.isc.org/software/bind"
pkg_license=('custom:ISC')
pkg_deps=('openssl')
pkg_source=("https://ftp.isc.org/isc/bind9/${_pkg_version}/bind-${_pkg_version}.tar.gz")
pkg_shasum=('73a6b63a02bd3f918848fafcd6423261')

do_build() {
	cd bind-${_pkg_version}

	export STD_CDEFINES='-DDIG_SIGCHASE'

	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--disable-static \
		--disable-linux-caps \
		--with-openssl  

	make
}

do_package() {
	cd bind-${_pkg_version}
	
	install -Dm644 COPYRIGHT ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
	cd bin; make DESTDIR=${pkg_prefix} install
}
