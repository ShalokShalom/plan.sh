pkg_origin=cosmos

pkg_name=dialog
pkg_version=1.3_20170509
_pkg_version=1.3-20170509
epoch=1
pkg_description="A tool to display dialog boxes from shell scripts"
pkg_upstream_url="http://invisible-island.net/dialog/"
pkg_license=('LGPL2.1')
pkg_deps=('ncurses' 'sh')
# version at http://invisible-island.net/dialog/CHANGES.html
pkg_source=("ftp://invisible-island.net/dialog/${pkg_name}-${_pkg_version}.tgz")
pkg_shasum=('b2740641d911402f0debd2e84f05b1ee')

do_build() {
  cd ${pkg_name}-${_pkg_version}
  
  ./configure --prefix=/usr \
    --mandir=/usr/share/man \
    --with-ncursesw \
    --enable-nls
  make 
}

do_package() {
  cd ${pkg_name}-${_pkg_version}
  
  make DESTDIR=${pkg_prefix} install install-lib
}
