pkg_origin=cosmos

pkg_name=libimobiledevice
pkg_version=1.2.0.1
_commit=45fda819e1aae3cacf25a04b9fe22cd6ddc61f5a
pkg_description="Is a software library that talks the protocols to support iPhone and iPod Touch devices on Linux"
pkg_upstream_url="http://libimobiledevice.org/"
pkg_license=('GPL2' 'LGPL2.1')
pkg_deps=('gnutls'  'glib2' 'libplist' 'libusbmuxd' 'libgcrypt')
pkg_build_deps=('python2')
pkg_source=("https://github.com/libimobiledevice/libimobiledevice/archive/${_commit}.zip")
pkg_shasum=('50e85994be298e5368a9f875f9b141af')

do_build() {

  ./autogen.sh
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
