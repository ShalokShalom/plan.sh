pkg_origin=cosmos

pkg_name=('openjdk' 'openjdk-src')
pkgbase='openjdk'
_icedtea_release="3.4.0"
_icedtea_jdkver="8"
# ${CACHE_PATH}/build/ChangeLog for versions
_openjdk_build="b12"
_pkg_version="8u131"
pkg_version="${_pkg_version}_${_openjdk_build}_${_icedtea_release}"
pkg_description="An open-source implementation of the seventh edition of the Java SE Platform."
pkg_upstream_url="http://icedtea.classpath.org/"
pkg_license=('GPL2 with Classpath exception')
pkg_build_deps=('java-environment=8' 'apache-ant>=1.6.5' 'zip' 'unzip'
             'fastjar' 'cpio' 'cups' 'gtk2' 'coreutils'
             'wget' 'gzip' 'alsa-lib' 'pulseaudio' 'zlib' 'libjpeg-turbo'
             'libpng' 'giflib' 'lcms2' 'freetype2' 'rhino' 'nss' 'libxt'
             'libxtst' 'libxp' 'libxrender' 'ca-certificates-java' 'eclipse-ecj' 'pcsclite')

_hg_pkg_upstream_url="http://icedtea.wildebeest.org/download/drops/icedtea8/${_icedtea_release}"
_jvmdir="/usr/lib/jvm/java-8-openjdk"

pkg_source=("http://icedtea.classpath.org/download/source/icedtea-${_icedtea_release}.tar.xz"
        ${_hg_url}/corba.tar.xz 
        ${_hg_url}/jaxp.tar.xz 
        ${_hg_url}/jaxws.tar.xz 
        ${_hg_url}/jdk.tar.xz 
        ${_hg_url}/langtools.tar.xz 
        ${_hg_url}/openjdk.tar.xz 
        ${_hg_url}/nashorn.tar.xz 
        ${_hg_url}/hotspot.tar.xz 
        'fontconfig-paths.diff'
        'corba_path.diff'
        'command_path.diff'
        'openjdk.profile.sh'
        'openjdk.profile.csh')
pkg_shasum=('0af777c25b01092c511262edf40f868b'
         '68b8c18562214486c971071ba59413e6'
         '7e4a9e896f4777fe96dd7e49ed507a0b'
         'df3c1b88db55fdd9b793714d40930f9f'
         '1d2130aaeb5b7546f70564e963a68379'
         '9c7688f164d62d13b4f36e0db379d4c4'
         '89f287e08058534ed5bf9198d025500f'
         '65805818ca9ea2af450ac6265e90d509'
         'b4d1be014037928badc0a28644511663'
         'ee1afda124d5927345014ab382ef581e'
         '986131efd2636724ae37870a5cca6d43'
         '05afd9c7fedcc05d4ebbb3427e068dba'
         '2113e8e67f7e11b925b366614721a3dc'
         'd703a04c47c961b16154974b46cab12d')
noextract=("openjdk.tar.xz"
           "corba.tar.xz"
           "jaxp.tar.xz"
           "jaxws.tar.xz"
           "jdk.tar.xz"
           "nashorn.tar.xz"
           "langtools.tar.xz"
           "hotspot.tar.xz")

