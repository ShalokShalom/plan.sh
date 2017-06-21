pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kmag
#pkg_version=${_kdever}
pkg_version=17.03.70
_commit=b270d7503b94629891dddd84422a64b6cefa2b63
pkg_description="Screen magnifier"
pkg_upstream_url="https://github.com/KDE/kmag"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('ki18n' 'kio' 'kxmlgui')
pkg_build_deps=('pkgconfig' 'extra-cmake-modules' 'kdoctools')
#pkg_source=($_mirror/${pkg_name}-$_kdever.tar.xz)
#pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
pkg_source=("https://github.com/KDE/kmag/archive/${_commit}.zip")
pkg_shasum=('c1c4e4e59dcb399819ce1c80c97a2bd7')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
