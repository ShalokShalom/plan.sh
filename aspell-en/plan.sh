pkg_origin=cosmos

pkg_name=aspell-en
pkg_version=2017.01.22
pkg_description="English dictionary for aspell"
pkg_upstream_url="http://aspell.net/"
pkg_license=('custom')
pkg_deps=('aspell')
pkg_source=("https://ftp.gnu.org/gnu/aspell/dict/en/aspell6-en-${pkg_version}-0.tar.bz2")
pkg_shasum=('a6e002076574de9dc4915967032a1dab')                                                                                            

do_build() {
  
  ./configure 
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 Copyright ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
