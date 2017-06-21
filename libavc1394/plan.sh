pkg_origin=cosmos

pkg_name=libavc1394
pkg_version=0.5.4
pkg_description="A library to control A/V devices using the 1394ta AV/C commands."
pkg_upstream_url="http://sourceforge.net/projects/libavc1394/"
pkg_license=('LGPL')
pkg_deps=('libraw1394')
pkg_source=("https://downloads.sourceforge.net/sourceforge/libavc1394/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('caf0db059d8b8d35d6f08e6c0e1c7dfe')

do_build() {

  ./configure --prefix=/usr --mandir=/usr/share/man 
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install 
}
