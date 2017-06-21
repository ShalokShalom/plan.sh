pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=dolphin-plugins
pkg_version=${_kdever}
#pkg_version=15.03.70
pkg_description='Extra Dolphin plugins'
pkg_upstream_url='https://projects.kde.org/projects/kde/kdesdk/dolphin-plugins'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kxmlgui' 'ki18n' 'kio' 'kdelibs4support' 'ktexteditor' 'kwidgetsaddons' 'dolphin')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git')
optpkg_deps=('git: git support'
            #'mercurial: hg support'
            'subversion: svn support')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/dolphin-plugins.git#branch=frameworks")
#pkg_shasum=('SKIP')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DSYSCONF_INSTALL_DIR=/etc \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DLIB_INSTALL_DIR=lib
  make
}

do_package() {
  cd build

  make DESTDIR="${pkg_prefix}" install
}
