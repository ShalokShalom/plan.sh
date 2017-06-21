pkg_origin=cosmos

pkg_name=progsreiserfs
pkg_version=0.3.0.5
pkg_description="library for accessing and manipulating reiserfs partitions"
pkg_upstream_url="http://reiserfs.linux.kiev.ua/"
pkg_license=('GPL')
pkg_deps=('e2fsprogs')
pkg_source=("https://www.mirrorservice.org/sites/download.salixos.org/i486/13.37/source/l/progsreiserfs/${pkg_name}-${pkg_version}.tar.gz"
        'fix-underquoted-definition.patch')
pkg_shasum=('d822579bbd4a29a1be5e4490869d9bee'
         '0ff24db039edbcc574f59075340b003a')

do_build() {
  patch -p1 -i ${CACHE_PATH}/fix-underquoted-definition.patch

  ./configure --prefix=/usr \
              --mandir=/usr/share/man

  make
}

do_package() {
  make install DESTDIR=${pkg_prefix}
  
  # progsreiserfs has been proven dangerous in the past, generating bad partitions and destroying
  # data on resize/cpfs operations, ship only libraries
  rm -r ${pkg_prefix}/usr/sbin
  rm -r ${pkg_prefix}/usr/share/man
}

