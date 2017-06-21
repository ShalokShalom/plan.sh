pkg_origin=cosmos

pkg_name=libqmi
pkg_version=1.18.0
pkg_description="QMI modem protocol helper library"
pkg_upstream_url="https://cgit.freedesktop.org/libqmi"
pkg_license=('GPL2')
pkg_deps=('glib2' 'bash' 'libgudev')
pkg_build_deps=('python2' 'help2man')
pkg_source=("https://www.freedesktop.org/software/libqmi/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('25bae4e383ad77f491ad49b49e04fdcf')

do_build() {

  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --disable-static \
    --libexecdir=/usr/lib
  make
}

check() {
  # one test fails since glib2 2.52.2
  make check
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
