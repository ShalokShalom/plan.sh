pkg_origin=cosmos

pkg_name=kbd
pkg_version=2.0.4
pkg_description="Keytable files and keyboard utilities"
pkg_upstream_url="http://www.kbd-project.org"
pkg_license=('GPL')
pkg_deps=('glibc' 'pam')
pkg_build_deps=('check')
pkg_source=("ftp://ftp.kernel.org/pub/linux/utils/kbd/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('c69fce737a5fd0fa686cbfc4f611a220')

do_build() {
  cd ${pkg_name}-${pkg_version}

  # Rename conflicting keymaps to have unique names
  mv data/keymaps/i386/qwertz/cz{,-qwertz}.map
  mv data/keymaps/i386/olpc/es{,-olpc}.map
  mv data/keymaps/i386/olpc/pt{,-olpc}.map
  mv data/keymaps/i386/dvorak/no{,-dvorak}.map
  mv data/keymaps/i386/fgGIod/trf{,-fgGIod}.map
  mv data/keymaps/i386/colemak/{en-latin9,colemak}.map

  ./configure --prefix=/usr \
    --datadir=/usr/share/kbd \
    --mandir=/usr/share/man
    
  make KEYCODES_PROGS=yes RESIZECONS_PROGS=yes
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  make KEYCODES_PROGS=yes RESIZECONS_PROGS=yes DESTDIR=${pkg_prefix} install
}
