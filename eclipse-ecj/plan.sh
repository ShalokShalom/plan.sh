pkg_origin=cosmos

pkg_name=eclipse-ecj
pkg_version=4.6.3
_date=201703010400
pkg_description='Eclipse java bytecode compiler'
pkg_license=('EPL')
pkg_upstream_url='http://www.eclipse.org/'
pkg_deps=('java-runtime')
pkg_build_deps=('apache-ant' 'java-environment')
pkg_source=("http://download.eclipse.org/eclipse/downloads/drops4/R-${pkg_version}-${_date}/ecjsrc-${pkg_version}.jar"
        '01-ecj-include-props.patch'
        '02-buildxml-fix-manifest.patch'
        'ecj')
pkg_shasum=('b7936c49962a505a7cb5cd091f3fd2d6'
         '01cb1036969700ebd1b85a417d6d4a0e'
         'b23452f46edf0b2662b5b5865776d319'
         '997d67f1d3e97f65e42e8ace7aba7260')

do_build() {
  patch -p0 -i ${CACHE_PATH}/01-ecj-include-props.patch
  patch -p0 -i ${CACHE_PATH}/02-buildxml-fix-manifest.patch
  export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8
  
  ant build
}

do_package() {
  install -Dm644 ${CACHE_PATH}/ecj.jar ${pkg_prefix}/usr/share/java/eclipse-ecj-${pkg_version}.jar
  
  ln -s eclipse-ecj-${pkg_version}.jar ${pkg_prefix}/usr/share/java/ecj.jar
  ln -s eclipse-ecj-${pkg_version}.jar ${pkg_prefix}/usr/share/java/eclipse-ecj.jar
  
  install -Dm755 ecj ${pkg_prefix}/usr/bin/ecj
}
