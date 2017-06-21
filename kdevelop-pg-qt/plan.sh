pkg_origin=

pkg_name=kdevelop-pg-qt
pkg_version=2.0
_pkg_version=2.0.0
pkg_description="KDevelop Parser Generator, a LL(1) parser generator used by KDevelop language plugins"
pkg_upstream_url="http://www.kdevelop.org/"
pkg_license=('GPL')
pkg_deps=('qt5-base')
pkg_build_deps=('extra-cmake-modules' 'git')
pkg_source=("http://download.kde.org/stable/${pkg_name}/${_pkg_version}/src/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('b4574822f45220e241cea19a3f924beb')

do_build() {
  mkdir -p build
  cd build 
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DKDE_INSTALL_LIBDIR=lib
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
