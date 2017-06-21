pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kded
pkg_version=${_kf5ver}
pkg_description='KDE Daemon'
pkg_upstream_url='https://github.com/KDE/kded'
pkg_license=('LGPL')
pkg_deps=('kservice' 'kinit')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("http://download.kde.org/unstable/frameworks/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
        'blocking.diff')
pkg_shasum=(`grep ${pkg_name}-$_kf5ver.tar.xz ../kf5.md5 | cut -d" " -f1`
         'd260c76d7ebcbe6e2980664bd8f9f99f')

do_prepare() {
  cd $pkg_name-${pkg_version}
  
  #patch -p1 -R -i $CACHE_PATH/blocking.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR="${pkg_prefix}" install
}
