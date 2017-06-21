pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=sddm-kcm
pkg_version=${_plasmaver}
epoch=1
pkg_description="SDDM configuration module for KDE"
pkg_upstream_url="https://github.com/sddm/sddm-kcm"
pkg_license=("GPL")
pkg_deps=('kcoreaddons' 'ki18n' 'kxmlgui' 'kauth' 'kconfigwidgets' 'kio' 'karchive' 'knewstuff' 
         'sddm' 'libx11' 'libxcb' 'libxcursor')
pkg_build_deps=('git' 'extra-cmake-modules' 'kdoctools' 'qt5-tools')
#pkg_source=("http://download.kde.org/stable/plasma/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz"
        'themesmodel.diff')
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.gz ../kf5.md5 | cut -d" " -f1`
         '23e2cdd7eaa16b1c4f9fef11e3398121')

do_prepare() {
   cd ${pkg_name}-${__pkg_version}

   #patch -p1 -i ${CACHE_PATH}/themesmodel.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${__pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
