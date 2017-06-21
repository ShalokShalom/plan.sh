pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=libksane
pkg_version=${_kdever}
#pkg_version=15.07.72
pkg_description="An image scanning library"
pkg_upstream_url='http://www.kde.org'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kconfig' 'ki18n' 'kwallet' 'kwidgetsaddons' 'ktextwidgets' 'sane')
pkg_build_deps=('extra-cmake-modules' 'git')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/libksane")
#pkg_shasum=('SKIP')


do_build() {
    cd ${CACHE_PATH}/${pkg_name}-${pkg_version}
	
    cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DSYSCONF_INSTALL_DIR=/etc \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
    make
}

do_package() {
    cd ${CACHE_PATH}/${pkg_name}-${pkg_version}
	
    make DESTDIR=${pkg_prefix} install

}
