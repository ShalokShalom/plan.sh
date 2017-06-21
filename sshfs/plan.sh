pkg_origin=cosmos

pkg_name=sshfs
pkg_version=2.8
pkg_description="FUSE client based on the SSH File Transfer Protocol"
pkg_upstream_url="https://github.com/libfuse/"
pkg_license=('GPL')
pkg_deps=('fuse' 'glib2' 'openssh')
pkg_build_deps=('pkgconfig')
pkg_source=("https://github.com/libfuse/sshfs/releases/download/sshfs_${pkg_version}/sshfs-${pkg_version}.tar.gz")
pkg_shasum=('0ba25e848ee59e2595d6576c8f6284b6')

do_build() {

  #autoreconf -i
  ./configure --prefix=/usr
  make
}

do_package() {

  make DESTDIR=${CACHE_PATH} install
}
