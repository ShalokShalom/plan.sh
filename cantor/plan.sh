pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=cantor
pkg_version=${_kdever}
pkg_description="KDE Frontend to Mathematical Software"
pkg_upstream_url="http://kde.org/applications/education/cantor/"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kconfig' 'knewstuff' 'ktexteditor' 'kcoreaddons' 'karchive' 'kparts' 'kpty' 'kalgebra'
         'kdelibs4support' 'libspectre' 'octave' 'python2' 'python3' 'libqalculate')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'icu')
oppkg_deps=('scilab' 'maxima') 
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz"
        'pythonhighlighter.diff')
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`
         '8da6949371a3181e42d510e9b59a2876')

do_prepare() {
  cd $pkg_name-${pkg_version}
  
  sed -i -e 's|add_subdirectory(sage)|#add_subdirectory(sage)|' src/backends/CMakeLists.txt
  # needed changes for e-c-m 5.31.0
  #patch -p1 -i $CACHE_PATH/pythonhighlighter.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
