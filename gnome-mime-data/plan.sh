pkg_origin=cosmos

pkg_name=gnome-mime-data
pkg_version=2.18.0
pkg_description="The base MIME and Application database for GNOME"
pkg_upstream_url="http://www.gnome.org"
pkg_license=('GPL')
pkg_deps=('shared-mime-info') 
pkg_build_deps=('intltool')
pkg_source=("https://download.gnome.org/sources/${pkg_name}/2.18/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('541858188f80090d12a33b5a7c34d42c')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -m755 -d ${pkg_prefix}/usr/lib
  mv ${pkg_prefix}/usr/share/pkgconfig ${pkg_prefix}/usr/lib/
}
