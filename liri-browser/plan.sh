pkg_origin=

pkg_name=liri-browser
pkg_version=0.3.125
_commit=d70687416f99e979da1e68834a220a9f95c662d1
pkg_description="Cross-platform material design web browser"
pkg_upstream_url="https://github.com/lirios/browser"
pkg_license=('GPLv3')
pkg_deps=('qtwebengine' 'qt5-multimedia' 'fluid' 'qt5-svg' 'qt5-location' 'quazip')
pkg_build_deps=('qtcreator' 'git')
#pkg_source=("https://github.com/lirios/browser/archive/${_commit}.zip")
pkg_source=("git://github.com/lirios/browser.git")
pkg_shasum=('SKIP')

do_prepare() {
  cd browser
  git submodule update --init

  # settings
  sed -i -e 's|SearchEngine::DuckDuckGo|SearchEngine::Google|' src/core/settings/searchconfig.cpp
  sed -i -e 's|{"engine", "duckduckgo"}|{"engine", "google"}|' src/core/settings/settings.cpp
  sed -i -e 's|QUrl("https://duckduckgo.com")|QUrl("https://www.google.com")|' src/core/settings/startconfig.cpp
  #sed -i -e 's|property bool darkTheme: true|property bool darkTheme: false|' ${CACHE_PATH}/${pkg_name}/src/qml/BaseApplication.qml
  #KaOS colors
  #sed -i -e 's|primaryColor: "#F44336"|primaryColor: "#31A3DD"|' ${CACHE_PATH}/${pkg_name}/src/qml/BrowserWindow.qml
  #sed -i -e 's|primaryDarkColor: "#D32F2F"|primaryDarkColor: "#2397D2"|' ${CACHE_PATH}/${pkg_name}/src/qml/BrowserWindow.qml
  #sed -i -e 's|accentColor: "#FF5722"|accentColor: "#31A3DD"|' ${CACHE_PATH}/${pkg_name}/src/qml/BrowserWindow.qml
  #sed -i -e 's|darkThemeColor : "#f3f3f3"|darkThemeColor : "#CCCCCC"|' ${CACHE_PATH}/${pkg_name}/src/qml/BrowserWindow.qml
  #sed -i -e 's|lightThemeColor: "#FAFAFA"|lightThemeColor: "#E8EFF7"|' ${CACHE_PATH}/${pkg_name}/src/qml/BaseApplication.qml
}

do_build() {
    cd browser

    qbs setup-toolchains --type gcc /usr/bin/g++ gcc
    qbs setup-qt /usr/lib/qt5/bin/qmake qt5
    qbs config profiles.qt5.baseProfile gcc
    qbs build --no-install -d build profile:qt5 qbs.installRoot:/ qbs.installPrefix:usr
}

do_package() {
   cd browser
   
   qbs install -d build --no-build -v --install-root ${pkg_prefix} profile:qt5
}
