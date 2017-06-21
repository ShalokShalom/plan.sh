pkg_origin=cosmos

pkgbase=nvidia-340xx-utils
pkg_name=('nvidia-340xx-utils' 'nvidia-340xx-settings')
# Edit hardware-detection/hooks/hwdetect_7_graphics on version jump from 3xx.xx
pkg_version=340.102
pkg_upstream_url="http://www.nvidia.com/"
pkg_license=('custom')
pkg_build_deps=('xorg-server' 'libxvmc')
_pkg="NVIDIA-Linux-x86_64-${pkg_version}-no-compat32"
pkg_shasum=('81e720487caa2823586b32659da9acc1')

pkg_source=("http://us.download.nvidia.com/XFree86/Linux-x86_64/${pkg_version}/${_pkg}.run"
        'nvidia-restore-settings.desktop')
pkg_shasum=("${md5sums[@]}"
         '9237516792da7b6df32f8c7e8a98f475')

create_links() {
  # create soname links
  while read -d '' _lib; do
    _soname="$(dirname "${_lib}")/$(readelf -d "${_lib}" | sed -nr 's/.*Library soname: \[(.*)\].*/\1/p')"
    [ -e "${_soname}" ] || ln -s "$(basename "${_lib}")" "${_soname}"
    [ -e "${_soname/.[0-9]*/}" ] || ln -s "$(basename "${_soname}")" "${_soname/.[0-9]*/}"
  done < <(find "${pkg_prefix}" -type f -name '*.so*' -print0)
}

do_build() {
  sh "${_pkg}.run" --extract-only
}

package_nvidia-340xx-utils() {
  pkg_description="NVIDIA drivers utilities and libraries, 340xx legacy version."
  pkg_deps=('xorg-server' 'libxvmc')
  pkg_deps=('gtk2: nvidia-settings' 'pkg-config: nvidia-xconfig'
              'opencl-nvidia: OpenCL support'
	      'nvidia-settings: Gtk GUI')
  conflicts=('libgl' 'nvidia-utils' 'nvidia-304xx-utils')
  replaces=('nvidia-304xx-utils')
  provides=('libgl')


  # X driver
  install -D -m755 nvidia_drv.so "${pkg_prefix}/usr/lib/xorg/modules/drivers/nvidia_drv.so"
  # GLX extension module for X
  install -D -m755 "libglx.so.${pkg_version}" "${pkg_prefix}/usr/lib/xorg/modules/extensions/libglx.so.${pkg_version}"
  ln -s "libglx.so.${pkg_version}" "${pkg_prefix}/usr/lib/xorg/modules/extensions/libglx.so" # X doesn't find glx otherwise
  # OpenGL library
  install -D -m755 "libGL.so.${pkg_version}" "${pkg_prefix}/usr/lib/libGL.so.${pkg_version}"
  # OpenGL core library
  install -D -m755 "libnvidia-glcore.so.${pkg_version}" "${pkg_prefix}/usr/lib/libnvidia-glcore.so.${pkg_version}"
  # VDPAU
  install -D -m755 "libvdpau_nvidia.so.${pkg_version}" "${pkg_prefix}/usr/lib/vdpau/libvdpau_nvidia.so.${pkg_version}"
  # nvidia-tls library
  install -D -m755 "tls/libnvidia-tls.so.${pkg_version}" "${pkg_prefix}/usr/lib/libnvidia-tls.so.${pkg_version}"
  install -D -m755 "libnvidia-cfg.so.${pkg_version}" "${pkg_prefix}/usr/lib/libnvidia-cfg.so.${pkg_version}"

  install -D -m755 "libnvidia-ml.so.${pkg_version}" "${pkg_prefix}/usr/lib/libnvidia-ml.so.${pkg_version}"
  # CUDA
  install -D -m755 "libcuda.so.${pkg_version}" "${pkg_prefix}/usr/lib/libcuda.so.${pkg_version}"
  install -D -m755 "libnvcuvid.so.${pkg_version}" "${pkg_prefix}/usr/lib/libnvcuvid.so.${pkg_version}"
  # nvidia-xconfig
  install -D -m755 nvidia-xconfig "${pkg_prefix}/usr/bin/nvidia-xconfig"
  install -D -m644 nvidia-xconfig.1.gz "${pkg_prefix}/usr/share/man/man1/nvidia-xconfig.1.gz"
  # nvidia-bug-report
  install -D -m755 nvidia-bug-report.sh "${pkg_prefix}/usr/bin/nvidia-bug-report.sh"
  # nvidia-smi
  install -D -m755 nvidia-smi "${pkg_prefix}/usr/bin/nvidia-smi"
  install -D -m644 nvidia-smi.1.gz "${pkg_prefix}/usr/share/man/man1/nvidia-smi.1.gz"

  install -D -m644 LICENSE "${pkg_prefix}/usr/share/licenses/nvidia/LICENSE"
  ln -s nvidia "${pkg_prefix}/usr/share/licenses/nvidia-utils"
  install -D -m644 README.txt "${pkg_prefix}/usr/share/doc/nvidia/README"
  install -D -m644 NVIDIA_Changelog "${pkg_prefix}/usr/share/doc/nvidia/NVIDIA_Changelog"
  ln -s nvidia "${pkg_prefix}/usr/share/doc/nvidia-utils"

  create_links
}

package_nvidia-340xx-settings() {
  pkg_description="Gtk Graphical User Interface for nVidia, , 340xx legacy version"
  pkg_deps=('nvidia-340xx-utils' 'gtk2')
  conflicts=('nvidia-settings' 'nvidia-304xx-settings')
  replaces=('nvidia-304xx-settings')



  install -D -m755 nvidia-settings "${pkg_prefix}/usr/bin/nvidia-settings"
  install -D -m644 nvidia-settings.1.gz "${pkg_prefix}/usr/share/man/man1/nvidia-settings.1.gz"
  install -D -m644 nvidia-settings.desktop "${pkg_prefix}/usr/share/applications/nvidia-settings.desktop"
  install -D -m644 nvidia-settings.png "${pkg_prefix}/usr/share/pixmaps/nvidia-settings.png"
  sed -e 's:__UTILS_PATH__:/usr/bin:' -e 's:__PIXMAP_PATH__:/usr/share/pixmaps:' -i "${pkg_prefix}/usr/share/applications/nvidia-settings.desktop"

  # Install the autostart .desktop file, so that parameters saved through nvidia-settings
  # are automatically reloaded at each login
  install -D -m644 "${CACHE_PATH}/nvidia-restore-settings.desktop" "${pkg_prefix}/etc/xdg/autostart/nvidia-restore-settings.desktop"
}

