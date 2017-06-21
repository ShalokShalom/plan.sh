pkg_origin=cosmos

pkg_name=hamcrest
pkg_version=1.3
pkg_description='Java matcher objects library'
pkg_upstream_url='http://hamcrest.org/'
pkg_license=('BSD')
pkg_deps=('java-runtime')
pkg_source=("https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/hamcrest/${pkg_name}-core-${pkg_version}.jar"
        "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/hamcrest/${pkg_name}-library-${pkg_version}.jar"
        "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/hamcrest/${pkg_name}-generator-${pkg_version}.jar"
        "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/hamcrest/${pkg_name}-integration-${pkg_version}.jar"
        'LICENSE.txt')
noextract=(${pkg_name}-core-${pkg_version}.jar
           ${pkg_name}-library-${pkg_version}.jar
           ${pkg_name}-generator-${pkg_version}.jar
           ${pkg_name}-integration-${pkg_version}.jar)
pkg_shasum=('6393363b47ddcbba82321110c3e07519'
         '110ad2ea84f7031a1798648b6b318e79'
         '233ae0a7fe7b99c1ffd09ebcf63cb15c'
         'c145982b549171841ead95bd2fee78ce'
         'c611913dcf6a4b5fca65cf4da77c3dc8')

do_package() {

  install -dm755 ${pkg_prefix}/usr/share/java/${pkg_name}
  for j in core library generator integration; do
    cp ${pkg_name}-${j}-${pkg_version}.jar ${pkg_prefix}/usr/share/java/${pkg_name}/${j}-${pkg_version}.jar
    ln -s ${j}-${pkg_version}.jar ${pkg_prefix}/usr/share/java/${pkg_name}/${j}.jar
    ln -s ${pkg_name}/${j}-${pkg_version}.jar ${pkg_prefix}/usr/share/java/${pkg_name}-${j}.jar
  done

  install -Dm644 LICENSE.txt ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
