pkg_origin=

pkg_name=kdeplasma-applets-yahoo-weather
_pkg_name=com.librehat.yahooweather
pkg_version=5.2.0
_commit=7c063fc
pkg_description="Yahoo! Weather Widget written in QML."
pkg_upstream_url="https://www.kde-look.org/p/998912/"
pkg_license=('GPL')
pkg_deps=('plasma-framework')
pkg_build_deps=('git' 'zip')
install=$pkg_name.install
pkg_source=("https://github.com/librehat/${_pkg_name}/tarball/master/${_pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('491d93ea191bd91f11200aa0479bc08b')

do_build() {
  cd librehat-${_pkg_name}-${_commit}/
  
  ./mkplasmoid.sh 
}

do_package() {
  cd librehat-${_pkg_name}-${_commit}/
  
  mkdir -p ${pkg_prefix}/usr/share/plasma/plasmoids/${_pkg_name}
  mv plasmoid/contents ${pkg_prefix}/usr/share/plasma/plasmoids/${_pkg_name}/
  install -D -m644 plasmoid/metadata.desktop ${pkg_prefix}/usr/share/plasma/plasmoids/${_pkg_name}/
  
  mkdir -p ${pkg_prefix}/usr/share/licenses/${pkg_name}/
  install -D -m644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
