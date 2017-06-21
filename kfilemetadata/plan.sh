pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kfilemetadata
pkg_version=${_kf5ver}
pkg_description="A library for extracting file metadata"
pkg_upstream_url='https://projects.kde.org/projects/kde/kdelibs/kfilemetadata'
pkg_license=('LGPL')
pkg_deps=('ebook-tools' 'karchive' 'exiv2' 'ki18n' 'poppler-qt5' 'taglib' 'ffmpeg')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("http://download.kde.org/stable/frameworks/5.25/${pkg_name}-$pkg_version.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kf5ver.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_prepare() {
  cd $pkg_name-${pkg_version}
  #sed -i -e 's/ecm_setup_version(5.0.0/ecm_setup_version(1/' ${CACHE_PATH}/${_pkg_name}-${pkg_version}/CMakeLists.txt
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DLIB_INSTALL_DIR=lib
  make
}

do_package() {
  cd build

  make DESTDIR="${pkg_prefix}" install
}
