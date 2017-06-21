pkg_origin=cosmos

pkg_name=tdb
pkg_version=1.3.13
pkg_description="Trivial Database similar to GDBM but allows simultaneous commits"
pkg_license=('GPL3')
pkg_upstream_url="https://tdb.samba.org/"
pkg_build_deps=('python2' 'libxslt' 'docbook-xsl')
optpkg_deps=('python2: for python bindings')
pkg_source=("https://samba.org/ftp/tdb/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('75567d47771a1285c58eecd545e24232')

do_build() {
   
   ./configure --prefix=/usr \
               --localstatedir=/var \
               --sysconfdir=/etc/samba
   make
}

do_package() {
   
   make DESTDIR=$CACHE_PATH/ install
}


