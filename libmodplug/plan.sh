pkg_origin=cosmos

pkg_name=libmodplug
pkg_version=0.8.9.0
pkg_description="A MOD playing library"
pkg_upstream_url="http://modplug-xmms.sourceforge.net/"
pkg_license=('custom')
pkg_deps=('gcc-libs')
pkg_source=("https://downloads.sourceforge.net/modplug-xmms/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('5ba16981e6515975e9a68a58d5ba69d1')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}

