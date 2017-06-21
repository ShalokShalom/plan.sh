pkg_origin=cosmos

pkg_name=rpmextract
pkg_version=1.0
pkg_description="Script to convert or extract RPM archives (contains rpm2cpio)"
pkg_license=('GPL')
pkg_upstream_url="http://www.archlinux.org"
pkg_deps=('bash' 'libarchive' 'coreutils')
pkg_source=('rpmextract.sh' 'rpm2cpio')
pkg_shasum=('a7b527e4c210e66ef72532c606072e0d'
         '57a4e99bedcefadc2f89006ce98d2e60')

do_package() {
  install -d ${CACHE_PATH}/usr/bin
  install -m755 ${CACHE_PATH}/rpmextract.sh ${CACHE_PATH}/usr/bin/ 
  install -m755 ${CACHE_PATH}/rpm2cpio ${CACHE_PATH}/usr/bin/ 
}
