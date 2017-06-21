pkg_origin=cosmos
 
pkg_name=bubblewrap
pkg_version=0.1.8
pkg_description='Core execution engine for unprivileged containers that works as a setuid binary on kernels without
user namespaces.'
pkg_upstream_url='https://github.com/projectatomic/bubblewrap'
pkg_license=('LGPLv2')
pkg_deps=('libcap')
pkg_build_deps=('libxslt')
pkg_source=("https://github.com/projectatomic/bubblewrap/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('b94c0fd774cdb61a548776807300de65')

do_build() {
  
  ./configure --prefix=/usr \
    --with-priv-mode=setuid
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
