pkg_origin=
 
pkg_name=ostree
_pkg_name=libostree
pkg_version=2017.6
pkg_description="Suite of command line tools that combines a git-like model for committing and downloading bootable filesystem trees"
pkg_upstream_url="https://github.com/ostreedev/ostree"
pkg_license=('GPL')
pkg_deps=('glib2' 'gpgme' 'fuse' 'libarchive' 'libsoup' 'mkinitcpio' 'util-linux' 'xz' 'zlib')
pkg_build_deps=('e2fsprogs' 'libxslt' 'python2')
pkg_source=("https://github.com/ostreedev/ostree/releases/download/v${pkg_version}/${_pkg_name}-${pkg_version}.tar.xz"
        'ostree-mkinitcpio.conf')
pkg_shasum=('e9ed2db2e16fac53bc959654581c0e0c'
         '5b424fa5c03398f9ab3a60fd669a768a')

do_prepare() {
  cd ${_pkg_name}-${pkg_version}
  
  cp ${CACHE_PATH}/ostree-mkinitcpio.conf src/boot/mkinitcpio/ostree-mkinitcpio.conf
}

do_build() {
  cd ${_pkg_name}-${pkg_version}

  ./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --sbindir=/usr/bin \
    --libexecdir=/usr/lib \
    --with-mkinitcpio \
    --with-builtin-grub2-mkconfig 

  make
}

do_package() {
  cd ${_pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
}
