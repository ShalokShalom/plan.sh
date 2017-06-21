pkg_origin=

pkg_name=rekonq
pkg_version=2.9.95
pkg_description='A WebKit based web browser for KDE'
pkg_upstream_url='http://rekonq.sourceforge.net/'
pkg_license=('GPL')
pkg_deps=('kauth' 'kbookmarks' 'kcmutils' 'kcompletion' 'kcoreaddons'  'kdbusaddons' 'kdewebkit'
         'kglobalaccel' 'ki18n' 'kiconthemes' 'kinit' 'kio' 'knotifications' 'kparts' 'kservice' 'kwallet'
         'kwindowsystem' 'kxmlgui' 'qca-qt5' 'qt5-webkit' 'sonnet')
pkg_build_deps=('extra-cmake-modules' 'git' 'kdoctools')
pkg_source=("git://anongit.kde.org/rekonq.git#branch=frameworks"
        'background.diff')
pkg_shasum=('SKIP'
         'bddb916790c3838135d9a5b6cb9f4580')

do_build() {
  cd $pkg_name
  #sed -i -e 's/KF5 CONFIG REQUIRED/KF5 REQUIRED/' ${CACHE_PATH}/${_pkg_name}/CMakeLists.txt
  patch -p1 -i ${CACHE_PATH}/background.diff
  mkdir build
  
  cd build
  cmake -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE=Release \
        -DLIB_INSTALL_DIR=lib \
        -DSYSCONF_INSTALL_DIR=/etc \
        -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
        -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
        -DBUILD_TESTING=OFF ..
  make
}

do_package() {
  cd $pkg_name/build
  
  make DESTDIR="$pkg_prefix" install
}

