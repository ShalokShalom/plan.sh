pkg_origin=

pkg_name=inkscape
pkg_version=0.92.1
pkg_description="A vector-based drawing program - svg compliant"
pkg_upstream_url="https://inkscape.org/en/"
pkg_license=('GPL' 'LGPL')
pkg_deps=('poppler-glib' 'imagemagick' 'aspell' 'gc' 'gtkmm' 'libxslt' 'gsl'
         'desktop-file-utils' 'popt' 'hicolor-icon-theme' 'python2-lxml' 'python2-numpy'
         'libwpg' 'libvisio' 'libwpd' 'potrace')
pkg_build_deps=('boost' 'pkg-config' 'intltool')
pkg_source=("https://inkscape.global.ssl.fastly.net/media/resources/file/inkscape-${pkg_version}.tar.bz2")
#pkg_source=("https://inkscape.org/en/gallery/item/10682/inkscape-${pkg_version}.tar.bz2")
pkg_shasum=('db2eb2a566cf35ff949fc9ccb172889a')

do_build() {
  mkdir -p build
  cd build 
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
