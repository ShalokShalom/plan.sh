pkg_origin=cosmos

pkg_name=libmpeg2
pkg_version=0.5.1
pkg_description="libmpeg2 is a library for decoding MPEG-1 and MPEG-2 video streams."
pkg_upstream_url="http://libmpeg2.sourceforge.net/"
pkg_license=('GPL2')
pkg_deps=('glibc' 'sdl' 'libxv')
pkg_source=("http://libmpeg2.sourceforge.net/files/${pkg_name}-${pkg_version}.tar.gz"
        'gcc.patch')
pkg_shasum=('0f92c7454e58379b4a5a378485bbd8ef'
         '062c4913e528c4e83e3ac3d284ff8bcb')

do_build() {
  patch -p1 -i "${CACHE_PATH}/gcc.patch"
  
  sed '/AC_PATH_XTRA/d' -i configure.ac
  autoreconf --force --install
  
  ./configure --prefix=/usr --enable-shared --disable-static
  make	OPT_CFLAGS="${CFLAGS}" \
	MPEG2DEC_CFLAGS="${CFLAGS}" \
	LIBMPEG2_CFLAGS=""
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
