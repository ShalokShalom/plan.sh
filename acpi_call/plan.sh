pkg_origin=cosmos

_extramodules=extramodules-4.11
_kver="$(cat /lib/modules/${_extramodules}/version)"

pkg_name=acpi_call
pkg_version=1.1.0
pkg_description="A kernel module that enables you to call parameterless ACPI methods by writing the method name to /proc/acpi/call, e.g. to turn off discrete graphics card in a dual graphics environment (like NVIDIA Optimus)."
pkg_upstream_url="http://github.com/mkottman/acpi_call"
pkg_license=('GPL')
pkg_deps=('linux>=4.11' 'linux<4.12' 'linux-headers')
pkg_build_deps=('git')
install=acpi_call.install
pkg_source=("https://github.com/mkottman/acpi_call/archive/v${pkg_version}.tar.gz")
pkg_shasum=('f69d40e130b0e5ed17ce8adb19e6dda1')

do_build() {
  # needed for linux 3.17
  sed -i 's|acpi/acpi.h|linux/acpi.h|' acpi_call.c

  make KVERSION="${_kver}"
}
do_package() {
  install -dm 755 "${pkg_prefix}"/lib/{modules/${_extramodules},modules-load.d}
  install -m 644 ${pkg_name}.ko "${pkg_prefix}"/lib/modules/${_extramodules}
  
  gzip "${pkg_prefix}"/lib/modules/${_extramodules}/${pkg_name}.ko
  echo ${pkg_name} > "${pkg_prefix}"/lib/modules-load.d/${pkg_name}.conf

  install -dm 755 "${pkg_prefix}"/usr/share/${pkg_name}
  cp -dr --no-preserve='ownership' {examples,support} "${pkg_prefix}"/usr/share/${pkg_name}/
  
  #automatically update acpi_call.install
  sed -i -e "s/EXTRAMODULES='.*'/EXTRAMODULES='${_extramodules}'/" "${startdir}/acpi_call.install"
}
