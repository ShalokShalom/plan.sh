pkg_origin=cosmos

pkg_name=xfsprogs
pkg_version=4.11.0
_pkg_version=4.11.0
pkg_description="XFS filesystem utilities"
pkg_license=('LGPL')
pkg_upstream_url="http://xfs.org/index.php/Main_Page"
pkg_deps=('util-linux')
pkg_source=("https://www.kernel.org/pub/linux/utils/fs/xfs/xfsprogs/${pkg_name}-${_pkg_version}.tar.xz")
pkg_shasum=('f1f9b8c752347eefdb56483dafa0cefb')

do_build() {
  cd ${pkg_name}-${_pkg_version}
  
  export OPTIMIZER="-march=${CARCH/_/-} -O1"
  export DEBUG=-DNDEBUG
  ./configure --prefix=/usr
  make
}

do_package() {
  cd ${pkg_name}-${_pkg_version}
  make DIST_ROOT=${pkg_prefix} install install-dev
  
  chown -R root ${pkg_prefix}
  chgrp -R root ${pkg_prefix}
  mv ${pkg_prefix}/lib/libhandle.so* ${pkg_prefix}/usr/lib/
  rm -rf ${pkg_prefix}/lib
}

