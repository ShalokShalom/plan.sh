pkg_origin=cosmos

pkg_name=rhino
pkg_version=1.7.7.1
pkg_description="Open-source implementation of JavaScript written entirely in Java"
pkg_upstream_url="http://www.mozilla.org/rhino/"
pkg_license=('MPL' 'GPL2')
pkg_source=("https://github.com/mozilla/rhino/releases/download/Rhino1_7_7_1_RELEASE/rhino-${pkg_version}.zip")
pkg_shasum=('84428130578f1d86ad9bf7230447b99d')

do_package() {
  install -m755 -d ${CACHE_PATH}/usr/share/java
  install -m644 lib/rhino-${pkg_version}.jar ${CACHE_PATH}/usr/share/java/js.jar 
}
