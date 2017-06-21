pkg_origin=cosmos

pkg_name=libindi
_pkg_name=indi
pkg_version=1.4.1
_pkg_version=1.4.1
pkg_description="Interface control protocol providing backend driver support and
        automation for a wide range of Astronomical devices (telescopes, focusers, CCDs..etc)."
pkg_upstream_url="http://indi.sourceforge.net/"
pkg_license=('GPL2')
pkg_deps=('gcc-libs' 'zlib' 'libnova' 'cfitsio' 'libusb' 'boost-libs' 'libjpeg-turbo' 'gsl' 'qt5-base')
pkg_build_deps=('boost' 'cmake')
pkg_source=("https://sourceforge.net/projects/indi/files/${pkg_name}_${pkg_version}.tar.gz")
pkg_shasum=('9f7556239dda08b7175ec44bd5a61b71')

do_build() {
    mkdir -p build

    cmake ../${pkg_name} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DUDEVRULES_INSTALL_DIR=/usr/lib/udev/rules.d \
    -DCMAKE_INSTALL_LIBDIR=lib
    make
}

do_package() {
    
    make DESTDIR=${pkg_prefix} install
}
