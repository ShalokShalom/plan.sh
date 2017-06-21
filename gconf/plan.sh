pkg_origin=cosmos

pkg_name=gconf
pkg_version=3.2.6
_pkg_version=3.2
pkg_description="A configuration database system"
pkg_upstream_url="https://www.gnome.org"
pkg_license=('LGPL')
pkg_deps=('libxml2' 'polkit' 'libldap' 'dbus-glib')
pkg_build_deps=('pkgconfig' 'intltool' 'gobject-introspection')
pkg_source=("https://ftp.gnome.org/pub/gnome/sources/GConf/${_pkg_version}/GConf-${pkg_version}.tar.xz"
        'gconf-merge-schema'
        'gconfpkg'
        'gconf-reload.patch'
        '01_xml-gettext-domain.patch'
        'gconf-install.hook'
        'gconf-remove.hook')
pkg_shasum=('2b16996d0e4b112856ee5c59130e822c'
         '240b473fa17b748fc9020caf372d936c'
         'b745f04b4121d8724c002b14a4c110b6'
         'cfcc8e15be7b8a48de4aa34336ff6090'
         '1f9362976d71312bdb57c57fa031681d'
         '8841a826f43e905a5a437a9f5a82eb66'
         'c899c0687f6dea0a6464db310f335509')

do_build() {
  patch -p1 -i ${CACHE_PATH}/gconf-reload.patch
  patch -p1 -i ${CACHE_PATH}/01_xml-gettext-domain.patch

  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --libexecdir=/usr/lib/GConf \
    --disable-static \
    --enable-defaults-service \
    --disable-orbit

  make pkglibdir=/usr/lib/GConf
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -m755 -d ${pkg_prefix}/etc/gconf/gconf.xml.system
  install -m755 ${CACHE_PATH}/gconf-merge-schema ${pkg_prefix}/usr/bin/
  install -Dm755 ${CACHE_PATH}/gconfpkg ${pkg_prefix}/usr/sbin/gconfpkg
  
  install -dm755 ${pkg_prefix}/usr/share/libalpm/hooks/
  install -m644 ${CACHE_PATH}/gconf-install.hook ${pkg_prefix}/usr/share/libalpm/hooks/
  install -m644 ${CACHE_PATH}/gconf-remove.hook ${pkg_prefix}/usr/share/libalpm/hooks/
}
