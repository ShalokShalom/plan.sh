pkg_origin=cosmos

pkg_name=vi
pkg_version=050325
pkg_description='The original ex/vi text editor.'
pkg_upstream_url='http://ex-vi.sourceforge.net/'
pkg_license=('custom:ex')
pkg_deps=('ncurses')
pkg_source=("http://downloads.sourceforge.net/sourceforge/ex-vi/ex-${pkg_version}.tar.bz2"
        'navkeys.patch'
        'increase-tube.patch'
        'exrc.sample' 
        'preserve_dir.patch')
pkg_shasum=('e668595254233e4d96811083a3e4e2f3'
         'aac133930047eafa4f28736cfaf976b3'
         'e596e05a00a24187b576e389fa1de45d'
         'd3b483c994d859232ce369b82a4b5668'
         '419a8755e0dd16e95542bc107e6d2b24')

do_build() {
  cd "${CACHE_PATH}/ex-${pkg_version}"

  patch -p1 -i ${CACHE_PATH}/navkeys.patch
  patch -p0 -i ${CACHE_PATH}/increase-tube.patch
  patch -p1 -i ${CACHE_PATH}/preserve_dir.patch

  make PREFIX=/usr LIBEXECDIR=/usr/lib/ex PRESERVEDIR=/var/lib/ex \
      'FEATURES=-DCHDIR -DFASTTAG -DUCVISUAL -DMB -DBIT8' TERMLIB=ncurses
}

do_package() {
  cd "${CACHE_PATH}/ex-${pkg_version}"

  make PREFIX=/usr LIBEXECDIR=/usr/lib/ex PRESERVEDIR=/var/lib/ex INSTALL=/usr/bin/install \
      DESTDIR="$pkg_prefix" install

  install -D -m644 LICENSE "${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE"
}
