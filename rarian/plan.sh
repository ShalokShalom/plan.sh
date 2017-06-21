pkg_origin=cosmos

pkg_name=rarian
pkg_version=0.8.1
pkg_description="Documentation meta-data library, designed as a replacement for Scrollkeeper."
pkg_upstream_url="http://rarian.freedesktop.org/"
pkg_license=('GPL')
pkg_deps=('gcc-libs')
pkg_build_deps=('libxslt')
pkg_source=("http://rarian.freedesktop.org/Releases/${pkg_name}-${pkg_version}.tar.bz2"
        'user-segfault.patch')
pkg_shasum=('75091185e13da67a0ff4279de1757b94'
         '457e9827197009cfa360911fe49a5ad7')

do_build() {
  patch -p0 -i ${CACHE_PATH}/user-segfault.patch
  
  ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --localstatedir=/var \
        --disable-static
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}
