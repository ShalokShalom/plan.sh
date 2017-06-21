pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=baloo
pkg_version=${_kf5ver}
#pkg_version=5.9.2
pkg_description="A framework for searching and managing metadata"
pkg_upstream_url='https://projects.kde.org/projects/kde/kdelibs/baloo'
pkg_license=('LGPL')
pkg_deps=('xapian-core' 'kfilemetadata' 'ki18n' 'kconfig' 'kidletime' 'kauth' 'kcrash' 'solid' 'kio'
         'kdbusaddons' 'lmdb') 
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
backup=('etc/sysctl.d/97-kde-baloo-filewatch-inotify.conf')
pkg_source=("http://download.kde.org/stable/frameworks/5.23/baloo-${pkg_version}.tar.xz"
        '97-kde-baloo-filewatch-inotify.conf'
        'dolphin_db.diff')
pkg_shasum=(`grep ${pkg_name}-${_kf5ver}.tar.xz ../kf5.md5 | cut -d" " -f1`
         '0c9e9337b006f5826ffb85e704f414c1'
         '965e3031d46db546e5c2b3080026b8c6')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  patch -p1 -i ${CACHE_PATH}/dolphin_db.diff
}
         
do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 ${CACHE_PATH}/97-kde-baloo-filewatch-inotify.conf ${pkg_prefix}/etc/sysctl.d/97-kde-baloo-filewatch-inotify.conf
}
