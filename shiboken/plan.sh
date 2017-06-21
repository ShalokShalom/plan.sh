pkg_origin=cosmos

pkg_name=shiboken
_pkg_name=pyside2-setup
pkg_version=2.0.0
_commit=a3e4e367cf462e2dd9d7b08fe8d3f0007c33e1fa
pkg_description="Plugin (front-end) for Generator Runner. It generates bindings for C++ libraries using CPython source code"
pkg_license=('LGPL')
pkg_upstream_url="http://code.qt.io/cgit/pyside/shiboken.git/tree/README.md"
pkg_deps=('python2' 'qt5-xmlpatterns' 'libxslt')
pkg_build_deps=('cmake' 'clang' 'python2-sphinx')
#pkg_source=("git://code.qt.io/pyside/pyside-setup.git")
pkg_source=("https://github.com/pyside/pyside2-setup/archive/${_commit}.zip")
pkg_shasum=('a9361ee65a65c6211c0f2215a2758b66')


do_build(){
    mkdir -p build
    
    cmake ../ \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_TESTS=OFF \
        -DUSE_PYTHON_VERSION=2
    make
}

do_package(){
    
    make DESTDIR=${CACHE_PATH} install
}

