pkg_origin=cosmos

pkg_name=libvdpau
pkg_version=1.1.1
pkg_description="Nvidia VDPAU library"
pkg_upstream_url="http://cgit.freedesktop.org/~aplattner/libvdpau"
pkg_deps=('gcc-libs' 'libxext')
pkg_build_deps=('dri2proto')
pkg_license=('custom')
pkg_source=("http://people.freedesktop.org/~aplattner/vdpau/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('ac8b21012035c04fd1ec8a9ae6934264')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install 

  install -d -m755 ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/ 
}
