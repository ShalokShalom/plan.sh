pkg_origin=cosmos

pkg_name=libpsl
pkg_version=0.17.0
pkg_description="Provides functions to work with the Mozilla Public Suffix List."
pkg_upstream_url="https://rockdaboot.github.io/libpsl/"
pkg_license=('MIT')
pkg_deps=('icu')
pkg_build_deps=('python2')
pkg_source=("https://github.com/rockdaboot/libpsl/releases/download/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('fed13f33d0d6dc13ef24de255630bfcb')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./configure \
    --prefix=/usr \
    --disable-static \
    --disable-dependency-tracking \
    --enable-man \
    --enable-builtin=libicu \
    --enable-runtime=libicu

  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install

  install -m755 -d ${pkg_prefix}/usr/share/licenses/libpsl
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/libpsl/
}

