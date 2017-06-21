pkg_origin=

pkg_name=fluid
pkg_version=0.10.0
_commit=e606f03c49368adc0bb186001ea46ebf85983256
pkg_upstream_url='https://github.com/lirios/fluid'
pkg_description="Modules for fluid and dynamic applications development with QtQuick."
pkg_license=('LGPL')
pkg_deps=('qt5-quickcontrols2' 'qt5-graphicaleffects' 'qt5-svg' 'ttf-google-fonts')
pkg_build_deps=('git' 'qtcreator')
#pkg_source=("https://github.com/lirios/fluid/releases/download/v${pkg_version}/fluid-${pkg_version}.tar.xz") 
#pkg_source=("https://github.com/lirios/fluid/archive/${_commit}.zip")
pkg_source=("git://github.com/lirios/fluid.git")
pkg_shasum=('SKIP')

do_prepare() {
  cd ${pkg_name}
  
  git submodule update --init
}

do_build() {
  cd ${pkg_name}
  
  qbs setup-toolchains --type gcc /usr/bin/g++ gcc
  qbs setup-qt /usr/lib/qt5/bin/qmake qt5
  qbs config profiles.qt5.baseProfile gcc
  qbs build --no-install -d build profile:qt5 qbs.installRoot:/ qbs.installPrefix:usr lirideployment.qmlDir:lib/qt5/qml
}

do_package() {
  cd ${pkg_name}
  
  qbs install -d build --no-build -v --install-root ${pkg_prefix} profile:qt5
}
