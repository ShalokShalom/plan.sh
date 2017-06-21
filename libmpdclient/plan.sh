pkg_origin=cosmos

pkg_name=libmpdclient
pkg_version=2.10
pkg_description='Asynchronous API library for interfacing MPD in the C, C++ & Objective C languages'
pkg_upstream_url='http://www.musicpd.org/libs/libmpdclient/'
pkg_license=('custom:BSD')
pkg_source=("http://www.musicpd.org/download/${pkg_name}/${pkg_version%.*}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('00606c630b905aa6196330373b366c29')

do_build() {
	
	./configure --prefix=/usr --disable-documentation
	make
}

do_package() {
	make DESTDIR=${pkg_prefix} install

	install -D -m 644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
