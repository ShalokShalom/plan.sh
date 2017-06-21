pkg_origin=cosmos

pkg_name=libnotify
pkg_version=0.7.7
pkg_description="Desktop notification library"
pkg_upstream_url="http://library.gnome.org/devel/notification-spec/"
pkg_license=('LGPL')
pkg_deps=('gdk-pixbuf2')
pkg_build_deps=('gtk3' 'gobject-introspection')
pkg_source=("http://ftp.gnome.org/pub/GNOME/sources/libnotify/0.7/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('e9d911f6a22435e0b922f2fe71212b59')

do_build() {
    
    ./configure --prefix=/usr --disable-static 
    make
}

do_package() {
    
    make DESTDIR=${pkg_prefix} install
}

