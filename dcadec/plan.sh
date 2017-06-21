pkg_origin=cosmos
 
pkg_name=dcadec
pkg_version=0.2.0
pkg_description='Free DTS Coherent Acoustics decoder with support for HD extensions'
pkg_upstream_url='https://github.com/foo86/dcadec.git'
pkg_license=('LGPLv2.1')
pkg_deps=('glibc')
pkg_source=("https://github.com/foo86/dcadec/archive/v${pkg_version}.tar.gz")
pkg_shasum=('14005424ad2ee56ce3d33b921ef749cb')

do_build() {
  export CONFIG_SHARED='TRUE'

  make
}

do_package() {
  export CONFIG_SHARED='TRUE'
  export PREFIX='/usr'

  make DESTDIR=${pkg_prefix} install
  
  # avoid conflict with libdca
  mv ${pkg_prefix}/usr/bin/dcadec{,-dts}
}
