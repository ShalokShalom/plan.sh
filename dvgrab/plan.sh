pkg_origin=cosmos

pkg_name=dvgrab
pkg_version=3.5
pkg_description="Saves audio and video data from an IEEE (FireWire) digital source"
pkg_upstream_url="http://www.kinodv.org"
pkg_license=('GPL')
pkg_deps=('libdv' 'libavc1394' 'libjpeg-turbo' 'libiec61883' 'gcc-libs')
pkg_build_deps=('pkgconfig')
pkg_source=("http://sourceforge.net/projects/kino/files/dvgrab/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('b39a242ce63e80fc347ab59931f75649')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
