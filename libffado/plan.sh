pkg_origin=cosmos

pkg_name=libffado
pkg_version=2.3.0
pkg_description="Driver for FireWire audio devices"
pkg_upstream_url="http://www.ffado.org/"
pkg_license=('GPL')
pkg_deps=('libiec61883' 'libavc1394' 'libsigc++' 'libxml++' 'alsa-lib' 'dbus' 'libconfig'
         'dbus-c++')
pkg_build_deps=('scons' 'jack')
pkg_source=("http://www.ffado.org/files/${pkg_name}-${pkg_version}.tgz"
        'glibmm2.46.patch')
pkg_shasum=('8f452977267200cfaf9b8e16ba3c92df'
         '8f6ae7707c3bb018543f001ad513ba52')

prepare() {
  
  #patch -p1 -i $CACHE_PATH/glibmm2.46.patch
}

do_build() {

  scons PREFIX=/usr ENABLE_OPTIMIZATIONS=yes UDEVDIR=/usr/lib/udev/rules.d COMPILE_FLAGS="$CFLAGS -std=gnu++11"
}

do_package() {

  scons DESTDIR=${pkg_prefix} WILL_DEAL_WITH_XDG_MYSELF="True" install
}

