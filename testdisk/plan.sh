pkg_origin=cosmos

pkg_name=testdisk
pkg_version=7.1
pkg_description="Checks and undeletes partitions + PhotoRec, signature based recovery tool"
pkg_upstream_url="http://www.cgsecurity.org/index.html?testdisk.html"
pkg_license=('GPL')
pkg_deps=('libjpeg' 'openssl' 'progsreiserfs' 'ntfs-3g' 'qt5-base')
pkg_build_deps=('pkgconfig' 'qt5-tools')
pkg_source=("http://www.cgsecurity.org/${pkg_name}-${pkg_version}-WIP.tar.bz2")
pkg_shasum=('6a3b605122c63374081528e6e2752f8a')

do_build() {
  sed -i 's|Exec=/usr/bin/qphotorec %F|Exec=kdesu /usr/bin/qphotorec %F|g' linux/qphotorec.desktop
  
  # Qt5 changes
  sed -i '/<QWidget>/d' src/*.h
  sed -i '/<QWidget>/d' src/*.cpp
  sed -i 's/Qt::escape\(.*\)text())/QString\1text()).toHtmlEscaped()/g' src/qphotorec.cpp
  
  sed -i 's|qt4|qt5|g' configure
  
  CXXFLAGS="-std=c++11"

  export QTGUI_LIBS="$(pkg-config Qt5Widgets --libs)"
  export QTGUI_CFLAGS="-fPIC $(pkg-config Qt5Widgets --cflags)"
  ./configure --prefix=/usr \
              --without-ewf \
              --enable-sudo
  make
}

do_package() {
  
  make DESTDIR=$CACHE_PATH install
}

  
