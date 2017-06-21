pkg_origin=

pkg_name=kaffeine
pkg_version=2.0.9
_pkg_version=2.0.9-1
pkg_description='KDE media player'
pkg_license=('GPL')
pkg_upstream_url="http://kaffeine.kde.org"
pkg_deps=('kcoreaddons' 'kdbusaddons' 'ki18n' 'solid' 'kio' 'knotifications'
         'kwidgetsaddons' 'kxmlgui' 'kidletime' 'qt5-x11extras' 'vlc')
pkg_build_deps=('extra-cmake-modules' 'kdoctools') 
pkg_source=("http://download.kde.org/stable/kaffeine/${pkg_version}/src/${pkg_name}-${_pkg_version}.tar.xz"
        "https://github.com/KDE/kaffeine/commit/2dbc752d644440f963bad172cf3ec83dc681ec7f.diff")
pkg_shasum=('8a5114cf18fcaf3bd2656dcadfd23995'
         '2cd0bb8f539ba0835d3db5b125de45d4')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  #patch -p1 -i ${CACHE_PATH}/2dbc752d644440f963bad172cf3ec83dc681ec7f.diff
  #sed -i 's|${X11_Xscreensaver_INCLUDE_PATH}||' CMakeLists.txt
}

do_build() {
  mkdir build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build
  
  make DESTDIR=$pkg_prefix install
}
