pkg_origin=cosmos

pkg_name=encfs
pkg_version=1.9.1
pkg_description='Encrypted filesystem in user-space'
pkg_upstream_url='https://vgough.github.io/encfs/'
pkg_license=('GPL')
pkg_deps=('openssl' 'fuse' 'tinyxml2')
pkg_build_deps=('cmake')
pkg_source=("https://github.com/vgough/encfs/releases/download/v${pkg_version}/encfs-${pkg_version}.tar.gz")
pkg_shasum=('7cbf9cc3c5af49b46703ce6ba70d22a4')

do_build(){
  mkdir -p build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DBUILD_SHARED_LIBS=ON \
    -DINSTALL_LIBENCFS=ON \
    -DUSE_INTERNAL_TINYXML=OFF

  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
