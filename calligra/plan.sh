pkg_origin=

pkgbase=calligra
pkg_name=('calligra' 'calligra-l10n')
pkg_version=3.0.1
pkg_description="Suite is a collection of office applications linked together by a common base."
pkg_upstream_url='http://www.calligra-suite.org'
pkg_license=('FDL1.2' 'GPL2' 'LGPL')
pkg_build_deps=('karchive' 'kcodecs' 'kconfig' 'kcoreaddons' 'kdbusaddons' 'kguiaddons' 'ki18n' 'kitemviews' 'kwidgetsaddons'
         'threadweaver' 'kcompletion' 'kiconthemes' 'kparts' 'kxmlgui' 'kross' 'kconfigwidgets' 'ktexteditor' 
         'kdelibs4support' 'kio'
         'eigen3' 'freetds' 'libvisio' 'libgsf' 'libwpd' 'libwpg' 'libwps' 'pstoedit' 'gsl' 
         'lcms2' 'libodfgen' 'poppler-qt5' 'libspnav' 'fftw' 'hicolor-icon-theme' 
         'sqlite3' 'libkdcraw' 'exiv2' 'qca-qt5' 'qt5-declarative' 'marble' 'kactivities' 'kdiagram' 'kdeclarative' 'kcalcore'
         'kcontacts' 'akonadi-contacts' 'knotifyconfig' 'knotifications' 'okular' 'openexr' 'vc' 'kreport' 'qt5-webkit'
         'extra-cmake-modules' 'kdoctools' 'git' 'boost' 'docbook-xsl') # 'clang' vc fails clang
#pkg_source=("http://download.kde.org/stable/${pkgbase}/${pkg_version}/${pkgbase}-${pkg_version}.tar.xz")
pkg_source=("https://share.kde.org/index.php/s/yanrJWiQFB3rrvc/download?path=%2F&files=${pkgbase}-${pkg_version}.tar.xz")
pkg_shasum=('a4f7045993bd42ad3e16d72214807ad1')

do_prepare() {
  cd ${pkgbase}-${pkg_version}
  #patch -p1 -i $CACHE_PATH/warnings.diff
  #sed -i 's|KReport 3.0.0 EXACT QUIET|KReport 3.0 QUIET|' CMakeLists.txt
  #sed -i 's|KPropertyWidgets 3.0.0 EXACT QUIET|KPropertyWidgets 3.0 QUIET|' CMakeLists.txt
}

do_build() {
  mkdir build
  cd build
  
  #export CC=/usr/bin/clang
  #export CXX=/usr/bin/clang++
  
  cmake ../${pkgbase}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DPRODUCTSET=DESKTOP \
    -DBUILD_TESTING=FALSE \
    -DPACKAGERS_BUILD=true 
    #-DBUILD_UNMAINTAINED=TRUE
  make
}

package_calligra() {
  pkg_description="Suite is a collection of office applications linked together by a common base."
  pkg_deps=('karchive' 'kcodecs' 'kconfig' 'kcoreaddons' 'kdbusaddons' 'kguiaddons' 'ki18n' 'kitemviews' 'kwidgetsaddons'
         'threadweaver' 'kcompletion' 'kiconthemes' 'kparts' 'kxmlgui' 'kross' 'kconfigwidgets' 'ktexteditor' 
         'kdelibs4support' 'kio'
         'eigen3' 'freetds' 'libvisio' 'libgsf' 'libwpd' 'libwpg' 'libwps' 'pstoedit' 'gsl' 
         'lcms2' 'libodfgen' 'poppler-qt5' 'libspnav' 'fftw' 'hicolor-icon-theme' 
         'sqlite3' 'libkdcraw' 'exiv2' 'qca-qt5' 'qt5-declarative' 'marble' 'kactivities' 'kdiagram' 'kdeclarative' 'kcalcore'
         'kcontacts' 'akonadi-contacts' 'knotifyconfig' 'knotifications' 'okular' 'openexr' 'vc' 'kreport' 'qt5-webkit')
         
  cd build
  
  make DESTDIR=${pkg_prefix} install
  
  rm ${pkg_prefix}/usr/share/applications/calligra_filter_odt2docx.desktop
  #use in calligra-l10n
  mv ${pkg_prefix}/usr/share/locale ${CACHE_PATH}/
}

package_calligra-l10n() {
  pkg_description="Localization for Calligra"
  pkg_deps=('ki18n')
  groups=('localization')
  
  install -d -m755 ${pkg_prefix}/usr/share/locale
  mv ${CACHE_PATH}/locale ${pkg_prefix}/usr/share
}
