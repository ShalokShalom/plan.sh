pkg_origin=cosmos

pkg_name=lzo2
pkg_version=2.10
pkg_description="Portable lossless data compression library"
pkg_upstream_url="http://www.oberhumer.com/opensource/lzo"
pkg_license=('GPL')
pkg_deps=('glibc')
pkg_source=("http://www.oberhumer.com/opensource/lzo/download/lzo-${pkg_version}.tar.gz")
pkg_shasum=('39d3f3f9c55c87b1e5d6888e1420f4b5')

do_build() {
  cd lzo-${pkg_version}

  ./configure --prefix=/usr --enable-shared
  make

  # minilzo
  gcc $CFLAGS -fpic -Iinclude/lzo -o minilzo/minilzo.o -c minilzo/minilzo.c
  gcc -g -shared -o libminilzo.so.0 -Wl,-soname,libminilzo.so.0 minilzo/minilzo.o
}

do_check() {
  cd lzo-${pkg_version}
  
  make test 
  make check
}

do_package() {
  cd lzo-${pkg_version}
  make DESTDIR=${pkg_prefix} install

  # minilzo
  install -m 755 libminilzo.so.0 ${pkg_prefix}/usr/lib
  install -p -m 644 minilzo/minilzo.h ${pkg_prefix}/usr/include/lzo
  cd ${pkg_prefix}/usr/lib
  ln -s libminilzo.so.0 libminilzo.so
}
