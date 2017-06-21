pkg_origin=

pkg_name=jitsi
pkg_version=2.10.5550
pkg_description="An audio/video SIP VoIP phone and instant messenger written in Java (formerly SIP-Communicator)"
pkg_upstream_url="http://jitsi.org"
pkg_license=('LGPL')
pkg_deps=('java-runtime' 'gtk2')
pkg_build_deps=('apache-ant' 'java-environment')
pkg_source=("http://download.jitsi.org/jitsi/src/jitsi-src-${pkg_version}.zip"
	'jitsi.desktop'
	'jitsi.sh')
pkg_shasum=('dc512fbf49a6056099917ff9ae8f3315'
         'aad7cf1fb18ff5d7c964834ecc38aed8'
         'ab1953a6442b685c7acb3c79b630a495')

do_build()
{
  cd "${CACHE_PATH}/${pkg_name}"
  # append the build revision to the jitsi version
  sed -i "s/0\.build\.by\.SVN/build.${pkg_version}/" src/net/java/sip/communicator/impl/version/NightlyBuildID.java
  . /etc/profile.d/apache-ant.sh
  ant rebuild
}

do_package() {
  cd "${CACHE_PATH}/${pkg_name}"
  find lib/ lib/bundle/ -maxdepth 1 -type f \
    -exec install -Dm644 {} "${pkg_prefix}/usr/lib/${pkg_name}/"{} \;
  #find lib/os-specific/linux/ -maxdepth 1 -type f -execdir install -Dm644 {} "${pkg_prefix}/usr/lib/${pkg_name}/lib/"{} \;
  shopt -sq extglob
  find lib/native/linux$(sed 's/_/-/g' <<<${CARCH/#*(i?86|x86)/})/ -maxdepth 1 -type f \
    -execdir install -Dm644 {} "${pkg_prefix}/usr/lib/${pkg_name}/lib/native/"{} \;
  find sc-bundles/{,os-specific/linux/} -maxdepth 1 -type f \
    -execdir install -Dm644 {} "${pkg_prefix}/usr/lib/${pkg_name}/sc-bundles/"{} \;
  install -Dm755 "${CACHE_PATH}/${pkg_name}.sh" "${pkg_prefix}/usr/bin/${pkg_name}"
  install -Dm644 "${CACHE_PATH}/${pkg_name}.desktop" "${pkg_prefix}/usr/share/applications/${pkg_name}.desktop"

  cd "resources/install/debian/"
  for _file in *.{svg,xpm}; do
    install -Dm644 "$_file" "${pkg_prefix}/usr/share/pixmaps/${_file}"
  done
}
