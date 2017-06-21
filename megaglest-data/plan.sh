pkg_origin=

pkg_name=megaglest-data
pkg_version=3.13.0
pkg_description="Libre software cross platform real-time strategy game. (data files)"
pkg_upstream_url="https://github.com/megaglest"
pkg_license=('custom:CCBYSA3.0')
pkg_build_deps=('cmake' 'xz')
pkg_source=("https://github.com/MegaGlest/megaglest-data/releases/download/${pkg_version}/megaglest-data-${pkg_version}.tar.xz")
pkg_shasum=('f9664a250cab051686367bf534d449d1')

do_build() {
  cd megaglest-${pkg_version}

  mkdir build 
  cd build

  cmake -DCMAKE_INSTALL_PREFIX=/usr ..
}

do_package() {
  cd megaglest-${pkg_version}/build
  make DESTDIR=${pkg_prefix} install

  install -Dm644 ../docs/README.data-license.txt ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
