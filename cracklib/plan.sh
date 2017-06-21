pkg_origin=cosmos

pkg_name=cracklib
pkg_version=2.9.4
pkg_description="Password Checking Library"
pkg_license=('GPL')
pkg_upstream_url="http://sourceforge.net/projects/cracklib"
pkg_deps=('glibc' 'zlib')
pkg_source=("http://downloads.sourceforge.net/sourceforge/cracklib/$pkg_name-$pkg_version.tar.gz")
pkg_shasum=('b31f7e3618cda7a2ac38588067275013')

do_build() {
  cd $startdir/src/$pkg_name-$pkg_version
  
  ./configure --prefix=/usr --without-python
  make 
}

do_check() {
  cd $CACHE_PATH/$pkg_name-$pkg_version
  
  make check
}

do_package() {
  cd $startdir/src/$pkg_name-$pkg_version
  make DESTDIR=$pkg_prefix install
  
  install -Dm644 dicts/cracklib-small $pkg_prefix/usr/share/dict/cracklib-small
  sh ./util/cracklib-format dicts/cracklib-small \
    | sh ./util/cracklib-packer $pkg_prefix/usr/share/cracklib/pw_dict
}

