pkg_origin=cosmos

pkg_name=lsb-release
pkg_version=1.4
pkg_description="LSB version query program."
pkg_upstream_url="http://www.linuxbase.org/"
pkg_build_deps=('perl') # to generate the man page
pkg_license=('GPL2')
pkg_source=("http://downloads.sourceforge.net/lsb/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('30537ef5a01e0ca94b7b8eb6a36bb1e4')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make prefix=${pkg_prefix}/usr mandir=${pkg_prefix}/usr/share/man install

  install -d -m755 ${pkg_prefix}/etc
  echo LSB_VERSION=${pkg_version} >> ${pkg_prefix}/etc/lsb-release
  echo DISTRIB_ID=KaOS >> ${pkg_prefix}/etc/lsb-release
  echo DISTRIB_RELEASE=rolling >> ${pkg_prefix}/etc/lsb-release
  echo DISTRIB_DESCRIPTION=\"KaOS\" >> ${pkg_prefix}/etc/lsb-release
}

