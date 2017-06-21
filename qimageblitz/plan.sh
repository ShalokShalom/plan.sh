pkg_origin=cosmos

pkg_name=qimageblitz
pkg_version=0.0.6.1
pkg_description="An interm image effect library, Qt5 version"
pkg_upstream_url="http://www.kde-org"
pkg_license=('custom')
pkg_deps=('qt5-base')
pkg_build_deps=('cmake' 'subversion')
pkg_source=("svn://anonsvn.kde.org/home/kde/trunk/kdesupport/qimageblitz")
pkg_shasum=('SKIP')

do_build() {
  mkdir -p build
  
  cmake ../${pkg_name} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr 
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}
