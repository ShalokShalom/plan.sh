pkg_origin=

pkg_name=aria2
pkg_version=1.32.0
pkg_description='Download utility that supports HTTP(S), FTP, BitTorrent, and Metalink'
pkg_upstream_url='https://aria2.github.io/'
pkg_license=('GPL')
pkg_deps=('gnutls' 'libxml2' 'sqlite' 'c-ares' 'ca-certificates')
pkg_source=("https://github.com/aria2/aria2/releases/download/release-${pkg_version}/aria2-${pkg_version}.tar.xz")
pkg_shasum=('3fb0a001c948d9f36650774662b6f50a')

do_build() {
  cd ${pkg_name}-${pkg_version}

  ./configure \
    --prefix=/usr \
    --with-ca-bundle=/etc/ssl/certs/ca-certificates.crt

  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install

  install -d ${pkg_prefix}/usr/share/bash-completion/completions
  install -m644 ${pkg_prefix}/usr/share/doc/aria2/bash_completion/aria2c \
    ${pkg_prefix}/usr/share/bash-completion/completions
  rm -rf ${pkg_prefix}/usr/share/doc/aria2/bash_completion
}
