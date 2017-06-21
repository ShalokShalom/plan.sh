pkg_origin=cosmos

pkg_name=talloc
pkg_version=2.1.9
pkg_description="A hierarchical pool based memory allocator with destructors"
pkg_license=('GPL3')
pkg_upstream_url="http://tdb.samba.org/"
pkg_deps=('glibc' 'python2')
pkg_build_deps=('docbook-xsl')
pkg_source=("http://samba.org/ftp/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('19ba14eba97d79a169fa92ea824d2b9e')

do_build() {
   
   ./configure --prefix=/usr \
   --sysconfdir=/etc/samba \
   --localstatedir=/var \
   --enable-talloc-compat1
   make
}

do_package() {
   
   make DESTDIR=${CACHE_PATH}/ install
}
