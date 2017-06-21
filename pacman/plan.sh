pkg_origin=cosmos

pkg_name=pacman
pkg_version=5.0.2
pkg_description="A library-based package manager with dependency support"
pkg_upstream_url="http://www.archlinux.org/pacman/"
pkg_license=('GPL')
pkg_deps=('bash' 'glibc' 'libarchive' 'curl' 'gpgme' 'pacman-mirrorlist')
pkg_build_deps=('asciidoc')
checkpkg_deps=('python2' 'fakechroot')
backup=(etc/pacman.conf etc/makepkg.conf)
#install=pacman.install
pkg_source=("https://sources.archlinux.org/other/pacman/${pkg_name}-${pkg_version}.tar.gz"
        'pacman.conf'
        'makepkg.conf')
pkg_shasum=('f36f5e7e95a89436febe1bcca874fc33'
         '5600ceea45ce0de5262a0c37f42ea28b'
         '6e3061b47b39ba529fee7f0848e26d3e')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./configure --prefix=/usr --sysconfdir=/etc \
    --localstatedir=/var --enable-doc \
    --with-scriptlet-shell=/bin/bash \
    --with-ldconfig=/bin/ldconfig
  make V=1
  make -C contrib
}

do_check() {
  make -C ${pkg_name}-${pkg_version} check
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install
  make DESTDIR=${pkg_prefix} -C contrib install

  mkdir -p ${pkg_prefix}/etc
  install -m644 $CACHE_PATH/pacman.conf ${pkg_prefix}/etc/pacman.conf
  install -m644 $CACHE_PATH/makepkg.conf ${pkg_prefix}/etc/

  # completion files
  install -Dm644 scripts/completion/bash_completion ${pkg_prefix}/usr/share/bash-completion/completions/pacman
  install -Dm644 scripts/completion/zsh_completion ${pkg_prefix}/usr/share/zsh/site-functions/_pacman
  
  for f in makepkg pacman-key; do
    ln -s pacman "${pkg_prefix}/usr/share/bash-completion/completions/$f"
  done
  
  # stop rankmirrors fail
  sed -e 's|/core}"|/core}" echo|' -i ${pkg_prefix}/usr/bin/rankmirrors
}