do_build() {

  # Prepare the patches
  #cp *.diff "${CACHE_PATH}/icedtea-${_icedtea_release}/patches"
  #export DISTRIBUTION_PATCHES="patches/fontconfig-paths.diff \
  #                             patches/corba_path.diff \
  #                             patches/command_path.diff"
  #                             patches/openjdk7_nonreparenting-wm.diff

  rm -rf build
  cp -r "icedtea-${_icedtea_release}" \
        "${CACHE_PATH}/build"


  . /etc/profile.d/apache-ant.sh

  # Start the configuration and build step
  ./configure --prefix=/usr \
              --with-parallel-jobs="${MAKEFLAGS/-j}" \
              --host="x86_64-unknown-linux-gnu" \
              --with-jdk-home="${JAVA_HOME}" \
              --with-openjdk-src-zip="${CACHE_PATH}/openjdk.tar.xz" \
              --with-hotspot-src-zip="${CACHE_PATH}/hotspot.tar.xz" \
              --with-corba-src-zip="${CACHE_PATH}/corba.tar.xz" \
              --with-jaxp-src-zip="${CACHE_PATH}/jaxp.tar.xz" \
              --with-jaxws-src-zip="${CACHE_PATH}/jaxws.tar.xz" \
              --with-jdk-src-zip="${CACHE_PATH}/jdk.tar.xz" \
              --with-nashorn-src-zip="${CACHE_PATH}/nashorn.tar.xz" \
              --with-langtools-src-zip="${CACHE_PATH}/langtools.tar.xz" \
              --with-pkg_versionsion="Linux build ${pkg_version}-${pkgrel}-x86_64" \
              --disable-tests \
              --disable-downloading \
              --disable-Werror \
              --disable-bootstrap \
              --enable-nss \
              --disable-system-sctp
  make
}

package_openjdk() {
pkg_description="An open-source implementation of the Java SE Platform."
pkg_deps=('alsa-lib' 'pulseaudio' 'giflib' 'libjpeg-turbo' 'libpng' 'freetype2'
         'ca-certificates-java')
pkg_deps=('icedtea-web: web browser plugin and Java Web Start support'
            'gtk2: for the GTK+ Look And Feel')


  # Copy the built OpenJDK image to the target directory
  install -d -m755 "${pkg_prefix}/${_jvmdir%/*}"
  cp -r "openjdk.build/images/j2sdk-image" \
        "${pkg_prefix}/${_jvmdir#/}"
  # permissions are not preserved
  find "${pkg_prefix}/${_jvmdir#/}" \! -type l \( -perm /111 -exec chmod 755 {} \; -o -exec chmod 644 {} \; \)
  
  # Remove the .zip file which is going to be inside openjdk-src
  rm "${pkg_prefix}/${_jvmdir#/}/src.zip"

  # Symlink the binaries into /usr/bin
  install -d -m755 "${pkg_prefix}/usr/bin"
  pushd "${pkg_prefix}/${_jvmdir#/}/bin" >/dev/null
    for executable in *; do
      ln -s "${_jvmdir}/bin/${executable}" \
            "${pkg_prefix}/usr/bin"
    done
  popd >/dev/null

  # Move the manual pages in the right place
  install -d -m755 "${pkg_prefix}"/usr/share/man/{,ja/}man2/
  mv "${pkg_prefix}"/${_jvmdir#/}/man/man1/* \
     "${pkg_prefix}"/usr/share/man/man2/
  mv "${pkg_prefix}"/${_jvmdir#/}/man/ja_JP.UTF-8/* \
     "${pkg_prefix}"/usr/share/man/ja

  # link JKS keystore from ca-certificates-java
  rm -f "${pkg_prefix}/${_jvmdir#/}/jre/lib/security/cacerts"
  ln -s /etc/ssl/certs/java/cacerts \
        "${pkg_prefix}/${_jvmdir#/}/jre/lib/security/cacerts"

  # Setup the shell profile dropin configuration
  install -D -m755 "${CACHE_PATH}/openjdk.profile.sh" \
                   "${pkg_prefix}/etc/profile.d/openjdk.sh"
  install -D -m755 "${CACHE_PATH}/openjdk.profile.csh" \
                   "${pkg_prefix}/etc/profile.d/openjdk.csh"

  # Install the license file
  install -D -m644 "openjdk/LICENSE" \
                   "${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE"
}

package_openjdk-src() {
pkg_description="An open-source implementation of the Java SE Platform. (Source package)"
pkg_deps=("openjdk=${pkg_version}")


  # Install the source package
  install -D -m644 "openjdk.build/images/j2sdk-image/src.zip" \
                   "${pkg_prefix}/${_jvmdir#/}/src.zip"
}

