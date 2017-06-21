pkg_origin=cosmos

pkg_name=beanshell
pkg_version=2.1.8
pkg_description="Small, source level Java interpreter with object based scripting language features written in Java"
pkg_upstream_url="https://code.google.com/p/beanshell2/"
pkg_license=('LGPL')
pkg_deps=('java-runtime')
pkg_source=("https://github.com/pejobo/beanshell2/blob/v2.1/downloads/bsh-${pkg_version}.jar?raw=true")
noextract=("${pkg_name}-${pkg_version}.jar?raw=true")
pkg_shasum=('86da39aefd9ab3da7167f141083009ea')

do_package() {
  install -m755 -d ${pkg_prefix}/usr/share/java/
  install -D -m644 ${CACHE_PATH}/bsh-${pkg_version}.jar?raw=true ${pkg_prefix}/usr/share/java/bsh.jar
}
