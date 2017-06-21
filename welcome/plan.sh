pkg_origin=

pkg_name=welcome
pkg_version=4.0
pkg_description="Live Welcome app for KaOS"
pkg_upstream_url="http://kaosx.us/"
pkg_license=('GPL')
pkg_deps=('qt5-base')
pkg_build_deps=('git')
pkg_source=("git://github.com/KaOSx/welcome.git")
pkg_shasum=('SKIP')

do_build() {
    cd welcome/
   
    /usr/lib/qt5/bin/qmake welcome.pro
    make
}

do_package() {
    cd welcome/
   
    make INSTALL_ROOT=${pkg_prefix}/ install
}
