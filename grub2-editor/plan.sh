pkg_origin=

pkg_name=grub2-editor
pkg_version=0.7.0
_commit=1d24fd0df0f7733240b051fb89535433cbd2bdc1
pkg_description="A KDE control module for configuring the GRUB2 bootloader."
pkg_upstream_url="https://github.com/maz-1/grub2-editor"
pkg_license=('GPL3')
pkg_deps=('kcoreaddons' 'ki18n' 'kauth' 'kconfigwidgets' 'kio' 'solid'
         'imagemagick' 'hwinfo' 'librsvg' 'grub' 'os-prober')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("https://github.com/maz-1/grub2-editor/archive/${_commit}.zip")
pkg_shasum=('491a56e13552475309fb4245dc4289d6')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DSYSCONF_INSTALL_DIR=/etc \
    -DBUILD_TESTING=OFF \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DLIB_INSTALL_DIR=lib
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}

