pkg_origin=

pkg_name=eclipse
pkg_version=4.6.3
_date=201703010400
pkg_description="An IDE for Java and other languages"
pkg_upstream_url="http://eclipse.org"
pkg_deps=('java-environment' 'gtk2' 'unzip' 'libxtst')
pkg_build_deps=('zip')
pkg_license=("EPL/1.0")
# http://download.eclipse.org/eclipse/downloads/
pkg_source=("http://ftp.osuosl.org/pub/eclipse/eclipse/downloads/drops4/R-${pkg_version}-${_date}/${pkg_name}-SDK-${pkg_version}-linux-gtk-x86_64.tar.gz"
        'eclipse.sh'
        'eclipse.desktop'
        'eclipse.svg')
pkg_shasum=('411032b43d882c3d0b84dbbe29b0be0b'
         '7ea99a30fbaf06ec29261541b8eb1e23'
         'ba2cf02c48e6e35bfe3685401c26bb5b'
         '77cff7543ccf7e177cb6667f5a20ce19')

do_package() {
  install -m755 -d ${pkg_prefix}/usr/share/licenses/eclipse/
  mv eclipse ${pkg_prefix}/usr/share/

  install -d ${pkg_prefix}/usr/bin ${pkg_prefix}/usr/share/applications ${pkg_prefix}/usr/share/icons/hicolor/apps
  install -m755 eclipse.sh ${pkg_prefix}/usr/bin/eclipse
  install -m644 eclipse.desktop ${pkg_prefix}/usr/share/applications/

  install -Dm644 ${CACHE_PATH}/eclipse.svg ${pkg_prefix}/usr/share/icons/hicolor/scalable/apps/eclipse.svg

  #mv ${pkg_prefix}/usr/share/eclipse/epl-v10.html $pkg_prefix/usr/share/licenses/eclipse/epl-v10.html
}
