pkg_origin=cosmos

pkg_name=libgphoto2
pkg_version=2.5.14
pkg_description="The core library of gphoto2 with increased file limits"
pkg_upstream_url="http://www.gphoto.org"
pkg_license=('LGPL')
pkg_deps=('libexif' 'libjpeg>=8' 'gd' 'libtool' 'libusb')
pkg_source=("https://downloads.sourceforge.net/gphoto/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('65acb6cbd2b4f3f46829599f5dabd89c')

do_build() {

  #Change the limit which cause "Fixed limit exceeded"
  sed -i "s#MAX_ENTRIES 1024#MAX_ENTRIES 8192#" libgphoto2/gphoto2-list.c

  ./configure \
    --prefix=/usr \
    --disable-rpath
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -m755 -d ${pkg_prefix}/usr/lib/udev/hwdb.d
  LD_LIBRARY_PATH=${pkg_prefix}/usr/lib${LD_LIBRARY_PATH:+:}$LD_LIBRARY_PATH \
  CAMLIBS=${pkg_prefix}/usr/lib/libgphoto2/${pkg_version} \
      
  ${pkg_prefix}/usr/lib/libgphoto2/print-camera-list hwdb > \
  ${pkg_prefix}/usr/lib/udev/hwdb.d/20-gphoto.conf

  rm -f ${pkg_prefix}/usr/include/gphoto2/gphoto2
}
