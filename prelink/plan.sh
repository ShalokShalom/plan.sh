pkg_origin=

pkg_name=prelink
pkg_version=20130503
pkg_description='ELF prelinking utility to speed up dynamic linking'
pkg_upstream_url='http://people.redhat.com/jakub/prelink/'
pkg_license=('GPL')
pkg_deps=('elfutils')
backup=('etc/prelink.conf')
pkg_source=("http://people.redhat.com/jakub/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2"
        'prelink.conf')
pkg_shasum=('4cab1571718a9b25665bd025069a02c7'
         '5302bde3442792bd792d7d264976443c')

do_build() {
  cd ${pkg_name}

  ./configure --prefix=/usr --mandir=/usr/share/man 
  make
}

do_package() {
  make -C ${pkg_name} DESTDIR=${pkg_prefix} install

  install -Dm644 prelink.conf ${pkg_prefix}/etc/prelink.conf
}
