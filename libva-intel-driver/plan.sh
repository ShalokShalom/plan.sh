pkg_origin=cosmos

pkg_name=libva-intel-driver
_pkg_name=intel-vaapi-driver
pkg_version=1.8.2
pkg_description='VA-API implementation for Intel G45 chipsets and Intel HD Graphics for Intel Core processor family'
pkg_upstream_url='https://github.com/01org/intel-vaapi-driver'
pkg_license=('MIT')
pkg_deps=('libva')
pkg_source=("https://www.freedesktop.org/software/vaapi/releases/libva-intel-driver/${_pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('fd70a5f739b5d8a8dbf612843ebedf39')

do_build() {

  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING
}
