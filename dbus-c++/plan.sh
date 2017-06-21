pkg_origin=cosmos

pkg_name=dbus-c++
pkg_version=0.9.0
pkg_description="dbus-c++ attempts to provide a C++ API for D-BUS"
pkg_upstream_url="http://sourceforge.net/projects/dbus-cplusplus/"
pkg_license=('GPL')
pkg_deps=('dbus' 'glib2')
pkg_build_deps=('autoconf' 'automake')
pkg_source=("http://sourceforge.net/projects/dbus-cplusplus/files/dbus-c%2B%2B/0.9.0/libdbus-c%2B%2B-0.9.0.tar.gz"
        "patch-gcc47.patch")
pkg_shasum=('e752116f523fa88ef041e63d3dee4de2'
        '9319b402b15f37d881b51bc758368900')

do_build() {
    patch -p0 -i ${CACHE_PATH}/patch-gcc47.patch
    
    export LDFLAGS="${LDFLAGS} -lexpat -lpthread"
    ./autogen.sh --prefix=/usr \
          --disable-static \
          --enable-glib \
          --disable-ecore
    make
}

do_package() {
    
    make DESTDIR=${pkg_prefix} install
}
