pkg_origin=

pkg_name=qml-box2d
pkg_version=0.1
_commit=fb35cf18fc74b1b68b353605c9799d08adaa81f9
pkg_description="Expose the functionality of Box2D as QML components, in order to make it easy to write physics based games in QML."
pkg_upstream_url="https://github.com/qml-box2d/qml-box2d"
pkg_license=('LGPL')
pkg_deps=('qt5-declarative')
pkg_source=("https://github.com/qml-box2d/qml-box2d/archive/${_commit}.zip")
pkg_shasum=('830c5ff6c677bb45ff529f2cea0289f9')

do_build() {
   cd $pkg_name-${_commit}

   /usr/lib/qt5/bin/qmake 
   make
}

do_package() {
   cd $pkg_name-${_commit}
   
   make INSTALL_ROOT=$pkg_prefix install
}
