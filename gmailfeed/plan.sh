pkg_origin=

pkg_name=gmailfeed
pkg_version=1.1
_commit=d47f34cf5b79ba0df18bbb26e6c9ff125361c875
pkg_description="Plasmoid that provides a list of unread emails from your Gmail inbox and notifies when you receive new messages"
pkg_upstream_url="https://github.com/anthon38/gmailfeed"
pkg_license=('GPL')
pkg_deps=('plasma-framework' 'hicolor-icon-theme' 'knotifications' 'kaccounts-integration')
pkg_build_deps=('extra-cmake-modules' 'intltool')
pkg_source=("https://github.com/anthon38/gmailfeed/archive/${_commit}.zip")
pkg_shasum=('80e9e329fc0b436e15b9487eeb741db8')

do_build() {
  mkdir -p build 
  cd build
  
  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib
  make
}

do_package() {
  cd build
  
  make install DESTDIR=${pkg_prefix}
}
