pkg_origin=cosmos
 
pkg_name=pythonqt
_pkg_name=PythonQt
pkg_version=3.2
_pkg_version=code-450-trunk
pkg_description='Dynamic Python binding for the Qt framework.'
pkg_upstream_url='http://pythonqt.sourceforge.net/'
pkg_license=('LGPL2.1')
pkg_deps=('python3' 'qt5-declarative' 'qt5-multimedia' 'qt5-svg' 'qtwebkit-tp')
pkg_build_deps=('qt5-tools')
#pkg_source=("https://sourceforge.net/projects/pythonqt/files/pythonqt/${_pkg_name}-${pkg_version}/${_pkg_name}${pkg_version}.zip")
pkg_source=("https://sourceforge.net/code-snapshots/svn/p/py/pythonqt/code/pythonqt-${_pkg_version}.zip")
pkg_shasum=('e827a6608c5a85fe91960e5208ae630a')

do_build() {

    sed -i -e "s|unix:PYTHON_VERSION=2.7|unix:PYTHON_VERSION=3.6|" build/python.prf
    
    /usr/lib/qt5/bin/qmake CONFIG+=release
    make
}

do_package() {

    mkdir -p ${CACHE_PATH}/usr/include/PythonQt/{gui,extensions/PythonQt_QtAll}
    cp src/*.h ${CACHE_PATH}/usr/include/PythonQt
    cp src/gui/*.h ${CACHE_PATH}/usr/include/PythonQt/gui
    cp extensions/PythonQt_QtAll/*.h ${CACHE_PATH}/usr/include/PythonQt/extensions/PythonQt_QtAll

    cp -Rd lib ${CACHE_PATH}/usr
    
    install -Dm644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
