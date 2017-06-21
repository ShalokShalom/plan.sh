pkg_origin=cosmos

pkg_name=pinentry
pkg_version=1.0.0
pkg_description="Collection of dialog programs that allow GnuPG to read passphrases and PIN numbers in a secure manner. "
pkg_license=('GPL')
pkg_upstream_url="https://www.gnupg.org/related_software/pinentry/"
pkg_deps=('ncurses' 'libcap')
pkg_build_deps=('qt5-base')
pkg_deps=('qt5-base: for qt backend')  
pkg_source=("ftp://ftp.gnupg.org/gcrypt/pinentry/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('4a3fad8b31f9b4c5526c8837495015dc')

do_build() {
  
  #CXXFLAGS="-std=c++11"
  
  ./configure --prefix=/usr \
	--enable-pinentry-curses \
	--disable-pinentry-gtk2 \
	--enable-fallback-curses \
	--disable-ncurses
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}

