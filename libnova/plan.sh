pkg_origin=cosmos

pkg_name=libnova
pkg_version=0.15.0
pkg_description="General purpose, double precision, celestial mechanics, astrometry and astrodynamics library."
pkg_upstream_url="http://libnova.sourceforge.net/"
pkg_license=('GPL2')
pkg_deps=('glibc')
pkg_build_deps=('pkgconfig')
pkg_source=("https://downloads.sourceforge.net/sourceforge/libnova/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('756fdb55745cb78511f83a62c25f3be4')

do_build() {
    
    autoreconf -i
    ./configure --prefix=/usr
    make
}

do_package() {
    
    make DESTDIR=${pkg_prefix}/ install
}

