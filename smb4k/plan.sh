pkg_origin=

pkg_name=smb4k
pkg_version=2.0.1
_commit=3056bb01733ec009d789e831636e4fe487d79598
pkg_description='Advanced network neighborhood browser and Samba share mounting utility for KDE.'
pkg_upstream_url='https://sourceforge.net/p/smb4k/home/Home/'
pkg_license=('GPL')
pkg_deps=('kconfig' 'kauth' 'kiconthemes' 'solid' 'kwidgetsaddons' 'ki18n' 'kcompletion' 'kcoreaddons'
         'kio' 'knotifications' 'kxmlgui' 'kjobwidgets' 'kwallet' 'kdbusaddons' 'kparts' 'kconfigwidgets'
         'kwindowsystem' 'plasma-framework' 'samba')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("https://sourceforge.net/projects/smb4k/files/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
        "https://github.com/KDE/smb4k/commit/a90289b0962663bc1d247bbbd31b9e65b2ca000e.diff")
pkg_shasum=('258f5456d27434c80d866a804b4714d6'
         'a0b22c9266098aa604485d171f964c6b')

do_prepare() {
  cd ${pkg_name}-${pkg_version}

  #sed -i -e 's|Unknown|UnknownNetworkItem|' core/smb4kbasicnetworkitem.h
  #patch -p1 -i ${CACHE_PATH}/a90289b0962663bc1d247bbbd31b9e65b2ca000e.diff
}

do_build() {
  mkdir -p build 
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
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
