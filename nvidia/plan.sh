pkg_origin=cosmos

_extramodules=extramodules-4.11
_kver=$(cat /lib/modules/${_extramodules}/version)

pkg_name=('nvidia' 'khd-nvidia')
pkg_version=381.22
pkg_upstream_url="http://www.nvidia.com/"
pkg_build_deps=('linux-headers' 'linux>=4.11' 'linux<4.12' "nvidia-utils=${pkg_version}")
pkg_license=('custom')

_pkg="NVIDIA-Linux-x86_64-${pkg_version}-no-compat32"

pkg_source=("http://us.download.nvidia.com/XFree86/Linux-x86_64/${pkg_version}/${_pkg}.run"
        'nvidia_supported'
        'linux-4.10.patch')
pkg_shasum=('0e9590d48703c8baa034b6f0f8bbf1e5'
         '282f73f1a7326339a7b0e0716eee4f76'
         '4ab00fe5ab144083caa6c6994feea7e6')

do_build() {
    sh "${_pkg}.run" --extract-only
    
    #patch -p1 -i ${CACHE_PATH}/linux-4.10.patch

    make SYSSRC=/lib/modules/"${_kver}/build" module
}

package_nvidia() {
    pkg_description="NVIDIA drivers for linux."
    pkg_deps=('linux>=4.11' 'linux<4.12' "nvidia-utils=${pkg_version}")
    conflicts=('nvidia-340xx')
    install=nvidia.install
    
    install -D -m644 "${CACHE_PATH}/${_pkg}/kernel/nvidia.ko" "${pkg_prefix}/lib/modules/${_extramodules}/nvidia.ko"
    install -D -m644 "${CACHE_PATH}/${_pkg}/kernel/nvidia-modeset.ko" "${pkg_prefix}/lib/modules/${_extramodules}/nvidia-modeset.ko"
    install -D -m644 "${CACHE_PATH}/${_pkg}/kernel/nvidia-uvm.ko" "${pkg_prefix}/lib/modules/${_extramodules}/nvidia-uvm.ko"
    install -D -m644 "${CACHE_PATH}/${_pkg}/kernel/nvidia-drm.ko" "${pkg_prefix}/lib/modules/${_extramodules}/nvidia-drm.ko"
    gzip "${pkg_prefix}/lib/modules/${_extramodules}/"*.ko
    install -d -m755 "${pkg_prefix}/etc/modprobe.d"
    echo "blacklist nouveau" >> "${pkg_prefix}/etc/modprobe.d/nouveau_blacklist.conf"
    sed -i -e "s/EXTRAMODULES='.*'/EXTRAMODULES='${_extramodules}'/" "${startdir}/nvidia.install"
}

package_khd-nvidia() {
    pkg_description="KHD ids for nvidia $pkg_version"
    arch=('x86_64')
    conflicts=('chd-nvidia')
    replaces=('chd-nvidia')


    install -dm755 "${pkg_prefix}/opt/kdeos/hwdb"
    sh -e "${CACHE_PATH}/nvidia_supported" README.txt kernel/nv-xxx.o \
        > "${pkg_prefix}/opt/kdeos/hwdb/hw_nvidia_hwdb"
}
