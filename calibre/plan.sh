pkg_origin=

pkg_name=calibre
pkg_version=3.0.0
pkg_description="Ebook management application."
pkg_upstream_url="http://www.calibre-ebook.com/"
pkg_license=('GPL3')
pkg_deps=('python2')
pkg_build_deps=('xdg-utils')
pkg_source=("https://download.calibre-ebook.com/${pkg_version}/calibre-${pkg_version}-x86_64.txz"
        'calibre.desktop'
        'calibre.png')
pkg_shasum=('9aec627154c274bf3a3d0a9e2da9e6ac'
         'bda3df9bbc0b793d94a4d3d10bdf194a'
         '5c523427b55c62d7fee06b0cc056c46e')

do_package() {
  cd ${CACHE_PATH}
  
  install -d ${pkg_prefix}/opt/calibre
  tar xvf ${CACHE_PATH}/calibre-${pkg_version}-x86_64.txz -C ${pkg_prefix}/opt/calibre

  install -d ${pkg_prefix}/usr/bin
  install -Dm644 calibre.desktop ${pkg_prefix}/usr/share/applications/calibre.desktop             
  install -Dm644 calibre.png ${pkg_prefix}/usr/share/pixmaps/calibre.png
  ln -s /opt/calibre/calibre $pkg_prefix/usr/bin/calibre
}

