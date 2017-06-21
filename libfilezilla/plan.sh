pkg_origin=

pkg_name=libfilezilla
pkg_version=0.9.2
pkg_description="Small C++ library, offering a typesafe, multi-threaded event system and process handling for spawning child processes."
pkg_upstream_url="https://lib.filezilla-project.org/"
pkg_license=('GPL2')
pkg_deps=('gcc')
pkg_source=("https://download.filezilla-project.org/libfilezilla/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('d52a0e7229efb3c9fafc8a2b649d665d')

do_build() {
  cd ${pkg_name}-${pkg_version}
  sed -e "s|<uint8_t> random_bytes(size_t size)|<uint8_t> FZ_PUBLIC_SYMBOL random_bytes(size_t size)|" -i lib/libfilezilla/util.hpp

  ./configure --prefix=/usr \
    --disable-static 
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}

  make DESTDIR=${pkg_prefix} install
}
