pkg_origin=

pkg_name=cvassistant
_pkg_name=CVAssistant
pkg_version=3.1.0
pkg_description="CV Assistant helps you create specialized resumes in Word .docx format fast and easy."
pkg_upstream_url='https://sourceforge.net/projects/cvassistant/?pkg_source=navbar'
pkg_license=('GPL')
pkg_deps=('qt5-base' 'zlib' 'quazip')
#pkg_build_deps=('qt5-tools')
pkg_source=("http://sourceforge.net/projects/cvassistant/files/${pkg_name}-${pkg_version}-src.tar.bz2"
        'pro.diff')
pkg_shasum=('1f14e91e090896feca3b037edf973e19'
         '47ecfa602ab70a588fa9c2c10ac5a802')

do_build() {
  cd ${pkg_name}-${pkg_version}-src
  #patch -p1 -i $CACHE_PATH/pro.diff
  sed -i -e 's|LIBS += -lquazip-qt5|LIBS += -lquazip5|' CVAssistant.pro
  sed -i -e 's|<quazip/quazipfile.h>|<quazip5/quazipfile.h>|' models/resumedocument.h
  sed -i -e 's|//#define NO_DONATION_PROMPT|#define NO_DONATION_PROMPT|' controllers/mainwindow.cpp
  
  /usr/lib/qt5/bin/qmake 
  make 
}

do_package() {
  cd ${pkg_name}-${pkg_version}-src

  make INSTALL_ROOT=${pkg_prefix} install
}
