pkg_origin=

pkg_name=kile
pkg_version=2.9.72
_commit=3bf485d21fa721723fce6bc600f86c73c818ce69
pkg_description="User friendly TeX/LaTeX frontend for KDE."
pkg_license=('GPL2')
pkg_upstream_url="http://kile.sourceforge.net/"
pkg_deps=('kconfig' 'kcoreaddons' 'kcrash' 'kdbusaddons' 'kguiaddons' 'ki18n' 'kiconthemes' 'kinit' 'kio' 
         'kparts' 'ktexteditor' 'kwindowsystem' 'kxmlgui' 'texlive-core' 'docbook-xsl' 'okular')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("https://github.com/KDE/kile/archive/${_commit}.zip")
pkg_shasum=('96a98eae1eef33cb63896d73e7466902')

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
  # conflict with kmymony
  rm ${pkg_prefix}/usr/share/icons/hicolor/16x16/actions/delete.png
}
