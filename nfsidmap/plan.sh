pkg_origin=cosmos

pkg_name=nfsidmap
pkg_version=0.26
_pkg_version=0-26
pkg_description="Library to help mapping IDs, mainly for NFSv4"
pkg_upstream_url="http://www.citi.umich.edu/projects/nfsv4/linux/"
pkg_deps=('glibc' 'libldap')
pkg_license=('custom:nfsidmap')
pkg_source=("https://github.com/Distrotech/libnfsidmap/archive/libnfsidmap-$_pkg_version.tar.gz")
pkg_shasum=('cf1241a2a4a34029e0162810dff83e6c')

do_build() {
  cd $CACHE_PATH/libnfsidmap-libnfsidmap-$_pkg_version
  
  ./autogen.sh
  ./configure --prefix=/usr --sysconfdir=/etc
  make
}

do_package() {
  cd $CACHE_PATH/libnfsidmap-libnfsidmap-$_pkg_version
  make DESTDIR=$pkg_prefix install

  install -Dm644 COPYING $pkg_prefix/usr/share/licenses/nfsidmap/LICENSE
}

