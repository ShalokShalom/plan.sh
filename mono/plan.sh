pkg_origin=cosmos

pkg_name=mono
pkg_version=4.8.0
_pkg_version=4.8.0.524
pkg_description="Free implementation of the .NET platform including runtime and compiler"
pkg_license=('GPL' 'LGPL2' 'MPL' 'custom:MITX11')
pkg_upstream_url="https://www.mono-project.com/"
pkg_deps=('zlib' 'libgdiplus' 'sh' 'python3')
pkg_build_deps=('pkgconfig')
pkg_source=("https://download.mono-project.com/sources/mono/${pkg_name}-${_pkg_version}.tar.bz2"
        'mono.binfmt.d')
pkg_shasum=('baeed5b8139a85ad7e291d402a4bcccb'
         '568c72e1b42f089a9fec20dfe4bcc3b4')

do_build() {

  ./configure --prefix=/usr \
         --sysconfdir=/etc \
         --bindir=/usr/bin \
         --disable-quiet-build \
         --disable-system-aot \
         --with-mcs-docs=no
  make 

  make 
}

do_package() {
  make DESTDIR=${pkg_prefix} install 

  make DESTDIR=${pkg_prefix} prefix=/usr INSTALL=../../install-sh install

  install -D -m644 ${CACHE_PATH}/mono.binfmt.d ${pkg_prefix}/usr/lib/binfmt.d/mono.conf

  mkdir -p ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/
  
  sed -i -e "s|#Requires|Requires|" ${pkg_prefix}/usr/lib/pkgconfig/mono.pc
}
