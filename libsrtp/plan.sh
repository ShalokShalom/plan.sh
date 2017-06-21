pkg_origin=cosmos

pkg_name=libsrtp
pkg_version=1.5.4
pkg_description="Open-source implementation of the Secure Real-time Transport Protocol (SRTP)"
pkg_upstream_url="https://github.com/cisco/libsrtp"
pkg_license=('BSD')
pkg_deps=('glibc')
pkg_build_deps=('git')
pkg_source=("https://github.com/cisco/libsrtp/archive/v${pkg_version}.tar.gz")
pkg_shasum=('64a9580f86a9c3e1c4986e944e6a5a84')

do_build() {
  
  ./configure --prefix=/usr \
      --exec-prefix=/usr \
      --sysconfdir=/etc \
      --localstatedir=/var \
      --enable-openssl
  make shared_library
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -Dm0644 LICENSE "${pkg_prefix}"/usr/share/licenses/${pkg_name}/LICENSE
}
