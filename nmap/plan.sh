pkg_origin=cosmos

pkg_name=nmap
pkg_version=7.50
pkg_description="Network exploration tool and security/port scanner"
pkg_upstream_url="https://nmap.org"
pkg_license=('GPL2')
pkg_deps=('pcre' 'openssl' 'libpcap>=1.0.0' 'lua')
pkg_build_deps=('python2')
pkg_source=("https://nmap.org/dist/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('435c7e095bdd4565e0f69c41743a45be')

do_build() {

  ./configure --prefix=/usr --mandir=/usr/share/man --libexecdir=/usr/lib --without-gui
  make
}

do_package() {
  make DESTDIR="${pkg_prefix}" install

  # remove zenmap uninstall script
  rm ${pkg_prefix}/usr/bin/uninstall_zenmap
  # zenmap needs gtk
  rm ${pkg_prefix}/usr/share/applications/zenmap-root.desktop
  rm ${pkg_prefix}/usr/share/applications/zenmap.desktop

  install -D -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}

