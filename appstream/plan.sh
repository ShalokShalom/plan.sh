pkg_origin=
 
pkg_name=appstream
_pkg_name=AppStream
pkg_version=0.11.0
pkg_description="Provides a standard for creating app stores across distributions"
pkg_upstream_url="https://github.com/ximion/appstream"
pkg_license=('GPL')
pkg_deps=('libyaml' 'libxml2' 'glib2' 'qt5-base')
pkg_build_deps=('cmake' 'gobject-introspection' 'itstool' 'python2' 'xmlto')
pkg_source=("https://www.freedesktop.org/software/appstream/releases/${_pkg_name}-${pkg_version}.tar.xz"
        'appstream.hook')
pkg_shasum=('69cdfd1c6556f796d10416739792fa60'
         'f244ccc7b89aacfe903facce393174ca')

do_build() {
  mkdir -p build
  cd build

  cmake ../${_pkg_name}-${pkg_version} \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=/usr \
  -DCMAKE_INSTALL_LIBDIR=lib \
  -DQT=ON \
  -DSTEMMING=OFF
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install

  install -Dm644 ../appstream.hook ${pkg_prefix}/usr/share/libalpm/hooks/appstream.hook
}
