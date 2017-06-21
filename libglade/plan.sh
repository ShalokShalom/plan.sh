pkg_origin=cosmos

pkg_name=libglade
pkg_version=2.6.4
_pkg_version=2.6
pkg_description="Allows you to load glade interface files in a program at runtime"
pkg_license=('LGPL')
pkg_upstream_url="http://www.gnome.org"
pkg_deps=('gtk2' 'libxml2')
pkg_build_deps=('python2' 'pkgconfig')
pkg_deps=('python2: libglade-convert script')
install=glade.install
pkg_source=("https://ftp.gnome.org/pub/gnome/sources/libglade/${_pkg_version}/${pkg_name}-${pkg_version}.tar.bz2"
        'libglade-2.0.1-nowarning.patch')
pkg_shasum=('d1776b40f4e166b5e9c107f1c8fe4139'
         '4f879c0ce550004905aa0fb24f25c353')

do_build() {
  patch -p1 -i ${CACHE_PATH}/libglade-2.0.1-nowarning.patch 
  
  ./configure --sysconfdir=/etc \
    --prefix=/usr \
    --localstatedir=/var
  make 
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install 
  install -m755 libglade-convert ${pkg_prefix}/usr/bin/ 
}
