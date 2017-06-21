pkg_origin=

pkg_name=scala
pkg_version=2.12.2
pkg_description="Acronym for Scalable Language, running on the JVM. Java and Scala classes"
pkg_upstream_url="https://www.scala-lang.org"
pkg_license=('custom')
pkg_deps=('sh' 'java-environment')
pkg_source=("https://www.scala-lang.org/files/archive/scala-$pkg_version.tgz")
pkg_shasum=('fb1d385259bbb9c4f22f3976ebe2b657')

do_package() {
  cd ${CACHE_PATH}/scala-${pkg_version}

  install -d ${pkg_prefix}/usr/{bin,share} ${pkg_prefix}/usr/share/man/man1 ${pkg_prefix}/usr/share/scala/{bin,lib}
  cp -r lib ${pkg_prefix}/usr/share/scala/
  cp -r man ${pkg_prefix}/usr/share/
  install -m 755 bin/{fsc,scala,scalac,scalap,scaladoc} ${pkg_prefix}/usr/share/scala/bin
  install -D -m0644 doc/LICENSE.md ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
  ln -s ../share/scala/bin/fsc ${pkg_prefix}/usr/bin/fsc
  ln -s ../share/scala/bin/scala ${pkg_prefix}/usr/bin/scala
  ln -s ../share/scala/bin/scalac ${pkg_prefix}/usr/bin/scalac
  ln -s ../share/scala/bin/scalap ${pkg_prefix}/usr/bin/scalap
  ln -s ../share/scala/bin/scaladoc ${pkg_prefix}/usr/bin/scaladoc
}
