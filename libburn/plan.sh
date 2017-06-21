pkg_origin=cosmos

pkg_name=libburn
pkg_version=1.4.6
_pkg_version=1.4.6
pkg_description="Library by which preformatted data get onto optical media: CD, DVD, BD (Blu-Ray)."
pkg_upstream_url="https://dev.lovelyhq.com/libburnia/web/wikis/Libburn"
pkg_license=('GPL')
pkg_deps=('glibc')
pkg_source=("http://files.libburnia-project.org/releases/${pkg_name}-${_pkg_version}.tar.gz")
pkg_shasum=('eeab90dfd8b6ae95748a64009b02e4ec')

do_build() {
  
  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}

