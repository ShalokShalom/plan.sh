pkg_origin=cosmos

pkg_name=tomoyo-tools
_basever=2.5.0
_timestamp=20170102
_file=53357
pkg_version=${_basever}.${_timestamp}
pkg_description='TOMOYO Linux 2.5.x userspace tools for Linux kernel 3.2 and above'
pkg_upstream_url='http://tomoyo.sourceforge.jp'
pkg_license=('GPL')
pkg_deps=('ncurses' 'linux>=4.11')
pkg_build_deps=('help2man')
install=tomoyo-tools.install
pkg_source=("http://sourceforge.jp/frs/redir.php?f=/tomoyo/${_file}/${pkg_name}-${_basever}-${_timestamp}.tar.gz")
pkg_shasum=('888804d58742452fe213a68f7eadd0ad')

do_build() {
    
    make -j1
}

do_package() {
    
    make INSTALLDIR="${CACHE_PATH}" install
}
