pkg_origin=

pkg_name=xdg-user-dirs
pkg_version=0.15
pkg_description="Manage user directories like ~/Video and ~/Music"
pkg_upstream_url="https://www.freedesktop.org/wiki/Software/xdg-user-dirs"
pkg_license=('GPL')
pkg_deps=('sh')
pkg_build_deps=('docbook-xsl')
backup=('etc/xdg/user-dirs.conf' 'etc/xdg/user-dirs.defaults')
pkg_source=("https://user-dirs.freedesktop.org/releases/${pkg_name}-${pkg_version}.tar.gz"
        'xdg-user-dirs')
pkg_shasum=('f5aaf5686ad7d8809a664bfb4566a54d'
         'bc37bf12f66409af57967ef67066d2ee')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./configure --prefix=/usr --sysconfdir=/etc
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install 
  
  install -D ../xdg-user-dirs ${pkg_prefix}/etc/X11/xinit/xinitrc.d/xdg-user-dirs
  
  sed -i -e 's|TEMPLATES|#TEMPLATES|' ${pkg_prefix}/etc/xdg/user-dirs.defaults
  sed -i -e 's|PUBLICSHARE|#PUBLICSHARE|' ${pkg_prefix}/etc/xdg/user-dirs.defaults
}
