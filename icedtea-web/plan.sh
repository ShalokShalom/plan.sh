pkg_origin=

pkg_name=icedtea-web
pkg_description="Provides a Free Software web browser plugin running applets written in the Java programming
         language and an implementation of Java Web Start, originally based on the NetX project."
pkg_version=1.6.2
pkg_upstream_url="http://icedtea.classpath.org/wiki/IcedTea-Web"
pkg_license=('GPL2')
pkg_deps=('openjdk' 'desktop-file-utils')
pkg_build_deps=('zip' 'npapi-sdk' 'rhino' 'junit' 'cups' 'mercurial' 'firefox')
pkg_source=("hg+http://icedtea.classpath.org/hg/icedtea-web")
#noextract="${pkg_name}-$pkg_version.tar.gz"
pkg_shasum=('SKIP')

_javaver=8
_jvmdir="/usr/lib/jvm/java-${_javaver}-openjdk"

do_build() {
  #cd ${CACHE_PATH}
  #LANG=en_US.UTF-8 bsdtar -x -f ${CACHE_PATH}/${pkg_name}-${pkg_version}.tar.gz
  
  cd ${CACHE_PATH}/${pkg_name}*

  ./autogen.sh
  ./configure --prefix="${_jvmdir}" \
              --with-jdk-home="${_jvmdir}" \
              --datarootdir=/usr/share \
              --disable-docs 
  make
}

do_check() {
  cd ${CACHE_PATH}/${pkg_name}*

  #make -k check 
}

do_package() {
  cd ${CACHE_PATH}/${pkg_name}*

  # possible make target (see bottom of Makefile.am: install-exec-local install-data-local
  make install-exec-local install-data-local DESTDIR="${pkg_prefix}"

  # Install desktop files.
  install -m755 -d "${pkg_prefix}/usr/share"/{applications,pixmaps}
  install -m644 javaws.png "${pkg_prefix}/usr/share/pixmaps"
  install -m644 {javaws,itweb-settings}.desktop "${pkg_prefix}/usr/share/applications"

  # link binaries into /usr/bin + jre/bin
  install -m755 -d "${pkg_prefix}/usr/bin"
  install -m755 -d "${pkg_prefix}/${_jvmdir}/jre/bin"
  pushd "${pkg_prefix}/${_jvmdir}/bin"
    for file in *; do
      ln -sf "${_jvmdir}/bin/${file}" "${pkg_prefix}/usr/bin"
      ln -sf "${_jvmdir}/bin/${file}" "${pkg_prefix}/${_jvmdir}/jre/bin"
    done
  popd

  # link the mozilla-plugin - test it here http://www.java.com/en/download/help/testvm.xml
  install -m755 -d "${pkg_prefix}/usr/lib/mozilla/plugins/"
  ln -sf "${_jvmdir}/lib/IcedTeaPlugin.so" "${pkg_prefix}/usr/lib/mozilla/plugins/"
}

