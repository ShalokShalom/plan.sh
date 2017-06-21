pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=khelpcenter
pkg_version=${_kdever}
pkg_description='Application to show KDE Applications documentation'
pkg_upstream_url='https://projects.kde.org/projects/kde/workspace/khelpcenter'
pkg_license=('LGPL')
pkg_deps=('karchive' 'kbookmarks' 'kconfig' 'kcoreaddons' 'ki18n' 'kinit' 'khtml' 'kservice'
         'kwindowsystem' 'grantlee' 'xapian-core')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("http://download.kde.org/stable/applications/${pkg_version}/src/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  #sed -e "s|add_subdirectory(pt_BR)|#add_subdirectory(pt_BR)|" -i ${CACHE_PATH}/${pkg_name}-${pkg_version}/doc/CMakeLists.txt
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build

  make DESTDIR="${pkg_prefix}" install
}
