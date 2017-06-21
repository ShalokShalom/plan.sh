pkg_origin=
 
pkg_name=rosa-imagewriter
pkg_version=2.6.2.0
pkg_description="Tool for creating bootable installation USB flash drives"
pkg_upstream_url="https://abf.io/soft/rosa-imagewriter"
pkg_license=('GPLv2')
pkg_deps=('qt5-base')
pkg_build_deps=('qt5-tools')
pkg_source=("https://abf.io/soft/rosa-imagewriter/archive/${pkg_name}-version-${pkg_version}.tar.gz"
        'rosa-imagewriter.desktop'
        'riw_write_iso.desktop'
        'icon-open.ico'
        'icon-refresh.ico'
        'logo-rosa.png'
        'icon-rosa.svg')
pkg_shasum=('e064feb95d6297d02d695861d4ea30d9'
         '6ece8dca19238179fb1005d7c6df1854'
         'b8dbfc604214ba31da0861c6ae9ee12f'
         'fe59e2abf307d7e4a5f42cbe9bba4857'
         'bff77e8154b214396cc3e42eb433ccaf'
         'd587f0cb7c7104118f380589a942a42f'
         'f2d420e4758e21a1f7217e599314258a')

do_build() { 
  cd ${pkg_name}-version-${pkg_version}
  cp ${CACHE_PATH}/icon-open.ico res/icon-open.ico
  cp ${CACHE_PATH}/icon-refresh.ico res/icon-refresh.ico
  cp ${CACHE_PATH}/logo-rosa.png res/logo-rosa.png
  cp ${CACHE_PATH}/icon-rosa.svg res/icon-rosa.svg
  
  /usr/lib/qt5/bin/qmake RosaImageWriter.pro
  /usr/lib/qt5/bin/lrelease RosaImageWriter.pro
  make 
}

do_package() {
  cd ${pkg_name}-version-${pkg_version}
  
  mkdir -p ${pkg_prefix}/usr/bin
  mkdir -p ${pkg_prefix}/usr/lib/rosa-imagewriter/lang
  
  install -D -m755 RosaImageWriter ${pkg_prefix}/usr/lib/rosa-imagewriter/rosa-imagewriter
  install -Dm644 lang/*.qm ${pkg_prefix}/usr/lib/rosa-imagewriter/lang/
  
  ln -sf /usr/lib/rosa-imagewriter/rosa-imagewriter ${pkg_prefix}/usr/bin/rosa-imagewriter
  
  install -Dm644 -p ../rosa-imagewriter.desktop ${pkg_prefix}/usr/share/applications/rosa-imagewriter.desktop
  install -Dm644 -p ../riw_write_iso.desktop ${pkg_prefix}/usr/share/kservices5/ServiceMenus/riw_write_iso.desktop
  install -Dm644 -p res/icon-rosa.svg ${pkg_prefix}/usr/share/icons/hicolor/scalable/apps/rosa.svg
  
  install -Dm644 doc/LICENSE.html ${pkg_prefix}/usr/share/licenses/LICENSE.html
}
