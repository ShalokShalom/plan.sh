pkg_origin=cosmos

pkg_name=libcaca
pkg_version=0.99.beta19
pkg_description="Color AsCii Art library"
pkg_license=('LGPL')
pkg_upstream_url="https://github.com/cacalabs/libcaca"
pkg_deps=('imlib2' 'ncurses')
pkg_source=("http://libcaca.zoy.org/files/libcaca/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('a3d4441cdef488099f4a92f4c6c1da00')

do_build() {
  
  ./configure --prefix=/usr \
        --mandir=/usr/share/man \
        --enable-shared \
        --disable-doc \
        --disable-cxx \
        --disable-gl \
        --disable-csharp
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
