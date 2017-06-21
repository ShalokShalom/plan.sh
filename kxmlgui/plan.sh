pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kxmlgui
pkg_version=${_kf5ver}
pkg_description='KXMLGUI provides a framework for managing menu and toolbar actions in an abstract way'
pkg_upstream_url='https://projects.kde.org/projects/frameworks/kxmlgui'
pkg_license=('LGPL')
pkg_deps=('kglobalaccel' 'ktextwidgets' 'kf5-attica')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("http://download.kde.org/unstable/frameworks/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
        "https://github.com/KDE/kxmlgui/commit/1bc3a0b41c0c119cd049160a87b09ea95a4532a0.diff"
        "https://github.com/KDE/kxmlgui/commit/78e572dadf64903bb7356b5fcfd763f6e898fa61.diff")
pkg_shasum=(`grep ${pkg_name}-${_kf5ver}.tar.xz ../kf5.md5 | cut -d" " -f1`
         'e0079770a362edbb9561da33d5d1b627'
         '46f6f0f2f78572551883d482631803ce')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  # patches to revert 2 commits, used for wayland, use https://codereview.qt-project.org/#/c/195704/ instead
  patch -p1 -i ${CACHE_PATH}/78e572dadf64903bb7356b5fcfd763f6e898fa61.diff
  patch -p1 -i ${CACHE_PATH}/1bc3a0b41c0c119cd049160a87b09ea95a4532a0.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DECM_MKSPECS_INSTALL_DIR=/usr/lib/qt5/mkspecs/modules \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
