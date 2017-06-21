pkg_origin=

pkg_name=redshift
pkg_version=1.11
pkg_description='Adjusts the color temperature of your screen according to your surroundings'
pkg_upstream_url='http://jonls.dk/redshift/'
pkg_license=('GPL3')
pkg_deps=('libxxf86vm' 'libxcb')
pkg_build_deps=('python3' 'intltool')
pkg_source=("https://github.com/jonls/redshift/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('a31d768b0348c5202e58612855a9027e')

do_build() {
  cd ${pkg_name}-${pkg_version}

  PYTHON=/usr/bin/python3 ./configure \
         --prefix=/usr \
         --disable-gui \
         --disable-geoclue \
         --disable-ubuntu 
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  make DESTDIR="${pkg_prefix}" install
}
