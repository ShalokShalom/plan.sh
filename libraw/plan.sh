pkg_origin=cosmos

pkg_name=libraw
pkg_version=0.18.2
pkg_description="Library for reading RAW files obtained from digital photo cameras (CRW/CR2, NEF, RAF, DNG, and others)."
pkg_upstream_url="http://www.libraw.org/"
pkg_license=('CDDL' 'LGPL')
pkg_deps=('lcms2' 'jasper')
pkg_source=("http://www.libraw.org/data/LibRaw-${pkg_version}.tar.gz")
pkg_shasum=('7bd923ea7c9cc71897b005be46c01b2b')

do_build() {

  ./configure --prefix=/usr
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
  install -D -m644 LICENSE.LGPL ${pkg_prefix}/usr/share/licenses/libraw/LICENSE.LGPL
}
