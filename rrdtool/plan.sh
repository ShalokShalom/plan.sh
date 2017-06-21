pkg_origin=cosmos

pkg_name=rrdtool
pkg_version=1.7.0
pkg_description="Data logging and graphing application"
pkg_upstream_url="http://www.rrdtool.org"
pkg_license=('GPL')
pkg_deps=('libpng' 'libxml2' 'pango' 'ttf-dejavu' 'ruby' 'python2' 'tcl' 'lua' 'perl')
pkg_build_deps=('intltool' 'groff' 'python2-setuptools')
pkg_source=("http://oss.oetiker.ch/rrdtool/pub/rrdtool-${pkg_version}.tar.gz")
pkg_shasum=('2f37eeb613bed11077470c9e2057010e')

do_build() {
  sed -e 's|$(RUBY) extconf.rb|& --vendor|' -i bindings/Makefile.in

  ./configure --prefix=/usr \
    --localstatedir=/var \
    --disable-rpath \
    --enable-perl \
    --enable-perl-site-install \
    --with-perl-options='INSTALLDIRS=vendor' \
    --enable-ruby \
    --enable-ruby-site-install \
    --enable-python \
    --enable-lua \
    --enable-lua-site-install \
    --enable-tcl \
    --disable-libwrap
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} includedir=/usr/include install
  
  install -D -m644 COPYRIGHT ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
