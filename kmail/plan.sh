pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kmail
pkg_version=${_kdever}
pkg_description="Email client, supporting POP3 and IMAP mailboxes."
pkg_upstream_url='https://github.com/KDE/kmail'
pkg_license=('LGPL')
pkg_deps=('kcrash' 'kbookmarks' 'kcodecs' 'kconfig' 'kconfigwidgets' 'kdbusaddons' 'kguiaddons' 'ki18n' 'kitemviews'
         'kjobwidgets' 'kio' 'kcmutils' 'knotifications' 'knotifyconfig' 'kparts' 'kservice' 'sonnet'
         'ktextwidgets' 'kwidgetsaddons' 'kwindowsystem' 'kxmlgui' 
         'akonadi' 'akonadi-contacts' 'akonadi-mime' 'kcontacts' 'kcalcore' 'kcalutils' 'kidentitymanagement'
         'kldap' 'kmailtransport' 'kpimtextedit' 'kontactinterface' 'kmime' 'libgravatar' 'kdepim-apps-libs'
         'libkdepim' 'libkleo' 'libksieve' 'mailcommon' 'messagelib' 'pimcommon'
         'qtwebengine' 'gpgme' 'kdepim-addons'
         'akonadi-import-wizard' 'grantlee-editor' 'kmail-account-wizard' 'mbox-importer' 'pim-data-exporter'
         'pim-sieve-editor')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz)
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build 
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
