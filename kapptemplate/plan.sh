pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kapptemplate
pkg_version=${_kdever}
pkg_description='KDE Template Generator'
pkg_upstream_url='http://kde.org/applications/development/kapptemplate/'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kcoreaddons' 'kconfigwidgets' 'kcompletion' 'karchive' 'kio' 'ki18n')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz"
        'template.diff')
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`
         '096a81c21b4b9774690dffac211e1fab')

do_prepare() {
  cd $pkg_name-${pkg_version}
  
  #patch -p1 -i ${CACHE_PATH}/template.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
