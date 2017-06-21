pkg_origin=

pkg_name=qrencode
pkg_version=3.4.4
pkg_description="C library for encoding data in a QR Code symbol."
pkg_upstream_url="https://fukuchi.org/works/qrencode/"
pkg_license=('GPL')
pkg_deps=('libpng')
pkg_build_deps=('sdl')
pkg_source=("https://fukuchi.org/works/qrencode/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('62ba472bede0ad393cc63e0012b5f007')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./configure --prefix=/usr
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}

  make prefix=${pkg_prefix}/usr install
}
