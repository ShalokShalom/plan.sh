pkg_origin=cosmos

pkg_name=libx86emu
pkg_version=1.11.1.1
_pkg_version=1.11-1.1
_shortver=1.11
pkg_description="x86 emulation library"
pkg_upstream_url="https://github.com/wfeldt/libx86emu"
pkg_license=('BSD')
pkg_deps=('glibc')
pkg_build_deps=('rpmextract')
pkg_source=("http://download.opensuse.org/source/tumbleweed/repo/oss/suse/src/${pkg_name}-${_pkg_version}.src.rpm")
pkg_shasum=('92d9f9259ed5a381a950b8b6fd03b754')

do_build() {
  rpmextract.sh ${pkg_name}-${_pkg_version}.src.rpm
  tar -xJf ${pkg_name}-${_shortver}.tar.xz
  

  make LIBDIR=/usr/lib
}

do_package() {
  make LIBDIR=/usr/lib DESTDIR=${pkg_prefix} install
  
  install -Dm644 LICENSE \
  ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}

