pkg_origin=

pkg_name=emovix
pkg_version=0.9.0
pkg_description="Create Movix-CD's (also emovix plugin for k3b)"
pkg_upstream_url="http://movix.sourceforge.net/"
pkg_license=('GPL2')
pkg_deps=('perl' 'cdrtools')
pkg_source=("http://downloads.sourceforge.net/sourceforge/movix/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('a96492f338824b24c5a9e714c57eddcf')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./configure --prefix=/usr
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
  find ${pkg_prefix}/usr/share/emovix -type d -exec chmod 755 {} \;
}

