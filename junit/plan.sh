pkg_origin=cosmos

pkg_name=junit
pkg_version=4.12
pkg_description="Automated testing framework for Java"
pkg_upstream_url="http://www.junit.org/"
pkg_license=('CPL')
pkg_deps=('java-runtime' 'hamcrest')
#pkg_build_deps=('apache-ant' 'git')
pkg_source=("https://github.com/junit-team/junit/releases/download/r${pkg_version}/${pkg_name}-${pkg_version}.jar"
        'Manifest.txt')
pkg_shasum=('5b38c40c97fbd0adee29f91e60405584'
         '165500a4fcda0cdd6cff5256301d3702')

do_package() {
  
  install -Dm644 ${CACHE_PATH}/${pkg_name}-${pkg_version}.jar \
                 ${pkg_prefix}/usr/share/java/${pkg_name}-${pkg_version}.jar
  ln -s ${pkg_name}-${pkg_version}.jar ${pkg_prefix}/usr/share/java/${pkg_name}.jar
}

