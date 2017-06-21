pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kompare
pkg_version=${_kdever}
pkg_description='A KDE visual diff viewer'
pkg_upstream_url='http://kde.org/applications/development/kompare/'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kcoreaddons' 'kcodecs' 'kiconthemes' 'kjobwidgets' 'kconfig' 'kparts' 'ktexteditor'
         'kwidgetsaddons' 'libkomparediff2')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
         'kdesdk-kcachegrind' 
         'kdesdk-kioslaves'
         'kdesdk-kompare'
         'kdesdk-poxml'
         'kdesdk-dev-scripts'
         'kdesdk-strigi-analyzers')
         'kdesdk-kcachegrind' 
         'kdesdk-kioslaves'
         'kdesdk-kompare'
         'kdesdk-poxml'
         'kdesdk-dev-scripts'
         'kdesdk-strigi-analyzers')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd $pkg_name-${pkg_version}

  #patch -p1 -i $CACHE_PATH/save.diff
}
         
do_build() {
  cd ${CACHE_PATH}
  
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
