pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=libkexiv2
pkg_version=${_kdever}
#pkg_version=15.07.71
pkg_description="Wrapper around exiv2"
pkg_upstream_url='http://www.kde.org'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('ktextwidgets' 'kcoreaddons' 'ki18n' 'libjpeg-turbo' 'exiv2')
pkg_build_deps=('pkg-config' 'extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz"
        "https://github.com/KDE/libkexiv2/commit/2bcdea1a25b7ee69b4db93a12b8197a5bfa0bc1a.diff")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`
         '63577aa5da06464ef90cd96ab876b74d')
#pkg_source=("git://anongit.kde.org/libkexiv2.git")
#pkg_shasum=('SKIP')

do_prepare() {
  cd $pkg_name-${pkg_version}
  #patch -p1 -i ${CACHE_PATH}/2bcdea1a25b7ee69b4db93a12b8197a5bfa0bc1a.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
