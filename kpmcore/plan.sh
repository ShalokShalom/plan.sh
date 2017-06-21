pkg_origin=

pkg_name=kpmcore
pkg_version=3.1.0
_commit=cbe21e7ef974fe3c95ef418bbf098af716e5ff33
pkg_description="Library for managing partitions. Common code for KDE Partition Manager and other projects."
pkg_upstream_url="https://github.com/KDE/kpmcore"
pkg_license=('GPL2')
pkg_deps=('ki18n' 'kio' 'kiconthemes' 'kservice' 'libatasmart' 'parted')
pkg_build_deps=('extra-cmake-modules' 'pkgconfig')
pkg_source=("https://download.kde.org/stable/kpmcore/${pkg_version}/src/${pkg_name}-${pkg_version}.tar.xz"
        "https://github.com/KDE/kpmcore/commit/b10577e1c7ba0c856c96c96a80187b977f88ef34.diff")
#pkg_source=("https://github.com/KDE/kpmcore/archive/${_commit}.zip")
pkg_shasum=('c1e3a56179cabd92221f2948b6da5c10'
         '34ea3e797a3877086aa212ae2aee0814')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  # Fix creation of encrypted volumes
  #patch -p1 -i ${CACHE_PATH}/b10577e1c7ba0c856c96c96a80187b977f88ef34.diff
}

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        -DKDE_INSTALL_LIBDIR=lib \
        -DKDE_INSTALL_SYSCONFDIR=/etc \
        -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
        -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
        -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
        -DBUILD_TESTING=OFF 

  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install 
}

