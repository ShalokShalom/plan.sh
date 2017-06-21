pkg_origin=cosmos

_extramodules=extramodules-4.11
_kver=$(cat /lib/modules/${_extramodules}/version)

pkg_name=('nvidia-340xx' 'khd-nvidia-340xx')
pkg_version=340.102
pkg_upstream_url="http://www.nvidia.com/"
pkg_build_deps=('linux-headers' 'linux>=4.11' 'linux<4.12' "nvidia-340xx-utils=${pkg_version}")
pkg_license=('custom')

_pkg="NVIDIA-Linux-x86_64-${pkg_version}-no-compat32"

pkg_source=("ftp://download.nvidia.com/XFree86/Linux-x86_64/${pkg_version}/${_pkg}.run"
        "https://raw.github.com/KaOSx/hardware-detection/master/hwdb/nvidia_supported"
        'linux-4.10.patch')
pkg_shasum=('81e720487caa2823586b32659da9acc1'
         '62d0cdb856cfae64753c0f3acf729d47'
         '0f727318cbdc384aba14771bb63cc2d7')

do_build() {
    sh "${_pkg}.run" --extract-only
    
    patch -p1 -i ${CACHE_PATH}/linux-4.10.patch
    # sed line needed for linux 4.9 & 340.101
    sed -i 's/= DRIVER_GEM | DRIVER_PRIME,/= DRIVER_GEM | DRIVER_PRIME | DRIVER_LEGACY,/g' kernel/nv-drm.c
    
    make SYSSRC=/lib/modules/"${_kver}/build" module
}

package_nvidia-340xx() {
    pkg_description="NVIDIA drivers for linux."
    pkg_deps=('linux>=4.10' 'linux<4.11' "nvidia-340xx-utils=${pkg_version}")
    conflicts=('nvidia' 'nvidia-304xx')
    replaces=('nvidia-304xx')
    backup=('etc/X11/xorg.conf.d/20-nvidia.conf')
    install=nvidia.install
    
    install -D -m644 "${CACHE_PATH}/${_pkg}/kernel/nvidia.ko" \
        "${pkg_prefix}/lib/modules/${_extramodules}/nvidia.ko"
    install -d -m755 "${pkg_prefix}/etc/modprobe.d"
    echo "blacklist nouveau" >> "${pkg_prefix}/etc/modprobe.d/nouveau_blacklist.conf"
    
    sed -i -e "s/EXTRAMODULES='.*'/EXTRAMODULES='${_extramodules}'/" "${startdir}/nvidia.install"
    gzip "${pkg_prefix}/lib/modules/${_extramodules}/nvidia.ko"
}

package_khd-nvidia-340xx() {
    pkg_description="KHD ids for nvidia $pkg_version"
    arch=('x86_64')


    install -dm755 "${pkg_prefix}/opt/kdeos/hwdb"
    sh -e "${CACHE_PATH}/nvidia_supported" README.txt kernel/nv-kernel.o \
        > "${pkg_prefix}/opt/kdeos/hwdb/hw_nvidia340xx_hwdb"
}
