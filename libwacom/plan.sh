pkg_origin=cosmos
 
pkg_name=libwacom
pkg_version=0.25
pkg_description="Library that provides applications with a way to get information about any tablets that are currently connected."
pkg_upstream_url="http://linuxwacom.sourceforge.net/wiki/index.php/Libwacom"
pkg_license=('GPLv2')
pkg_deps=('glib2' 'libgudev')
pkg_source=("https://sourceforge.net/projects/linuxwacom/files/libwacom/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('47ce63c65d74a5730fbf6ff3cea6d821')

do_build() {
  
  ./configure --prefix=/usr
  make
}

check() {
  
  make check
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
  
  # adding rules as per https://sourceforge.net/p/linuxwacom/libwacom/ci/master/tree/README
  install -m755 -d ${pkg_prefix}/usr/lib/udev/rules.d
  ./generate-udev-rules > ${pkg_prefix}/usr/lib/udev/rules.d/65-libwacom.rules
  
}
