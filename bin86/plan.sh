pkg_origin=cosmos

pkg_name=bin86
pkg_version=0.16.21
pkg_description="A complete 8086 assembler and loader"
pkg_license=('GPL')
pkg_upstream_url="http://www.debath.co.uk/"
pkg_deps=('glibc')
pkg_source=("http://v3.sk/~lkundrak/dev86/$pkg_name-$pkg_version.tar.gz"
	'bin86-0.16.17-x86_64-1.patch')
pkg_shasum=('a94f57453500700cebfea86d7d217481'
         '92bdce7b0655cd2e9f83c83fc56d128e')

do_build() {
  cd $pkg_name-$pkg_version
  patch -p1 -i ../bin86-0.16.17-x86_64-1.patch 
  
  make PREFIX=/usr
}

do_package() {
  cd $pkg_name-$pkg_version
  
  mkdir -p $pkg_prefix/usr/bin $pkg_prefix/usr/share/man/man1
  make PREFIX=$pkg_prefix/usr MANDIR=$pkg_prefix/usr/share/man/man1 install
}
