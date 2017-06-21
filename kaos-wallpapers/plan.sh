pkg_origin=

pkg_name=kaos-wallpapers
pkg_version=3.0
_commit=3991cdb108d3ea20c441a086e7a29929bc9b4417
pkg_description="KaOS Wallpaper Set"
pkg_upstream_url="http://kaosx.us"
pkg_license=('GPL')
pkg_deps=('kservice')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("https://github.com/kaosx/kaos-wallpapers/archive/${_commit}.zip")
pkg_shasum=('46c860785c13055fb8bfe54cb77a53ca')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}


