pkg_origin=cosmos

pkgbase=gtk3
pkg_name=('gtk3' 'gtk-update-icon-cache')
pkg_version=3.22.15
_pkg_version=3.22
pkg_upstream_url="http://www.gtk.org/"
pkg_build_deps=('gobject-introspection' 'cairo' 'libcups' 'libxcursor' 'libxinerama' 'libxrandr' 
             'libxi' 'libxcomposite' 'libxdamage' 'pango' 'shared-mime-info' 'gdk-pixbuf2' 
             'colord' 'at-spi2-atk' 'libepoxy' 'libxkbcommon' 'librsvg' 'wayland' 'wayland-protocols')
pkg_license=('LGPL')
pkg_source=("https://ftp.gnome.org/pub/gnome/sources/gtk+/${_pkg_version}/gtk+-${pkg_version}.tar.xz"
        'gtk-update-icon-cache.hook'
        'gtk-update-icon-cache.script')
pkg_shasum=('9a1177854c4c5609293e017c53bc8950'
         'c792ef5bb74ceba564b4d8ad306a6592'
         '025117f62dfb22e942a46784e238e470')

do_build() {

 ./configure --prefix=/usr \
             --sysconfdir=/etc \
             --localstatedir=/var \
             --disable-schemas-compile \
             --enable-x11-backend \
             --enable-wayland-backend

  #https://bugzilla.gnome.org/show_bug.cgi?id=655517
  sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0/g' libtool
  make
}

package_gtk3() {
  pkg_description="The GTK+ Toolkit (v3)"
  pkg_deps=('cairo' 'libcups' 'libxcursor' 'libxinerama' 'libxrandr' 
          'libxi' 'libxcomposite' 'libxdamage' 'pango' 'shared-mime-info' 
          'colord' 'at-spi2-atk' 'libepoxy' 'libxkbcommon' 'wayland' 'wayland-protocols')
  install="gtk3.install"
  

  make DESTDIR=${pkg_prefix} install
  
  # avoid gtk2 conflict, used for both gtk2 & 3 this way
  rm $pkg_prefix/usr/bin/gtk-update-icon-cache
}

package_gtk-update-icon-cache() {
    pkg_description="The GTK+ update icon cache tool"
    pkg_deps=('gdk-pixbuf2')


    install -Dm755 gtk-update-icon-cache ${pkg_prefix}/usr/bin/gtk-update-icon-cache
    
    install -Dm644 ../../gtk-update-icon-cache.hook ${pkg_prefix}/usr/share/libalpm/hooks/gtk-update-icon-cache.hook
    install -Dm755 ../../gtk-update-icon-cache.script ${pkg_prefix}/usr/share/libalpm/scripts/gtk-update-icon-cache
}
