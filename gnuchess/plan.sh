pkg_origin=

pkg_name=gnuchess
pkg_version=6.2.4
pkg_description="Program to play chess against the computer on a terminal or, as a chess engine for graphical chess frontends such as knights"
pkg_upstream_url="https://www.gnu.org/software/chess/chess.html"
pkg_license=('GPL')
pkg_deps=('glibc' 'ncurses' 'readline')
pkg_source=("https://ftp.gnu.org/pub/gnu/chess/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('4e1268030ba1ae83cbd03b3eac2f44a5')

do_build() {
  cd ${pkg_name}-${pkg_version}

  ./configure --prefix=/usr

  make  
}

do_package() {
  cd ${pkg_name}-${pkg_version}

  make prefix=${pkg_prefix}/usr install
}
