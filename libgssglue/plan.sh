pkg_origin=cosmos

pkg_name=libgssglue
pkg_version=0.4
pkg_description="Exports a gssapi interface which calls other random gssapi libraries"
pkg_upstream_url="http://www.citi.umich.edu/projects/nfsv4/linux/"
pkg_license=('BSD')
pkg_deps=('glibc')
pkg_build_deps=('pkgconfig' 'autoconf')
backup=(etc/gssapi_mech.conf)
pkg_source=("http://www.citi.umich.edu/projects/nfsv4/linux/libgssglue/$pkg_name-$pkg_version.tar.gz"
        'gssapi_mech.conf')
pkg_shasum=('088797f3180702fa54e786496b32e750'
         '080be866717e4e06fa6f7d6f43cb395a')

do_build() {
  cd $pkg_name-$pkg_version
  
  ./configure --prefix=/usr 
  make
}

do_package() {
  cd $pkg_name-$pkg_version
  make DESTDIR=$pkg_prefix/ install

  install -Dm644 $CACHE_PATH/gssapi_mech.conf $pkg_prefix/etc/gssapi_mech.conf
  install -Dm644 COPYING $pkg_prefix/usr/share/licenses/libgssglue/COPYING
}
