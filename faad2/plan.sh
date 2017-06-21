pkg_origin=cosmos

pkg_name=faad2
pkg_version=2.7
pkg_description="ISO AAC audio decoder"
pkg_upstream_url="http://www.audiocoding.com/"
pkg_license=('custom:GPL')
pkg_deps=('glibc')
pkg_source=("http://downloads.sourceforge.net/sourceforge/faac/${pkg_name}-${pkg_version}.tar.bz2"
        'LICENSE')
pkg_shasum=('4c332fa23febc0e4648064685a3d4332'
         'ec95f38142e14fb46c849503897a37a0')

do_build() {
  
  ./configure --prefix=/usr
  make CFLAGS="${CFLAGS} -fPIC"
}

do_package() {
  make DESTDIR=${pkg_prefix} manmdir=/usr/share/man/man1 install
  
  install -m644 common/mp4ff/mp4ff_int_types.h ${pkg_prefix}/usr/include/mp4ff_int_types.h
  install -D -m644 ${CACHE_PATH}/LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
  mv ${pkg_prefix}/usr/share/man/man1/faad.man ${pkg_prefix}/usr/share/man/man1/faad.1
}
