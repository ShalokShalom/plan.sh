pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=knewstuff
pkg_version=${_kf5ver}
pkg_description='KNewStuff'
pkg_upstream_url='https://projects.kde.org/projects/frameworks/knewstuff'
pkg_license=('LGPL')
pkg_deps=('kf5-attica' 'kconfigwidgets' 'kio')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("http://download.kde.org/unstable/frameworks/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
        "https://github.com/KDE/knewstuff/commit/7993c90088779a3140187c5adf5ee1f04b6c8ff4.diff"
        "https://github.com/KDE/knewstuff/commit/7f910418644bf376ad3d7b81d26db5a353ed199e.diff"
        "https://github.com/KDE/knewstuff/commit/7407ca5b4780d8fd91e2c50f25705a4ecc14de87.diff")
pkg_shasum=(`grep ${pkg_name}-${_kf5ver}.tar.xz ../kf5.md5 | cut -d" " -f1`
         'b417b6045b88659188c6f3f0bc7f7922'
         '1a1a3d8c6c32dba5b8c2bebf685dd90e'
         '2e235fcbc6e8a22865759cb14daf0913')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  # fix getting new wallpapers from GHNS, add one more patch then is included in respon 5.30.1
  #patch -p1 -i ${CACHE_PATH}/7993c90088779a3140187c5adf5ee1f04b6c8ff4.diff
  #patch -p1 -i ${CACHE_PATH}/7f910418644bf376ad3d7b81d26db5a353ed199e.diff
  #patch -p1 -i ${CACHE_PATH}/7407ca5b4780d8fd91e2c50f25705a4ecc14de87.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DECM_MKSPECS_INSTALL_DIR=/usr/lib/qt5/mkspecs/modules \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
}
