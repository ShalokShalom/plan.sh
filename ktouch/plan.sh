pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=ktouch
pkg_version=${_kdever}
pkg_description="Touch Typing Tutor"
pkg_upstream_url="http://kde.org/applications/education/ktouch/"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kconfig' 'kconfigwidgets' 'kcoreaddons' 'kdeclarative' 'ki18n' 'kio' 'knewstuff' 'kwidgetsaddons'
         'kxmlgui' 'kitemviews' 'kcmutils' 'ktexteditor' 'kwindowsystem' 'kqtquickcharts') # 'libxkbfile')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-${_kdever}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  sed -i -e 's|Exec=ktouch|Exec=ktouch -qwindowtitle %c %u|' org.kde.ktouch.desktop
}

do_build() {
  mkdir build
  
  cd build
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
