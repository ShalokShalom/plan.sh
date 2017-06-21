pkg_origin=

pkg_name=knemo
pkg_version=0.7.6.82
_commit=45261c8dd77c93ca97f0335f223a8cb87f8334b0
pkg_description='The KDE Network Monitor'
pkg_upstream_url='http://kde-apps.org/content/show.php?content=12956'
pkg_license=('GPL')
pkg_deps=('kconfig' 'kconfigwidgets' 'kcoreaddons' 'kglobalaccel' 'kguiaddons' 'kdbusaddons' 'ki18n' 
         'kcmutils' 'kio' 'knotifications' 'knotifyconfig' 'kwidgetsaddons' 'kwindowsystem' 'kxmlgui'  
         'kdelibs4support' 'ksysguard' 'wireless_tools' 'libnl')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("https://github.com/KDE/knemo/archive/${_commit}.zip")
pkg_shasum=('80a24e44d549118b06fa4e4aa111453e')

do_prepare() {
  cd ${pkg_name}-${_commit}
  #patch -p1 -i ${CACHE_PATH}/cmake.diff
}

do_build() {
  mkdir -p build 
  cd build
  
  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
