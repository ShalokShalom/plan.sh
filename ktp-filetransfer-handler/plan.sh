pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=ktp-filetransfer-handler
pkg_version=${_kdever}
pkg_description="Telepathy file transfer handler"
pkg_upstream_url="https://projects.kde.org/projects/extragear/network/telepathy/ktp-filetransfer-handler"
pkg_license=('GPL')
pkg_deps=('ktp-common-internals')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git')
#pkg_source=("ftp://mirrors.mit.edu/kde/stable/kde-telepathy/${pkg_version}/src/${pkg_name}-${pkg_version}.tar.bz2")
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  cd ${CACHE_PATH}
  
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
