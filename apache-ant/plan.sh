pkg_origin=cosmos

pkg_name=apache-ant
pkg_version=1.10.0
pkg_description="A java-based build tool."
pkg_license=('APACHE')
pkg_upstream_url="http://ant.apache.org/"
pkg_deps=('java-runtime')
pkg_deps=('junit: to have junit on the classpath in javac tasks')
pkg_source=("http://mirror.olnevhost.net/pub/apache//ant/binaries/${pkg_name}-${pkg_version}-bin.tar.bz2"
        "${pkg_name}.sh"
        "${pkg_name}.csh")
pkg_shasum=('ebb52b9556180c09d80a42ed7a0b519b'
         '593ee6ebd9b8ec321534a028e686880f'
         '475b684eb8202c09cbb51496cd8ee1e0')

do_package() {
  # profile.d scripts
  install -d -m755 ${pkg_prefix}/etc/profile.d
  install -m755 ${CACHE_PATH}/${pkg_name}.{csh,sh} ${pkg_prefix}/etc/profile.d

  # ANT_HOME env var
  source ${CACHE_PATH}/${pkg_name}.sh

  install -d -m755 ${pkg_prefix}/${ANT_HOME}/{bin,lib}

  install -m644 ./lib/*.jar ${pkg_prefix}/${ANT_HOME}/lib
  cp -Rp ./etc ${pkg_prefix}/${ANT_HOME}

  # Do not copy Windows .bat/.cmd files
  find ./bin -type f -a ! -name \*.bat -a ! -name \*.cmd \
    -exec install -m755 \{\} ${pkg_prefix}/${ANT_HOME}/bin \;

  install -d -m755 ${pkg_prefix}/usr/bin
  ln -s ${ANT_HOME}/bin/ant ${pkg_prefix}/usr/bin/ant

  # symlink to junit 
  ln -sf /usr/share/java/junit.jar ${pkg_prefix}/usr/share/java/apache-ant/lib


  #cd "${CACHE_PATH}/${pkg_name}-${pkg_version}"
  install -d -m755 ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 LICENSE NOTICE ${pkg_prefix}/usr/share/licenses/${pkg_name}
}

