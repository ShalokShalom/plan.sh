pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kpackage
pkg_version=${_kf5ver}
pkg_description='Framework that lets applications manage user installable packages of non-binary assets'
pkg_upstream_url='https://projects.kde.org/projects/frameworks/kpackage'
pkg_license=('LGPL')
pkg_deps=('karchive' 'ki18n' 'kcoreaddons' 'kconfig')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("http://download.kde.org/stable/frameworks/5.29/${pkg_name}-${pkg_version}.tar.xz"
        "https://github.com/KDE/kpackage/commit/e7861d979c71815a614f2baf0b3d25f329fadef0.diff")
pkg_shasum=(`grep ${pkg_name}-${_kf5ver}.tar.xz ../kf5.md5 | cut -d" " -f1`
         '5de4d8d74ed58ff4b13abe87b215f78e')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  
  #patch -p1 -i ${CACHE_PATH}/e7861d979c71815a614f2baf0b3d25f329fadef0.diff
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
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
