pkg_origin=

pkg_name=zanshin
pkg_version=0.4.1
pkg_description="A Getting Things Done application which aims at getting your mind like water."
pkg_upstream_url="https://zanshin.kde.org/"
pkg_license=('GPL')
pkg_deps=('akonadi-calendar' 'akonadi-notes' 'akonadi-search' 'kidentitymanagement' 'kontactinterface'
         'kldap' 'krunner' 'kwallet' 'kmime' 'kcalcore' 'kparts' 'kcoreaddons')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
pkg_source=("http://files.kde.org/zanshin/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('0da13182cf3ace42b65500e40edbbe05')

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
