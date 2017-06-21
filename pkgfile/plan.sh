pkg_origin=cosmos

pkg_name=pkgfile
pkg_version=17
pkg_description="An alpm .files metadata explorer"
pkg_upstream_url="http://github.com/falconindy/pkgfile"
pkg_license=('MIT')
pkg_deps=('libarchive' 'curl' 'pcre' 'pacman')
install=pkgfile.install
pkg_source=("https://pkgbuild.com/~dreisner/sources/pkgfile/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('c0ced1f0972891b41c9d84abcbf6bc1f')

do_build() {

  ./configure --with-systemdsystemunitdir=/usr/lib/systemd/system
  make

  # generate a license file
  sed '/\*\//q' src/pkgfile.c >LICENSE
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}

