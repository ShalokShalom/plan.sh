pkg_origin=cosmos

pkg_name=cdparanoia
pkg_version=10.2
pkg_description="Compact Disc Digital Audio extraction tool"
pkg_upstream_url="http://www.xiph.org/paranoia/"
pkg_license=('GPL')
pkg_deps=('glibc')
pkg_source=("http://downloads.xiph.org/releases/cdparanoia/cdparanoia-III-${pkg_version}.src.tgz"
        'gcc.patch')
pkg_shasum=('b304bbe8ab63373924a744eac9ebc652'
         '12da14958d2b84c6719fe69890436445')

do_build() {
  patch -p0 -i ${CACHE_PATH}/gcc.patch
  
  ./configure --prefix=/usr --mandir=/usr/share/man
  make
}

do_package() {
  
  make prefix=${pkg_prefix}/usr MANDIR=${pkg_prefix}/usr/share/man install
}
