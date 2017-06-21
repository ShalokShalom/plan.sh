pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kcm-touchpad
#pkg_version=${_plasmaver}
pkg_version=5.1.96
pkg_description="KCM, daemon and applet for touchpad."
pkg_upstream_url="https://projects.kde.org/projects/kde/workspace/kcm-touchpad"
pkg_license=('GPL')
pkg_deps=('kinit' 'kcmutils' 'kcoreaddons' 'kconfigwidgets' 'kdbusaddons' 'kcompletion' 'kwidgetsaddons'
         'ki18n' 'kservice' 'knotifyconfig' 'kxmlgui' 'knotifications' 'kglobalaccel' 'plasma-workspace'
         'xf86-input-synaptics' 'libx11' 'libxcb' 'xorg-server' 'libxi')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'pkg-config')
pkg_source=("git://anongit.kde.org/kcm-touchpad.git"
        'xlibbackend.diff'
        'x11.diff')
#pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.xz ../kf5.md5 | cut -d" " -f1`
pkg_shasum=('SKIP'
         '417d582f137c4d6c8c80501c817e9f66'
         'bb1c795439814faebfad23f71161f544')

do_prepare() {
  cd ${pkg_name}
  patch -p0 -i ${CACHE_PATH}/xlibbackend.diff
  patch -p0 -i ${CACHE_PATH}/x11.diff
}

do_build() {
  cd ${CACHE_PATH}
  
  mkdir -p build
  cd build

  cmake ../${pkg_name} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DSYSCONF_INSTALL_DIR=/etc \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}

