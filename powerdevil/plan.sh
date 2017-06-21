pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=powerdevil
pkg_version=${_plasmaver}
pkg_description='KDE power management tools'
pkg_upstream_url='https://projects.kde.org/projects/extragear/base/powerdevil'
pkg_license=('LGPL')
pkg_deps=('plasma-workspace' 'libxrandr' 'bluez-qt')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
#pkg_source=("http://download.kde.org/stable/plasma/$pkg_version/$pkg_name-$pkg_version.tar.xz"
pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz"
        'brightness.diff')
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.gz ../kf5.md5 | cut -d" " -f1`
         'aafb843abac9bea5267e5263bb857381')

do_prepare() {
  cd ${CACHE_PATH}/${pkg_name}-${__pkg_version}
  
  #patch -p1 -i ${CACHE_PATH}/brightness.diff
}
         
do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${__pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DLIBEXEC_INSTALL_DIR=lib \
    -DSYSCONF_INSTALL_DIR=/etc \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
