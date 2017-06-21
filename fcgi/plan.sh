pkg_origin=cosmos

pkg_name=fcgi
pkg_version=2.4.0
#_pkg_version=2.4.1-SNAP-03111112127
pkg_deps=('gcc-libs')
pkg_description="FASTCgi (fcgi) is a language independent, high performant extension to CGI"
pkg_license=('custom')
pkg_upstream_url="http://www.fastcgi.com"
pkg_source=("https://sourceforge.net/projects/slackbuildsdirectlinks/files/fcgi/${pkg_name}-${pkg_version}.tar.gz"
        'gcc44-fix-include.patch'
        '2.4.0build.patch')
pkg_shasum=('d15060a813b91383a9f3c66faf84867e'
         'a8028462163755f3ce457a5c641f237b'
         '1e6f791c530c41aaa9994364fbc94a3c')

prepare() {
  patch -p1 -i ${CACHE_PATH}/gcc44-fix-include.patch
  patch -p1 -i ${CACHE_PATH}/2.4.0build.patch
  
  libtoolize --force --automake --copy
  aclocal
  autoheader
  automake --copy --add-missing --force-missing
  autoconf
}

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 LICENSE.TERMS ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
