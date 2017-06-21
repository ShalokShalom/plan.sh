pkg_origin=cosmos

pkg_name=libgpod
pkg_version=0.8.3
pkg_description="Shared library, written using C and GLib/GObject, used by gtkpod to access the contents of an iPod."
pkg_upstream_url="http://www.gtkpod.org/libgpod.html"
pkg_license=('LGPL')
pkg_deps=('mutagen' 'sg3_utils' 'libimobiledevice' 'gdk-pixbuf2')
pkg_build_deps=('intltool' 'swig' 'docbook-xsl' 'python2-gobject')
pkg_source=("https://downloads.sourceforge.net/sourceforge/gtkpod/${pkg_name}-${pkg_version}.tar.bz2"
        'segmentation.patch'
        'libgpod-fixmono.patch'
        'swig.diff')
pkg_shasum=('f8a0b7a34e768e33a708e8dd172bd6f8'
         '6b773f274eb33e61a3f5d5589d7ebe06'
         'b1cc98c39b3cc5f42f5fbeecceb521bc'
         '3f6834951374b086aefc5b81d91cbb14')

do_build() {
  # https://sourceforge.net/p/gtkpod/libgpod/ci/8dc5015ae036b219c4c9579a156886aa3a722aa5/
  patch -p1 -i ${CACHE_PATH}/segmentation.patch
  patch -p1 -i ${CACHE_PATH}/libgpod-fixmono.patch
  # newer swig trips over annotation format
  patch -p1 -i ${CACHE_PATH}/swig.diff
  
  ./configure --prefix=/usr \
      --with-udev-dir=/usr/lib/udev \
      --enable-udev
      
  make PREFIX=/usr
}

do_package() {
  make PREFIX=/usr DESTDIR=${pkg_prefix} install

  #copy headers
  #cp -v src/*.h ${pkg_prefix}/usr/include/gpod-1.0/gpod/
}
