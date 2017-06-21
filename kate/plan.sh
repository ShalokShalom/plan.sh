pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kate
pkg_version=${_kdever}
pkg_description='Advanced editor component which is used in numerous KDE applications requiring a text editing component'
pkg_upstream_url='https://projects.kde.org/projects/kde/applications/kate'
pkg_license=('LGPL')
pkg_deps=('kconfig' 'kguiaddons' 'ki18n' 'kjobwidgets' 'kitemmodels' 'threadweaver'
         'kio' 'knewstuff' 'kparts' 'ktexteditor' 'kwindowsystem' 'kxmlgui' 'plasma-framework')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd $pkg_name-${pkg_version}
  # keep kdesu option for kate/kwrite, comment out for now, wait for upstream decision
  #patch -R -p1 -i ${CACHE_PATH}/kdesu.patch
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DKDE_INSTALL_LIBDIR=lib
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
