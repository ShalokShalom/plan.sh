pkg_origin=cosmos

pkg_name=fakeroot
pkg_version=1.20.2
pkg_description="Gives a fake root environment, useful for building packages as a non-privileged user."
pkg_license=('GPL')
pkg_upstream_url="http://packages.debian.org/fakeroot"
install="fakeroot.install"
pkg_deps=('glibc' 'filesystem' 'util-linux' 'sed' 'sh')
pkg_source=("http://ftp.debian.org/debian/pool/main/f/fakeroot/${pkg_name}_${pkg_version}.orig.tar.bz2"
        "dlsym.patch")
pkg_shasum=('a4b4564a75024aa96c86e4d1017ac786'
         '62f6a56ee03486d2d8d178b922c612cd')

do_build() {
  cd ${pkg_name}-${pkg_version}
  patch -p1 -i $CACHE_PATH/dlsym.patch

  #./bootstrap
  ./configure --prefix=/usr \
        --libdir=/usr/lib/libfakeroot \
        --disable-static \
        --with-ipc=sysv

  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install
  
  install -d -m755 ${pkg_prefix}/etc/ld.so.conf.d
  echo '/usr/lib/libfakeroot' > ${pkg_prefix}/etc/ld.so.conf.d/fakeroot.conf
  
  install -D -m644 ${CACHE_PATH}/${pkg_name}-${pkg_version}/README ${pkg_prefix}/usr/share/doc/${pkg_name}/README
}

