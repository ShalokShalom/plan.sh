pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kalzium
pkg_version=${_kdever}
pkg_description="Periodic Table of Elements"
pkg_upstream_url="http://kde.org/applications/education/kalzium/"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('avogadrolibs' 'eigen3' 'ocaml' 'chemical-mime-data' 'openbabel'
         'karchive' 'kconfig' 'kcoreaddons' 'ki18n' 'kdelibs4support' 'khtml'
         'knewstuff' 'kparts' 'kplotting' 'solid' 'kunitconversion' 'kwidgetsaddons')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'facile')
pkg_source=("$_mirror/${pkg_name}-${_kdever}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd ${pkg_name}-${pkg_version}

  #patch -p1 -i ${CACHE_PATH}/04048799910fc423a5fa100a1c46b91dbe8e7e61.diff
}

do_build() {  
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
