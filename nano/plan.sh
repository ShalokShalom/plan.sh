pkg_origin=cosmos

pkg_name=nano
pkg_version=2.8.4
_pkg_version=2.8
pkg_description="Pico editor clone with enhancements"
pkg_license=('GPL')
pkg_upstream_url="https://www.nano-editor.org"
pkg_deps=('glibc' 'ncurses' 'sh')
pkg_build_deps=('groff')
pkg_source=("https://www.nano-editor.org/dist/v${_pkg_version}/nano-${pkg_version}.tar.gz")
backup=(etc/nanorc)
pkg_shasum=('e2a6bfc054d1f535b723f93eb73e5f77')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --enable-color \
        --enable-nanorc \
        --enable-multibuffer \
        --disable-wrapping-as-root
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install
  
  install -DTm644 ${CACHE_PATH}/${pkg_name}-${pkg_version}/doc/sample.nanorc ${pkg_prefix}/etc/nanorc
}
