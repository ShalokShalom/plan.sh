pkg_origin=cosmos

pkg_name=libndp
pkg_version=1.6
pkg_description="Library providing a wrapper Neighbor Discovery Protocol plus ndptool for sending and receiving NDP messages."
pkg_upstream_url="http://libndp.org/"
pkg_license=('LGPL2.1')
pkg_deps=('glibc')
pkg_source=("http://libndp.org/files/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('1e54d26bcb4a4110bc3f90c5dd04f1a7')

do_build() {
  
  ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --localstatedir=/var \
        --disable-static \
        --libexecdir=/usr/lib
  make
}

check() {
  
  make check
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
