pkg_origin=

pkg_name=kcm-fcitx
pkg_version=0.5.4
pkg_description="KDE Config Module for Fcitx"
pkg_upstream_url="https://github.com/fcitx/kcm-fcitx"
pkg_license=('GPL')
pkg_deps=('fcitx-qt5' 'kcoreaddons' 'kwidgetsaddons' 'kcmutils' 'kitemviews' 'ki18n' 'kio' 'knewstuff')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("http://download.fcitx-im.org/kcm-fcitx/$pkg_name-${pkg_version}.tar.xz")
pkg_shasum=('1af0b33880db48f7bc0f20f93a178419')

do_build() {
    cd ${pkg_name}-${pkg_version}
    mkdir -p build
    cd build
    
    cmake -DCMAKE_INSTALL_PREFIX=/usr \
          -DCMAKE_BUILD_TYPE=Release \
          -DCMAKE_INSTALL_LIBDIR=lib \
          -DKDE_INSTALL_USE_QT_SYS_PATHS=ON ..
    make
}

package () {
    cd ${pkg_name}-${pkg_version}/build
    
    make DESTDIR=${pkg_prefix} install
}
