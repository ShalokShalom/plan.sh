pkg_origin=cosmos

pkg_name=telepathy-qt5
_pkg_name=telepathy-qt
pkg_version=0.9.7
pkg_description="A library for Qt-based Telepathy clients."
pkg_upstream_url="http://telepathy.freedesktop.org"
groups=('telepathy')
pkg_license=('LGPL')
pkg_deps=('qt5-base' 'telepathy-farstream' 'dbus-python')
pkg_build_deps=('libxslt' 'python2' 'cmake' 'doxygen')
pkg_source=("http://telepathy.freedesktop.org/releases/telepathy-qt/$_pkg_name-$pkg_version.tar.gz")
#pkg_source=("git://anongit.freedesktop.org/telepathy/telepathy-qt")
pkg_shasum=('86470dd3d7f6de8b8f4f36165486d42f')

do_prepare() {
  
  #sed -i -e 's|add_definitions(-D_BSD_SOURCE)|add_definitions(-D_BSD_SOURCE -D_DEFAULT_SOURCE)|' ${CACHE_PATH}/${_pkg_name}-${pkg_version}/cmake/modules/TelepathyDefaults.cmake
}

do_build() {
    mkdir -p build
    
    cmake ../${_pkg_name}-${pkg_version} \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DQT_QMAKE_EXECUTABLE=/usr/lib/qt5/bin/qmake \
        -DQT_INCLUDES=/usr/include/qt5 \
        -DQT_LIBRARIES=/usr/lib \
        -DDESIRED_QT_VERSION=5 \
        -DENABLE_EXAMPLES=OFF \
        -DENABLE_TESTS=false 
        #-DENABLE_EXPERIMENTAL_SERVICE_SUPPORT=ON
    make
}

do_package() {
    
    make DESTDIR=$CACHE_PATH install
}
