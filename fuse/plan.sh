pkg_origin=cosmos

pkg_name=fuse
pkg_version=2.9.7
pkg_description="A library that makes it possible to implement a filesystem in a userspace program."
pkg_upstream_url="https://github.com/libfuse/libfuse"
pkg_license="GPL2"
pkg_deps=('glibc')
pkg_build_deps=('pkgconfig')
backup=('etc/fuse.conf')
pkg_source=("https://github.com/libfuse/libfuse/releases/download/fuse-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
        'fuse.conf')
pkg_shasum=('9bd4ce8184745fd3d000ca2692adacdb'
         'c9457cf5b2196da67d5ac816d1c86a4f')

do_build() {

  ./configure --prefix=/usr \
        --libdir=/usr/lib \
        --enable-lib \
        --enable-util \
        --bindir=/bin

  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install 
  
  install -D -m644 ../fuse.conf ${pkg_prefix}/etc/fuse.conf

  rm -rf ${pkg_prefix}/dev
  # Remove init script
  rm -rf ${pkg_prefix}/etc/init.d
  # remove duplicate udev rules
  rm -rf ${pkg_prefix}/etc/udev
}

