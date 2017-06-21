pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=oxygen-fonts
pkg_version=${_plasmaver}
pkg_description='The Oxygen font family. A desktop/gui font family for integrated use with the KDE desktop.'
pkg_upstream_url='https://projects.kde.org/projects/playground/artwork/oxygen-fonts'
pkg_license=('LGPL')
pkg_deps=('xorg-fonts-encodings')
pkg_build_deps=('extra-cmake-modules' 'python2' 'fontforge')
pkg_source=("http://download.kde.org/stable/plasma/$pkg_version/$pkg_name-$pkg_version.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_plasmaver.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DLIB_INSTALL_DIR=lib  
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
