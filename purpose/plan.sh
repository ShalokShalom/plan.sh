pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=purpose
pkg_version=1.1.90
_pkg_version=1.1.90
pkg_description="Framework for providing abstractions to get the developer's purposes fulfilled."
pkg_upstream_url='http://quickgit.kde.org/?p=purpose.git'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kcoreaddons' 'kconfig' 'ki18n' 'kio' 'kaccounts-integration') # these deps not found for qml dir 'accounts-qml-module' 'kdeconnect-kde' 'kdeclarative')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'intltool' 'git')
#groups=('')
#pkg_shasum=(`grep ${_pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/purpose")
pkg_source=("http://download.kde.org/unstable/purpose/purpose-${_pkg_version}.tar.xz")
pkg_shasum=('739757b0bce9ec98c8bca7a644be89ad')

do_prepare() {
  cd ${pkg_name}-${_pkg_version}
  #patch -p1 -i $CACHE_PATH/accounts.diff
  #sed -i -e 's|add_subdirectory(youtube)|#add_subdirectory(youtube)|' ${CACHE_PATH}/${pkg_name}-${_pkg_version}/src/plugins/CMakeLists.txt
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${_pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DCMAKE_MODULE_PATH=/usr/lib/qt5/qml \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}

