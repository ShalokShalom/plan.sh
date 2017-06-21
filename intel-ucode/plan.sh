pkg_origin=cosmos

pkg_name=intel-ucode
pkg_version=20170511
_pkg_version=26798
pkg_description="Microcode update files for Intel CPUs"
pkg_upstream_url="https://downloadcenter.intel.com/SearchResult.aspx?lang=eng&keyword=%22microcode%22"
pkg_license=('custom')
pkg_source=("https://downloadmirror.intel.com/${_pkg_version}/eng/microcode-${pkg_version}.tgz"
        'LICENSE'
        'intel-microcode2ucode.c')
pkg_shasum=('167e6e1ff234567291f067f48e11d740'
         'b0f489ae4b3e36dc8827dc53a76047aa'
         '444e1670977bd18e85658016eabc7cfa')

do_build() {
  gcc -Wall ${CFLAGS} -o intel-microcode2ucode intel-microcode2ucode.c
  ./intel-microcode2ucode ./microcode.dat
}

do_package() {
  install -d -m755 ${pkg_prefix}/lib/firmware/intel-ucode/
  
  cp intel-ucode/* ${pkg_prefix}/lib/firmware/intel-ucode/
  install -D -m644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
