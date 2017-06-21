pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kwalletmanager
pkg_version=${_kdever}
pkg_description="Wallet Manager is a tool to manage the passwords on your KDE system"
pkg_upstream_url="https://projects.kde.org/projects/kde/kdeutils/kwalletmanager"
pkg_license=('LGPL')
pkg_deps=('kcmutils' 'kemoticons' 'kdelibs4support' 'kitemmodels' 'kinit' 'kwallet' 'kxmlgui')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("http://download.kde.org/stable/applications/${_kdever}/src/${pkg_name}-${_kdever}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  cd $pkg_name-${pkg_version}
  mkdir build
  
  cd build
  cmake -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE=Release \
        -DKDE_INSTALL_LIBDIR=lib \
        -DKDE_INSTALL_LIBEXECDIR=lib \
        -DKDE_INSTALL_SYSCONFDIR=/etc \
        -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
        -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
        -DBUILD_TESTING=OFF ..
  make
}

do_package() {
  cd $pkg_name-${pkg_version}/build
  
  make DESTDIR="$pkg_prefix" install
}
