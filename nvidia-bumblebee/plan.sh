pkg_origin=cosmos


_extramodules=extramodules-4.11
_kver=$(cat /lib/modules/${_extramodules}/version)

pkg_name=nvidia-bumblebee
pkg_version=381.22
pkg_description="NVIDIA drivers for linux. Packaged for Bumblebee"
pkg_upstream_url="http://www.nvidia.com/"
pkg_deps=('linux>=4.11' 'linux<4.12' "nvidia-utils-bumblebee")
pkg_build_deps=('linux-headers')
pkg_license=('custom')
install=nvidia.install

_pkg="NVIDIA-Linux-x86_64-${pkg_version}-no-compat32"
#_pkg="NVIDIA-Linux-x86_64-${pkg_version}"
pkg_source=("ftp://download.nvidia.com/XFree86/Linux-x86_64/${pkg_version}/NVIDIA-Linux-x86_64-${pkg_version}-no-compat32.run"
        'linux-4.10.patch')
#pkg_source=("http://us.download.nvidia.com/XFree86/Linux-x86_64/${pkg_version}/NVIDIA-Linux-x86_64-${pkg_version}.run")
pkg_shasum=('0e9590d48703c8baa034b6f0f8bbf1e5'
         '4ab00fe5ab144083caa6c6994feea7e6')

do_build() {
    sh "${_pkg}.run" --extract-only
    
    #patch -p1 -i ${CACHE_PATH}/linux-4.10.patch
 
    make SYSSRC=/lib/modules/"${_kver}/build" module
}
 
do_package() {
    install -D -m644 "${CACHE_PATH}/${_pkg}/kernel/nvidia.ko" "${pkg_prefix}/lib/modules/${_extramodules}/nvidia.ko"
    #install -D -m644 "${CACHE_PATH}/${_pkg}/kernel/nvidia-modeset.ko" "${pkg_prefix}/lib/modules/${_extramodules}/nvidia-modeset.ko"
    install -D -m644 "${CACHE_PATH}/${_pkg}/kernel/nvidia-uvm.ko" "${pkg_prefix}/lib/modules/${_extramodules}/nvidia-uvm.ko"
    install -D -m644 "${CACHE_PATH}/${_pkg}/kernel/nvidia-drm.ko" "${pkg_prefix}/lib/modules/${_extramodules}/nvidia-drm.ko"
    gzip "${pkg_prefix}/lib/modules/${_extramodules}/"*.ko
    install -d -m755 "${pkg_prefix}/lib/modprobe.d"
    echo "blacklist nouveau" >> "${pkg_prefix}/lib/modprobe.d/nouveau_blacklist.conf"
    sed -i -e "s/EXTRAMODULES='.*'/EXTRAMODULES='${_extramodules}'/" "${startdir}/nvidia.install"
}
