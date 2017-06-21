pkg_origin=cosmos

pkg_name=libiec61883
pkg_version=1.2.0
pkg_description="A higher level API for streaming DV, MPEG-2 and audio over Linux IEEE 1394"
pkg_upstream_url="https://www.kernel.org/pub/linux/libs/ieee1394/"
pkg_license=('LGPL')
pkg_deps=('libraw1394')
pkg_source=("https://www.kernel.org/pub/linux/libs/ieee1394/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('ed91bc1727fac8e019402fc3724a283d')

do_build() {

  ./configure --prefix=/usr 
  make 
}

do_package() {

  make DESTDIR=${pkg_prefix} install 
}
