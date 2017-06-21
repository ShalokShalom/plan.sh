pkg_origin=cosmos

pkg_name=libasyncns
pkg_version=0.8
pkg_description="Linux/Unix A C library for executing name service queries asynchronously"
pkg_upstream_url="http://0pointer.de/lennart/projects/libasyncns"
pkg_license=('LGPL')
pkg_deps=('glibc')
pkg_source=("http://0pointer.de/lennart/projects/libasyncns/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('1f553d6ce1ad255bc83b3d8e9384f515')

do_build() {
  
  ./configure --prefix=/usr --disable-lynx
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
