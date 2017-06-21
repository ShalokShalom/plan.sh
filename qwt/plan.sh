pkg_origin=cosmos
# keep at 5 series, unless smokeqt is ready for newer

pkg_name=qwt
pkg_version=6.1.3
pkg_description="Qt Widgets for Technical Applications"
pkg_upstream_url="http://qwt.sourceforge.net/"
pkg_deps=('qt5-base' 'qt5-svg')
pkg_build_deps=('qt5-tools')
pkg_license=("custom:$pkg_name")
pkg_source=("http://downloads.sourceforge.net/sourceforge/qwt/$pkg_name-$pkg_version.tar.bz2" 
        "qwtconfig.pri")
pkg_shasum=('19d1f5fa5e22054d22ee3accc37c54ba'
         '1091f53d0f5905378be0b10312a642ac')

do_build() {

  # needed config file 
  install -Dm644 ${CACHE_PATH}/qwtconfig.pri ${CACHE_PATH}/${pkg_name}-${pkg_version}/qwtconfig.pri

  /usr/lib/qt5/bin/qmake qwt.pro
  make
}

do_package() {
  make INSTALL_ROOT=${CACHE_PATH} QTDIR=/usr install

  mv -f ${CACHE_PATH}/usr/share/doc/qwt/man/ ${CACHE_PATH}/usr/share/

  install -Dm644 ${CACHE_PATH}/${pkg_name}-${pkg_version}/COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/license.txt
}
