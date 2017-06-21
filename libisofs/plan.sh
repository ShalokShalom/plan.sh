pkg_origin=cosmos

pkg_name=libisofs
pkg_version=1.4.6
pkg_description="Library to create an ISO-9660 filesystem with extensions like RockRidge or Joliet. "
pkg_upstream_url="http://libburnia-project.org"
pkg_license=('GPL')
pkg_deps=('acl' 'zlib')
pkg_source=("http://files.libburnia-project.org/releases/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('6ec515d9265fb75c48e8e73b3ea3f6c5')

do_build() {
  
  ./configure --prefix=/usr \
	--enable-libacl \
	--enable-xattr \
	--disable-static
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}

