pkg_origin=cosmos

pkg_name=mkinitcpio-nfs-utils
pkg_version=0.3
pkg_description="ipconfig and nfsmount tools for NFS root support in mkinitcpio"
pkg_upstream_url="http://www.archlinux.org/"
pkg_license=('GPL2')
pkg_deps=('glibc')
pkg_source=("https://sources.archlinux.org/other/mkinitcpio/$pkg_name-$pkg_version.tar.xz"
        'nfsmount.patch')
pkg_shasum=('a7e586b0adb1a746dc7ae71d104bac0d'
         '23740117f1e6468b4baa57d7c6d11418')

do_build() {
  cd $pkg_name-$pkg_version
  patch -p1 -i $CACHE_PATH/nfsmount.patch
  
  make
}

do_package() {
  cd $pkg_name-$pkg_version
  
  make DESTDIR=$pkg_prefix install
}
