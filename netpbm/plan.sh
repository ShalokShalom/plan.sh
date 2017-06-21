pkg_origin=cosmos

pkg_name=netpbm
pkg_version=10.76.00
pkg_description="A toolkit for manipulation of graphic images"
pkg_license=('custom' 'BSD' 'GPL' 'LGPL')
pkg_upstream_url="http://netpbm.sourceforge.net/"
pkg_deps=('perl' 'libjpeg-turbo' 'libpng' 'libtiff' 'libxml2' 'libx11')
pkg_build_deps=('python2' 'subversion')
pkg_source=("svn://svn.code.sf.net/p/netpbm/code/advanced")
pkg_shasum=('SKIP')

do_build() {
  
  # use the interactive way
  ./configure
  
  sed -i 's|misc|share/netpbm|' common.mk
  sed -i 's|/link|/lib|' lib/Makefile

  make
}

do_package() {
  make package pkg_prefix=${pkg_prefix}/usr 
  
  install -D -m644 doc/copyright_summary ${pkg_prefix}/usr/share/licenses/${pkg_name}/copyright_summary.txt
    
  mv -iv ${pkg_prefix}/usr/man ${pkg_prefix}/usr/share/man
  rm ${pkg_prefix}/usr/conf*
  rm ${pkg_prefix}/usr/pkg*
  rm ${pkg_prefix}/usr/README
  rm ${pkg_prefix}/usr/VERSION
}
