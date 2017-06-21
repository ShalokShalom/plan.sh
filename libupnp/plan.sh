pkg_origin=cosmos

pkg_name=libupnp
pkg_version=1.6.22
pkg_description="Portable UPnP development kit."
pkg_upstream_url="https://github.com/mrjimenez/pupnp"
pkg_license=('BSD')
pkg_deps=('glibc')
pkg_source=("https://sourceforge.net/projects/pupnp/files/pupnp/libUPnP%20${pkg_version}/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('530e91e96119ee32a9523a73572b8d8f')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -Dm644 LICENSE ${pkg_prefix}/usr/share/licenses/custom/${pkg_name}/LICENSE
}
