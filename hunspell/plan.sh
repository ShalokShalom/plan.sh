pkg_origin=cosmos

pkg_name=hunspell
pkg_version=1.6.1
pkg_description="Spell checker and morphological analyzer library and program"
pkg_upstream_url="http://hunspell.github.io/"
pkg_license=('GPL' 'LGPL' 'MPL')
pkg_deps=('gcc-libs' 'readline')
pkg_deps=('perl')
pkg_source=("https://github.com/hunspell/hunspell/archive/v${pkg_version}.tar.gz")
pkg_shasum=('0df1c18c1284f8625af5ae5a8d5c4cef')

do_build() {
  
  autoreconf -vfi   #;  automake --add-missing
  ./configure --prefix=/usr \
        --disable-static \
        --with-ui \
        --with-readline 
        #--with-experimental
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
