pkg_origin=cosmos

pkg_name=orc
pkg_version=0.4.26
pkg_description="The Optimized Inner Loops Runtime Compiler"
pkg_license=('custom')
pkg_upstream_url="http://cgit.freedesktop.org/gstreamer/orc/"
pkg_deps=('glibc')
pkg_build_deps=('valgrind')
pkg_source=("http://gstreamer.freedesktop.org/src/orc/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('8e9bef677bae289d3324d81c337a4507')

build () {
    
    ./configure --prefix=/usr --disable-static
    make
}

check() {
    
    make check
}
    
do_package() {
    make DESTDIR=${pkg_prefix} install
    
    install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
