pkg_origin=cosmos

pkg_name=fontforge
pkg_version=20161012
_pkg_version=20161012
pkg_description="An outline and bitmap font editor"
pkg_upstream_url="http://fontforge.github.io/"
pkg_license=('BSD')
pkg_deps=('libxkbui' 'libxi' 'libxml2' 'pango' 'giflib' 'libpng' 'libtiff' 'libjpeg-turbo' 'python3'
         'libtool' 'desktop-file-utils' 'hicolor-icon-theme')
pkg_source=("https://github.com/fontforge/fontforge/archive/${_pkg_version}.tar.gz"
        'http://fontforge.org/cidmaps.tgz')
pkg_shasum=('d7e3cfc8097808e5bfbee44749f30808'
         '063691163e592515b31514515bb3ce8c')

do_build() {
  #sed '/fontforge_package_name/s/^#//' -i configure.ac
  
  ./bootstrap
  ./configure --prefix=/usr \
              --mandir=/usr/share/man
  make 
}

do_package() {
  make DESTDIR=${pkg_prefix} install 
  
  install -d ${pkg_prefix}/usr/share/fontforge
  install -m644 ../Adobe-* ${pkg_prefix}/usr/share/fontforge
  
  install -D -m644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE 
}
