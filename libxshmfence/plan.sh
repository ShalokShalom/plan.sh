pkg_origin=cosmos

pkg_name=libxshmfence
pkg_version=1.2
pkg_description="Tiny library that exposes a event API on top of Linux futexes"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('GPL')
pkg_deps=('glibc')
pkg_build_deps=('xorg-util-macros' 'xproto')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('66662e76899112c0f99e22f2fc775a7e')

do_build() {
	
	./configure --prefix=/usr
	make
}

check() {
	
	make -k check
}

do_package() {
	make DESTDIR="$pkg_prefix/" install
	
	install -m755 -d "${pkg_prefix}/usr/share/licenses/${pkg_name}"
	install -m644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/"
}
