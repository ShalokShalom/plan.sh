pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=poxml
pkg_version=${_kdever}
pkg_description='Tools for using .po-files to translate DocBook XML files'
pkg_upstream_url='https://projects.kde.org/projects/kde/kdesdk/poxml'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kdoctools')
pkg_build_deps=('extra-cmake-modules' 'pkg-config')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
    cd ${CACHE_PATH}/${pkg_name}-${pkg_version}
    #sed -i -e 's|XML V4.2-Based Variant V1.1//EN" "dtd/kdex.dtd"|XML V4.5-Based Variant V1.1//EN" "dtd/kdedbx45.dtd"|' ${CACHE_PATH}/${pkg_name}/tests/lauri.xml
	
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
