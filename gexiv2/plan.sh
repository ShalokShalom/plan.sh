pkg_origin=cosmos
 
pkg_name=gexiv2
pkg_version=0.10.6
_pkg_version=0.10
pkg_description='GObject wrapper around the Exiv2 photo metadata library.'
pkg_upstream_url='https://wiki.gnome.org/Projects/gexiv2'
pkg_license=('GPL2')
pkg_deps=('exiv2' 'glib2')
pkg_build_deps=('python2-gobject3')
pkg_source=("https://ftp.gnome.org/pub/gnome/sources/gexiv2/${_pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
        "https://github.com/GNOME/gexiv2/commit/7c47e3907c4888190138c3301232e198206217fb.diff")
pkg_shasum=('6045847bf08094cd147fcc49d31c0c1a'
         '75d6e609193b299f28e8675d1c175b52')

do_build() {
  #patch -p1 -i ${CACHE_PATH}/7c47e3907c4888190138c3301232e198206217fb.diff

  ./configure --prefix=/usr --enable-introspection
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
