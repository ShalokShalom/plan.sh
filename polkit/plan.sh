pkg_origin=

pkg_name=polkit
pkg_version=0.113
pkg_description="Application development toolkit for controlling system-wide privileges"
pkg_license=('LGPL')
pkg_upstream_url="https://www.freedesktop.org/wiki/Software/polkit"
pkg_deps=('glib2' 'pam' 'expat' 'systemd' 'js')
pkg_build_deps=('intltool' 'gobject-introspection' 'docbook-xsl')
install=polkit.install
pkg_source=("https://www.freedesktop.org/software/polkit/releases/${pkg_name}-${pkg_version}.tar.gz"
        'polkit.pam')
pkg_shasum=('4b77776c9e4f897dcfe03b2c34198edf'
         '6564f95878297b954f0572bc1610dd15')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./configure --prefix=/usr \
      --sysconfdir=/etc \
      --localstatedir=/var \
      --libexecdir=/usr/lib/polkit-1 \
      --enable-libsystemd-login=yes \
      --disable-static \
      --with-os-type=KaOS
  make 
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install

  chown 102 ${pkg_prefix}/etc/polkit-1/rules.d
  chown 102 ${pkg_prefix}/usr/share/polkit-1/rules.d
  
  install -m644 ${CACHE_PATH}/polkit.pam ${pkg_prefix}/etc/pam.d/polkit-1 
}
