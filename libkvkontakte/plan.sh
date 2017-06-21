pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=libkvkontakte
#pkg_version=${_kdever}
pkg_version=4.70.0
_commit=b5d347c14824445770003759b58b335682f2ecaa
pkg_description="KDE C++ library for asynchronous interaction with vkontakte.ru social network via its open API."
pkg_upstream_url='https://github.com/KDE/libkvkontakte'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kio' 'ki18n' 'kdewebkit' 'kcoreaddons' 'kwidgetsaddons')
pkg_build_deps=('pkg-config' 'extra-cmake-modules' 'kdoctools')
#pkg_source=("http://download.kde.org/stable/libkvkontakte/${pkg_version}/src/${pkg_name}-${pkg_version}.tar.xz")
pkg_source=("https://github.com/KDE/libkvkontakte/archive/${_commit}.zip")
pkg_shasum=('c481949c9d4457bf62799a44426bf239')

#do_prepare() {
  #cd ${pkg_name}-${_commit}
  #sed -i -e 's|KF5::KDELibs4Support|KF5::KDELibs4Support KF5::KHtml|' ${CACHE_PATH}/${pkg_name}/src/CMakeLists.txt
#}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
