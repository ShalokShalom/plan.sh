pkg_origin=cosmos

_extramodules=extramodules-4.11-next
_kver=$(cat /lib/modules/${_extramodules}/version)

pkg_name=nvidia-next
pkg_version=381.22
pkg_description="NVIDIA drivers for linux."
pkg_upstream_url="http://www.nvidia.com/"
pkg_deps=('linux-next>=4.11RC7' 'linux-next<4.12' "nvidia-utils=${pkg_version}")
pkg_build_deps=('linux-next-headers')
pkg_license=('custom')
install=nvidia-next.install
_pkg="NVIDIA-Linux-x86_64-${pkg_version}-no-compat32"
#_pkg="NVIDIA-Linux-x86_64-${pkg_version}"
pkg_source=("ftp://download.nvidia.com/XFree86/Linux-x86_64/${pkg_version}/${_pkg}.run")
pkg_shasum=('0e9590d48703c8baa034b6f0f8bbf1e5')

do_build() {
  sh "${_pkg}.run" --extract-only
  
  #patch -p1 -i ${CACHE_PATH}/linux-4.10.patch
  
  make SYSSRC=/lib/modules/"${_kver}/build" module
}

do_package() {
  install -D -m644 "${CACHE_PATH}/${_pkg}/kernel/nvidia.ko" "${pkg_prefix}/lib/modules/${_extramodules}/nvidia.ko"
  install -D -m644 "${CACHE_PATH}/${_pkg}/kernel/nvidia-modeset.ko" "${pkg_prefix}/lib/modules/${_extramodules}/nvidia-modeset.ko"
  install -D -m644 "${CACHE_PATH}/${_pkg}/kernel/nvidia-uvm.ko" "${pkg_prefix}/lib/modules/${_extramodules}/nvidia-uvm.ko"
  install -D -m644 "${CACHE_PATH}/${_pkg}/kernel/nvidia-drm.ko" "${pkg_prefix}/lib/modules/${_extramodules}/nvidia-drm.ko"
  gzip "${pkg_prefix}/lib/modules/${_extramodules}/"*.ko
  install -d -m755 "${pkg_prefix}/lib/modprobe.d"
  
  echo "blacklist nouveau" >> "${pkg_prefix}/lib/modprobe.d/nvidia.conf"
  sed -i -e "s/EXTRAMODULES='.*'/EXTRAMODULES='${_extramodules}'/" "${startdir}/nvidia-next.install"
}
