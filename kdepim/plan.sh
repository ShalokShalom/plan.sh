pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kdepim
pkg_version=${_kdever}
pkg_description="KDE's Personal Information Management suite"
pkg_upstream_url="http://www.kde.org"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('grantlee' 'phonon-qt5' 'qt5-tools' 'prison' 'libkgapi' 'qt5-webkit' 'qtwebengine' # fails with Qt5.5.1 'qtspeech'
         #frameworks
         'kdelibs4support' 'kwallet' 'knewstuff' 'kcmutils' 'kdewebkit' 'karchive' 'knotifyconfig'
         'kconfig' 'khtml' 'kservice' 'kdbusaddons' 'kauth' 'ktexteditor' 'kdnssd' 'kcodecs' 'kglobalaccel'
         'sonnet' 'kross' 
         #kdepimlibs
         'kcontacts' 'kcalcore' 'kidentitymanagement' 'kldap' 'kmailtransport' 'kcalutils' 'kontactinterface'
         'kholidays' 'ktnef' 'kimap' 'kmbox' 'akonadi-calendar' 'syndication' 'gpgmepp' 'kalarmcal' 'kmime'
         'kxmlrpcclient' 'kblog' 'akonadi-mime' 'akonadi-contacts' 'akonadi-notes' 'akonadi-search' 
         'kdepim-runtime' 'libgravatar' 'mailimporter' 'mailcommon' 'kdepim-apps-libs' 'libkleo' 
         'grantleetheme' 'pimcommon' 'libkdepim' 'incidenceeditor' 'messagelib' 'calendarsupport' 
         'eventviews' 'kdgantt2' 'libksieve' 'kdepim-addons')
pkg_build_deps=('boost' 'extra-cmake-modules' 'kdoctools' 'clang')
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz
        'CMakeLists.diff')
# too many kdepim names, hardcode md5
pkg_shasum=('e85ae5d7793627d0275176b094689250'
         '2218a2df5d6f3fb09c0616a68e4e13f2')

do_prepare() {
  cd $pkg_name-${pkg_version}
  #sed -i 's|add_subdirectory(korganizer)|#add_subdirectory(korganizer)|' ${CACHE_PATH}/$pkg_name/CMakeLists.txt
  patch -p1 -i $CACHE_PATH/CMakeLists.diff
}

do_build() {
  mkdir build
  
  export CC=/usr/bin/clang
  export CXX=/usr/bin/clang++
  
  cd build 
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=FALSE
  make VERBOSE=1
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
