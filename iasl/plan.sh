pkg_origin=cosmos

pkg_name=iasl
pkg_version=20170303
pkg_description="Intel ACPI Source Language compiler"
pkg_upstream_url="http://acpica.org"
pkg_license=('custom')
pkg_deps=('glibc')
pkg_build_deps=('flex' 'bison')
pkg_source=("https://acpica.org/sites/acpica/files/acpica-unix-${pkg_version}.tar.gz"
        'LICENSE')
pkg_shasum=('704c7d0ba7ee826ea489995c4837ebd2'
         '8615526144f69ea4e870d9bc37df9b29')

do_build() {
  cd acpica-unix-${pkg_version}/generate/unix
  sed -i -e 's/_CYGWIN/_LINUX/g' -e 's/-Werror//g' Makefile.config

  make clean
  make
}

do_package() {
  cd acpica-unix-${pkg_version}/generate/unix

  make DESTDIR=${pkg_prefix} install
  install -D -m644 ${CACHE_PATH}/LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
