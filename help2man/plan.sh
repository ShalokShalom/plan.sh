pkg_origin=cosmos

pkg_name=help2man
pkg_version=1.47.4
pkg_description="Conversion tool to create man files"
pkg_upstream_url="http://www.gnu.org/software/help2man/"
pkg_license=('GPL')
pkg_deps=('perl-locale-gettext')
pkg_source=("http://ftp.gnu.org/gnu/help2man/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('544aca496a7d89de3e5d99e56a2f03d3')

do_build() {
  cd ${pkg_name}-${pkg_version}

  ./configure --prefix=/usr \
              --mandir=/usr/share/man \
	      --infodir=/usr/share/info \
	      --libdir=/usr/lib
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}

  make DESTDIR=${pkg_prefix} install
}
