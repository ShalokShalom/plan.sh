pkg_origin=
# part of kio-extras remove from git
pkg_name=kio-mtp
pkg_version=0.76.2
pkg_description="Provides KIO Access to MTP devices using the mtp:/// protocol"
pkg_upstream_url='https://projects.kde.org/projects/playground/base/kio-mtp'
pkg_license=('GPL')
pkg_deps=('ki18n' 'kio' 'solid' 'libmtp')
pkg_build_deps=('extra-cmake-modules' 'git')
pkg_source=("$pkg_name-$pkg_version.tar.gz::http://quickgit.kde.org/?p=kio-mtp.git&a=snapshot&h=c785cdaaafd9c204f099dbd0c706d86580c17b6a&fmt=tbz2")
pkg_shasum=('ed75785239a3623d211bb24eaef44068')

do_build() {
  mkdir build
  cd build
  
  cmake ../${pkg_name} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr
  make
}

do_package(){
  cd build
  
  make DESTDIR="${pkg_prefix}" install
}
