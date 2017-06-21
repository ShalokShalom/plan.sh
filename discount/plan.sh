pkg_origin=

pkg_name=discount
pkg_version=2.2.2
_pkg_version=2.2.2
pkg_description="Markdown text to html language implementation written in C"
pkg_upstream_url="https://www.pell.portland.or.us/~orc/Code/discount/"
pkg_license=('custom:BSD')
pkg_source=("https://www.pell.portland.or.us/~orc/Code/discount/${pkg_name}-${_pkg_version}.tar.bz2"
        'configure.diff')
pkg_shasum=('0531fc428f023942b364c781a948df08'
         '1f93399fa856282e112074d302abfb75')

do_build() {
  cd ${pkg_name}-${_pkg_version}
  patch -p1 -i ${CACHE_PATH}/configure.diff
  
  ./configure.sh --prefix=/usr \
    --enable-all-features \
    --with-fenced-code \
    --shared
  make
}

do_package() {
  cd ${pkg_name}-${_pkg_version}
  make DESTDIR=${pkg_prefix} install.everything
  
  install -Dm644 COPYRIGHT ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
