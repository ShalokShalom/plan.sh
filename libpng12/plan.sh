pkg_origin=cosmos

pkg_name=libpng12
_pkg_name=libpng
pkg_version=1.2.57
pkg_description="A collection of routines used to create PNG format graphics files"
pkg_upstream_url="http://www.libpng.org/pub/png/libpng.html"
pkg_license=('custom')
pkg_deps=('zlib')
pkg_source=("http://sourceforge.net/projects/libpng/files/libpng-${pkg_version}.tar.xz"
        "http://sourceforge.net/projects/apng/files/libpng/libpng12/libpng-${pkg_version}-apng.patch.gz")
pkg_shasum=('307052e5e8af97b82b17b64fb1b3677a'
         '517c08350e4a04f509ca910e1208b215')


do_build() {
  patch -p0 -i ${CACHE_PATH}/libpng-${pkg_version}-apng.patch
  sed -i 's|AM_CONFIG_HEADER|AC_CONFIG_HEADERS|' configure.ac

  libtoolize --force --copy 
  aclocal 
  autoconf 
  automake --add-missing 
  
  ./configure --prefix=/usr 
  make ECHO=echo 
}

do_package() {
  make ECHO=echo DESTDIR=${pkg_prefix} install 

  rm -rf ${pkg_prefix}/usr/share
  rm -rf ${pkg_prefix}/usr/bin/libpng-config
  rm -rf ${pkg_prefix}/usr/lib/{libpng.so,libpng.a}
  rm -fr ${pkg_prefix}/usr/lib/pkgconfig/libpng.pc
  rm -rf ${pkg_prefix}/usr/include/{pngconf.h,png.h}
}
