pkg_origin=

pkg_name=choqok
pkg_version=1.6.0
_pkg_version=1.6
pkg_description="KDE Micro-Blogging client, Currently supports Pump.io, GNU social and Twitter.com"
pkg_upstream_url="http://choqok.gnufolks.org/"
pkg_license=('GPL')
pkg_deps=('kconfigwidgets' 'kcoreaddons' 'ki18n' 'kemoticons' 'kglobalaccel' 'kguiaddons' 'kcmutils' 'knotifications' 
         'knotifyconfig' 'sonnet' 'ktextwidgets' 'kwallet' 'kwidgetsaddons' 'kxmlgui' 'kparts' 'kdewebkit' 
         'kio' 'kjobwidgets' 'telepathy-qt5' 'kaccounts-providers' 'qoauth' 'qca-qt5')
pkg_build_deps=('extra-cmake-modules' 'git' 'kdoctools')
pkg_source=("http://download.kde.org/stable/choqok/${_pkg_version}/src/choqok-${pkg_version}.tar.xz")
pkg_shasum=('f61ff13a748a78bb01433c5419c7cc13')

#do_prepare() {
#  cd ${pkg_name}-${_commit}
  
#  sed -i 's|#include <klocale.h>||' ${CACHE_PATH}/${pkg_name}/plugins/imstatus/imstatussettings.h
#}

do_build() {
  mkdir build
  
  cd build
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_LIBDIR=lib
  make
}

do_package() {
  cd build  
  make DESTDIR=${pkg_prefix} install
  
  #sed -i 's|Exec=choqok %i -caption %c|Exec=choqok -qwindowtitle %c|' ${pkg_prefix}/usr/share/applications/choqok.desktop
  #provided by kaccounts-providers
  #rm -r ${pkg_prefix}/usr/share/icons/hicolor/16x16/apps/laconica_microblog.png
  rm -r ${pkg_prefix}/usr/share/icons/hicolor/16x16/apps/twitter_microblog.png
  #rm -r ${pkg_prefix}/usr/share/icons/hicolor/22x22/apps/laconica_microblog.png
  rm -r ${pkg_prefix}/usr/share/icons/hicolor/22x22/apps/twitter_microblog.png
  #rm -r ${pkg_prefix}/usr/share/icons/hicolor/32x32/apps/laconica_microblog.png
  rm -r ${pkg_prefix}/usr/share/icons/hicolor/32x32/apps/twitter_microblog.png
  #rm -r ${pkg_prefix}/usr/share/icons/hicolor/48x48/apps/laconica_microblog.png
  rm -r ${pkg_prefix}/usr/share/icons/hicolor/48x48/apps/twitter_microblog.png
}
