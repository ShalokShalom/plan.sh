pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=akonadi-search
pkg_version=${_kdever}
pkg_description="Libraries and daemons to implement searching in Akonadi."
pkg_upstream_url='https://projects.kde.org/projects/playground/pim/akonadi-search'
pkg_license=('LGPL')
pkg_deps=('xapian-core' 'akonadi' 'ki18n' 'kconfig' 'kcrash' 'kcmutils' 'krunner' 'akonadi-mime'
         'kcontacts' 'kmime' 'kcalcore')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz)
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_LIBDIR=lib 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
  # conflicts with kf5-baloo for now
  #rm -r ${pkg_prefix}/usr/lib/qt5/plugins/kf5/baloo/
}
