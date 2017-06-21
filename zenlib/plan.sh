pkg_origin=

pkg_name=zenlib
_pkg_name=ZenLib
pkg_version=0.4.35
pkg_description="Small C++ derivate classes to have an easier life"
pkg_upstream_url="https://github.com/MediaArea/ZenLib"
pkg_license=('BSD')
pkg_deps=('gcc-libs')
pkg_build_deps=('libtool')
pkg_source=("https://github.com/MediaArea/ZenLib/archive/v${pkg_version}.tar.gz")
pkg_shasum=('91c8b717561353298c6ed591b8e39d44')

do_build() {
  cd ${_pkg_name}-${pkg_version}/Project/GNU/Library
  
  ./autogen.sh
  ./configure --prefix=/usr --enable-shared
  make
}

do_package() {
  cd ${_pkg_name}-${pkg_version}/Project/GNU/Library
  make DESTDIR=${pkg_prefix} install
  
  cd ../../..
  install -D -m 644 License.txt ${pkg_prefix}/usr/share/licenses/zenlib/License.txt
}
