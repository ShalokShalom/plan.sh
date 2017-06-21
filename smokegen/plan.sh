pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=smokegen
#pkg_version=${_kdever}
pkg_version=15.08.70
pkg_description="A general purpose C++ parser with a plugin infrastructure"
pkg_upstream_url="https://projects.kde.org/projects/kde/kdebindings/smoke/smokegen"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('qt5-base')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git')
           'kdebindings-pykde4'
           'kdebindings-smokeqt'
           'kdebindings-smokekde'
           'kdebindings-qyoto'
           'kdebindings-kimono'
           'kdebindings-qtruby'
           'kdebindings-korundum'
           'kdebindings-perlqt'
           'kdebindings-perlkde')
          'kdebindings-pykde4'
          'kdebindings-smokeqt'
          'kdebindings-smokekde'
          'kdebindings-qyoto'
          'kdebindings-kimono'
          'kdebindings-qtruby'
          'kdebindings-korundum'
          'kdebindings-perlqt'
          'kdebindings-perlkde')
#groups=("kde" "kdebindings" "kde-uninstall")
#pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
#pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
pkg_source=("git://anongit.kde.org/smokegen#branch=Qt5")
pkg_shasum=('SKIP')

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}

