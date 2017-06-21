pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=gwenview
pkg_version=${_kdever}
pkg_description="A fast and easy to use image viewer for KDE"
pkg_upstream_url="http://kde.org/applications/graphics/gwenview/"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kdelibs4support' 'baloo' 'kimageformats' 'phonon-qt5' 'libpng' 'exiv2' 'lcms2'
         'libjpeg-turbo' 'libkdcraw' 'libkipi' 'kipi-plugins')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'pkg-config')
oppkg_deps=('kamera: to work directly with cameras')
pkg_source=("$_mirror/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_shasum=('39b025dfb4e4628229216d86315ce799')
#pkg_source=("git://anongit.kde.org/gwenview.git")
#pkg_shasum=('SKIP')

do_prepare() {
  cd $pkg_name-${pkg_version}
  #sed -i -e 's/Kdcraw/KF5KDcraw/' ${CACHE_PATH}/${pkg_name}-${pkg_version}/CMakeLists.txt
  # fix https://bugs.kde.org/show_bug.cgi?id=379615
  #patch -p1 -i ${CACHE_PATH}/6ce5d2f8d82f83c5a3d726ee5807ebaf7a6e3c6c.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF \
    -DGWENVIEW_SEMANTICINFO_BACKEND_BALOO=ON
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}

