pkg_origin=
pkg_name=kdeplasma-applets-appmenu-qml
pkg_version=1.6
pkg_description="This plasmoid shows a menu of the installed applications, similar to Lancelot but much simpler."
pkg_upstream_url="http://kde-apps.org/content/show.php/AppMenu+QML?content=146098"
pkg_license=('GPL')
pkg_deps=('kde-workspace')
pkg_build_deps=('unzip')
pkg_source=("http://kde-apps.org/CONTENT/content-files/146098-plasma-applet-appmenu-qml-${pkg_version}.plasmoid"
        'home.png'
        'icon.diff')
pkg_shasum=('4b583606c08fa50546c93772cd810852'
         'df7f5363299f171238895b158c63fa5a'
         'c3912040d72db9d981443016ebd65ee3')
 
do_package() {
  unzip -o -q "$CACHE_PATH/146098-plasma-applet-appmenu-qml-${pkg_version}.plasmoid" -d "$CACHE_PATH/plasma-applet-appmenu-qml"
  patch -p1 -i $CACHE_PATH/icon.diff
  
  install -D $CACHE_PATH/plasma-applet-appmenu-qml/metadata.desktop ${pkg_prefix}/"`kde4-config --prefix`/share/kde4/services/plasma-applet-appmenu-qml.desktop"
  mkdir -p ${pkg_prefix}/"`kde4-config --prefix`/share/apps/plasma/plasmoids/appmenu-qml"
  cp -r $CACHE_PATH/plasma-applet-appmenu-qml/* ${pkg_prefix}/"`kde4-config --prefix`/share/apps/plasma/plasmoids/appmenu-qml/"
  mkdir -p ${pkg_prefix}/usr/share/icons 
  install -m 644 -p ${CACHE_PATH}/home.png ${pkg_prefix}/usr/share/icons/home.png
}
