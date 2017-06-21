pkg_origin=

pkg_name=guile1.8
pkg_version=1.8.8
pkg_description='Portable, embeddable Scheme implementation written in C. Legacy branch.'
pkg_upstream_url="https://www.gnu.org/software/guile/"
pkg_license=('GPL')
pkg_deps=('gmp' 'libltdl' 'ncurses' 'texinfo')
pkg_source=("https://ftp.gnu.org/pub/gnu/guile/guile-${pkg_version}.tar.gz")
pkg_shasum=('18661a8fdfef13e2fcb7651720aa53f3')

do_build() {
  cd guile-${pkg_version}
  ./configure --prefix=/usr \
	--disable-static  \
	--disable-error-on-warning \
        --program-suffix=1.8
  make LDFLAGS+="-lpthread"
}

do_package() {
  cd guile-${pkg_version}
  make DESTDIR=${pkg_prefix} install
  
  rm -rf ${pkg_prefix}/usr/share/info
  sed -i '1s/guile/guile1.8/' -i ${pkg_prefix}/usr/bin/guile-config1.8
  mv ${pkg_prefix}/usr/share/aclocal/guile.m4 ${pkg_prefix}/usr/share/aclocal/guile18.m4
}
