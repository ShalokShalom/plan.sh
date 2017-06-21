pkg_origin=cosmos

pkg_name=gtk2
pkg_version=2.24.31
_pkg_version=2.24
pkg_upstream_url="https://www.gtk.org/"
pkg_description="GTK+ is a multi-platform toolkit (v2)"
pkg_license=('LGPL')
pkg_deps=('atk' 'pango' 'libxcursor' 'libxinerama' 'libxrandr' 'libxi' 'libxcomposite' 'libxdamage'
         'shared-mime-info' 'cairo' 'libcups' 'gtk-update-icon-cache')
pkg_build_deps=('gobject-introspection')
backup=(etc/gtk-2.0/gtkrc)
pkg_source=("https://ftp.gnome.org/pub/gnome/sources/gtk+/${_pkg_version}/gtk+-$pkg_version.tar.xz"
        'xid-collision-debug.patch'
        'gtk-query-immodules-2.0.hook')
pkg_shasum=('526a1008586094a2cbb4592fd3f9ee10'
         '22355df723f6ca358e30e6b8f0baace5'
         '01735166750a40a539d4bad5dbd5f664')

do_build() {
    patch -p1 -i ${CACHE_PATH}/xid-collision-debug.patch

    CXX=/bin/false ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --localstatedir=/var \
        --with-xinput=yes

    #https://bugzilla.gnome.org/show_bug.cgi?id=655517
    sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0/g' libtool

    make
}

do_package() {
    make DESTDIR=${pkg_prefix} install

    echo 'gtk-fallback-icon-theme = "gnome"' > ${pkg_prefix}/etc/gtk-2.0/gtkrc
    
    install -Dm644 ../gtk-query-immodules-2.0.hook ${pkg_prefix}/usr/share/libalpm/hooks/gtk-query-immodules-2.0.hook
    
    rm $pkg_prefix/usr/bin/gtk-update-icon-cache
}

