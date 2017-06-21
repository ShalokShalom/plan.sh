pkg_origin=

pkg_name=skanlite
pkg_version=2.0.1
_pkg_version=2.0
pkg_description="Image Scanning Application for KDE"
pkg_upstream_url='https://projects.kde.org/projects/extragear/graphics/skanlite'
pkg_license=('LGPL')
pkg_deps=('kio' 'libksane' 'sane')
pkg_build_deps=('pkgconfig' 'extra-cmake-modules' 'kdoctools')
pkg_source=("http://download.kde.org/stable/skanlite/${_pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('95e310b2030bb55562268fe50252feb0')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
