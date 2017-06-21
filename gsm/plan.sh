pkg_origin=cosmos

pkg_name=gsm
pkg_version=1.0.16
_pkg_version=1.0-pl16
pkg_description="Shared libraries for GSM 06.10 lossy speech compression"
pkg_upstream_url="http://www.quut.com/gsm/"
pkg_license=('custom')
pkg_deps=('glibc')
pkg_source=("http://www.quut.com/gsm/${pkg_name}-${pkg_version}.tar.gz"
        'gsm.patch')
pkg_shasum=('94b03ba7b9cf7da7caa8456c219a8673'
         '30f46c92d0a5e5654258e707a9e8b5a6')

do_build() {
  patch -p0 -i ${CACHE_PATH}/${pkg_name}.patch

  # flags for shared lib
  CFLAGS="${CFLAGS} -fPIC"
  make CCFLAGS="-c ${CFLAGS}"
}

do_package() {

  install -m755 -d ${pkg_prefix}/usr/{bin,lib,include/gsm,share/{licenses/${pkg_name},man/man{1,3}}}

  make -j1 INSTALL_ROOT=${pkg_prefix}/usr \
    GSM_INSTALL_INC=${pkg_prefix}/usr/include/gsm \
    GSM_INSTALL_MAN=${pkg_prefix}/usr/share/man/man3 \
    TOAST_INSTALL_MAN=${pkg_prefix}/usr/share/man/man1 \
    install

  install -m644 COPYRIGHT ${pkg_prefix}/usr/share/licenses/${pkg_name}/license.txt
}
