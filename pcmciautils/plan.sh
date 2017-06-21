pkg_origin=cosmos

pkg_name=pcmciautils
pkg_version=018
pkg_description="Utilities for inserting and removing PCMCIA cards"
pkg_upstream_url="http://kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html"
pkg_license=('GPL')
pkg_deps=('sysfsutils' 'systemd')
pkg_source=("http://ftp.de.debian.org/debian/pool/main/p/${pkg_name}/${pkg_name}_${pkg_version}.orig.tar.gz"
        'initcpio-install-pcmcia')
pkg_shasum=('3c388cb559975b37a75cb5965e9800a9'
         '0dd0544b346d478f2bed35c1a91aa1dc')

do_build() {
  cd "${CACHE_PATH}/${pkg_name}-${pkg_version}"
  sed -i -e 's|/usr/bin/install|install|g;
             s|/lib/udev|/usr/lib/udev|g' Makefile
  make
}

do_package() {
  cd "${CACHE_PATH}/${pkg_name}-${pkg_version}"
  make DESTDIR="${pkg_prefix}" install

  install -D -m644 ../initcpio-install-pcmcia ${pkg_prefix}/usr/lib/initcpio/install/pcmcia
}

