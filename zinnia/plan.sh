pkg_origin=

pkg_name=zinnia
pkg_version=0.06
pkg_description="Simple and portable open source handwriting recognition system based on Support Vector Machines"
pkg_upstream_url="http://zinnia.sourceforge.net/"
pkg_license=('BSD')
pkg_build_deps=('libtool')
pkg_source=("http://sourceforge.net/projects/zinnia/files/zinnia/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('5ed6213e2b879465783087a0cf6d5fa0')

do_build() {
  cd ${pkg_name}-${pkg_version}

  ./configure --prefix=/usr
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install

  install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
