pkg_origin=cosmos

pkg_name=mirror-check
pkg_version=2.4
pkg_description="Checks whether the locally used mirror is synced with the main mirror"
pkg_upstream_url="https://kaosx.us"
pkg_license=('GPL2')
pkg_build_deps=('asciidoc')
pkg_source=('mirror-check'
        'mirror-check.desktop')
        #'mirror-check.svg')
pkg_shasum=('4dd1cf2df57dfcdb78b8279db0546c19'
         'aff18a3883a298752fac09d3ce096429')

do_package() {
  cd ${CACHE_PATH}

  install -m 755 -D mirror-check "$pkg_prefix/usr/bin/mirror-check"
  #install -Dm644 "${CACHE_PATH}/mirror-check.desktop" "${pkg_prefix}/usr/share/applications/mirror-check.desktop"
  #install -Dm644 "${CACHE_PATH}/mirror-check.svg" "${pkg_prefix}/usr/share/pixmaps/mirror-check.svg"
}
