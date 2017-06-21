pkg_origin=cosmos

pkg_name=libraw1394
pkg_version=2.1.2
pkg_license=('LGPL2.1')
pkg_description="Provides an API to the Linux IEEE1394 (FireWire) driver"
pkg_deps=('glibc')
pkg_build_deps=('pkgconfig')
pkg_upstream_url="https://ieee1394.wiki.kernel.org/index.php/Main_Page"
pkg_source=("ftp://ftp.kernel.org/pub/linux/libs/ieee1394/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('118060584c04f1aa5e29c4d22c1c235a')

do_build() {

   ./configure --prefix=/usr 
   make 
}

do_package() {

   make DESTDIR=${pkg_prefix} install 
}
