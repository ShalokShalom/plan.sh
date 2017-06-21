pkg_origin=cosmos

pkg_name=bridge-utils
pkg_version=1.6
pkg_description="EEE 802.1d ethernet bridging (plus Spanning Tree protocol) for the linux kernel."
pkg_upstream_url="http://www.linuxfoundation.org/collaborate/workgroups/networking/bridge"
pkg_license=('GPL')
pkg_deps=('glibc' 'iptables')
pkg_source=("https://www.kernel.org/pub/linux/utils/net/bridge-utils/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('541ae1c50cc268056693608920e6c908')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  aclocal
  autoconf
  ./configure --prefix=/usr \
      --sbindir=/usr/bin \
      --sysconfdir=/etc
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
}
