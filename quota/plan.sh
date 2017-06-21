pkg_origin=cosmos

pkg_name=quota
pkg_version=4.03
pkg_description="Tools and patches for the Linux Diskquota system as part of the Linux kernel"
pkg_upstream_url="http://sourceforge.net/projects/linuxquota/"
pkg_license=('GPL-2')
pkg_deps=('e2fsprogs' 'libldap')
pkg_source=("http://downloads.sourceforge.net/sourceforge/linuxquota/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('6b09f9c93515c25a528be5754cdfb6f5')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./configure --prefix=/usr \
    --sysconfdir=/etc 
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
  # part of glibc, remove full dir
  rm -rf ${pkg_prefix}/usr/include
}
