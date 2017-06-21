pkg_origin=cosmos

pkg_name=libdaemon
pkg_version=0.14
pkg_description="A lightweight C library which eases the writing of UNIX daemons"
pkg_upstream_url="http://0pointer.de/lennart/projects/libdaemon/"
pkg_license=('LGPL')
pkg_deps=('glibc')
pkg_source=("http://0pointer.de/lennart/projects/libdaemon/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('509dc27107c21bcd9fbf2f95f5669563')

do_build() {

    ./configure --prefix=/usr --localstatedir=/var --disable-lynx --disable-static
    make
}

do_package() {

    make DESTDIR=${pkg_prefix} install
}


