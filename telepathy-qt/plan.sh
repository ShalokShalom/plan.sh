pkg_origin=cosmos

pkg_name=telepathy-qt
pkg_version=0.9.6
pkg_description="A library for Qt-based Telepathy clients."
pkg_upstream_url="http://telepathy.freedesktop.org"
pkg_license=('LGPL')
pkg_deps=('qt' 'telepathy-farstream' 'dbus-python')
pkg_build_deps=('libxslt' 'python2' 'cmake' 'doxygen')
pkg_source=("http://telepathy.freedesktop.org/releases/telepathy-qt/$pkg_name-$pkg_version.tar.gz")
#pkg_source=("https://github.com/davidedmundson/telepathy-qt.git")
pkg_shasum=('1f18935f30dcf90282a2d6d65fcde752')

do_build() {
    #git clone -b farstream-0.2-port https://github.com/davidedmundson/telepathy-qt.git

    mkdir build
    cmake ../${pkg_name}-$pkg_version \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr
    make
}

do_package() {
    
    make DESTDIR=$CACHE_PATH install
}
