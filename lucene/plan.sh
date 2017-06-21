pkg_origin=cosmos

pkg_name=lucene
pkg_version=2.9.4 # don't update to 3.x tree - OOo is not yet ready to use it
pkg_description="A high-performance, full-featured text search engine library written entirely in Java"
pkg_upstream_url="http://lucene.apache.org/java/docs/index.html"
pkg_license=("APACHE")
pkg_deps=('java-runtime')
pkg_source=("http://www.mirrorservice.org/sites/ftp.apache.org/lucene/java/$pkg_version/lucene-${pkg_version}.tar.gz")
pkg_shasum=('ffc60c3a163105b22610dec15602329a')

do_build() {
	/bin/true
}

do_package() {
  install -m755 -d ${pkg_prefix}/usr/share/java/

  # install all *.jar files
  for i in `find ${CACHE_PATH} -name '*.jar'`; do
    install $i ${pkg_prefix}/usr/share/java/
  done

  # create symlinks
  for i in `ls -1 *${pkg_version}*.jar`; do
    j=${i//-${pkg_version}/}
    ln -sv $i $j
  done
  
  # and one with different version numbering
  ln -sv servlet-api-2.4.jar servlet-api.jar
}
