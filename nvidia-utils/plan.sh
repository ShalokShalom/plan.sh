pkg_origin=cosmos

pkgbase=nvidia-utils
pkg_name=('nvidia-utils' 'opencl-nvidia' 'nvidia-settings')
# Edit hardware-detection/hooks/hwdetect_7_graphics and Installer job 11 on version jump from 37x.xx
pkg_version=381.22
pkg_upstream_url="http://www.nvidia.com/"
pkg_license=('custom')
pkg_build_deps=('xorg-server' 'libxvmc')
_pkg="NVIDIA-Linux-x86_64-${pkg_version}-no-compat32"
#_pkg="NVIDIA-Linux-x86_64-${pkg_version}"
pkg_source=("http://us.download.nvidia.com/XFree86/Linux-x86_64/${pkg_version}/${_pkg}.run"
#pkg_source=("http://us.download.nvidia.com/XFree86/Linux-x86_64/${pkg_version}/NVIDIA-Linux-x86_64-${pkg_version}.run"
        'nvidia-restore-settings.desktop')
pkg_shasum=('0e9590d48703c8baa034b6f0f8bbf1e5'
         '9237516792da7b6df32f8c7e8a98f475')

create_links() {
  while read -d '' _lib; do
        _soname="$(dirname "${_lib}")/$(LC_ALL=C readelf -d "${_lib}" | sed -nr 's/.*Library soname: \[(.*)\].*/\1/p')"
        [[ -e "${_soname}" ]] || ln -s "$(basename "${_lib}")" "${_soname}"
        [[ -e "${_soname/.[0-9]*/}" ]] || ln -s "$(basename "${_soname}")" "${_soname/.[0-9]*/}"
    done < <(find "${pkg_prefix}" -type f -name '*.so*' -print0)
}

do_build() {
  sh "$_pkg.run" --extract-only
}

package_opencl-nvidia() {
  pkg_description="OpenCL implemention for NVIDIA"
  pkg_deps=('libcl' 'zlib' 'nvidia-utils')


  # OpenCL
  install -D -m644 nvidia.icd "${pkg_prefix}/etc/OpenCL/vendors/nvidia.icd"
  install -D -m755 "libnvidia-compiler.so.${pkg_version}" "${pkg_prefix}/usr/lib/libnvidia-compiler.so.${pkg_version}"
  install -D -m755 "libnvidia-opencl.so.${pkg_version}" "${pkg_prefix}/usr/lib/libnvidia-opencl.so.${pkg_version}"

  create_links
}

package_nvidia-utils() {
  pkg_description="NVIDIA drivers utilities and libraries."
  pkg_deps=('xorg-server' 'libxvmc')
  pkg_deps=('gtk2: nvidia-settings' 'pkg-config: nvidia-xconfig'
              'opencl-nvidia: OpenCL support'
	      'nvidia-settings: Gtk GUI')
  conflicts=('libgl')
  provides=('libgl')
	      
  # X driver
  install -D -m755 nvidia_drv.so "${pkg_prefix}/usr/lib/xorg/modules/drivers/nvidia_drv.so"
  
  # GLX extension module for X
  install -D -m755 "libglx.so.${pkg_version}" "${pkg_prefix}/usr/lib/xorg/modules/extensions/libglx.so.${pkg_version}"
  ln -s "libglx.so.${pkg_version}" "${pkg_prefix}/usr/lib/xorg/modules/extensions/libglx.so" # X doesn't find glx otherwise

  # OpenGL library
  install -D -m755 "libGL.so.${pkg_version}" "${pkg_prefix}/usr/lib/libGL.so.${pkg_version}"
  install -D -m755 "libOpenGL.so.0" "${pkg_prefix}/usr/lib/libOpenGL.so.0"
  install -D -m755 "libGLdispatch.so.0" "${pkg_prefix}/usr/lib/libGLdispatch.so.0"
  
  # OpenGL core library
  install -D -m755 "libnvidia-glcore.so.${pkg_version}" "${pkg_prefix}/usr/lib/libnvidia-glcore.so.${pkg_version}"
  install -D -m755 "libnvidia-eglcore.so.${pkg_version}" "${pkg_prefix}/usr/lib/libnvidia-eglcore.so.${pkg_version}"
  install -D -m755 "libnvidia-glsi.so.${pkg_version}" "${pkg_prefix}/usr/lib/libnvidia-glsi.so.${pkg_version}"
  install -D -m755 "libnvidia-egl-wayland.so.1.0.1" "${pkg_prefix}/usr/lib/libnvidia-egl-wayland.so.1.0.1"
  install -D -m644 "10_nvidia_wayland.json" "${pkg_prefix}/usr/share/egl/egl_external_platform.d/10_nvidia_wayland.json"
  install -D -m755 "libEGL_nvidia.so.${pkg_version}" "${pkg_prefix}/usr/lib/libEGL_nvidia.so.${pkg_version}"
  install -D -m644 "10_nvidia.json" "${pkg_prefix}/usr/share/glvnd/egl_vendor.d/10_nvidia.json"
  
  # XvMC
  #install -D -m644 libXvMCNVIDIA.a "${pkg_prefix}/usr/lib/libXvMCNVIDIA.a"
  #install -D -m755 "libXvMCNVIDIA.so.${pkg_version}" "${pkg_prefix}/usr/lib/libXvMCNVIDIA.so.${pkg_version}"
 
  # VDPAU
  install -D -m755 "libvdpau_nvidia.so.${pkg_version}" "${pkg_prefix}/usr/lib/vdpau/libvdpau_nvidia.so.${pkg_version}"

  # nvidia-tls library
  install -D -m755 "tls/libnvidia-tls.so.${pkg_version}" "${pkg_prefix}/usr/lib/libnvidia-tls.so.${pkg_version}"
  install -D -m755 "libnvidia-cfg.so.${pkg_version}" "${pkg_prefix}/usr/lib/libnvidia-cfg.so.${pkg_version}"

  install -D -m755 "libnvidia-ml.so.${pkg_version}" "${pkg_prefix}/usr/lib/libnvidia-ml.so.${pkg_version}"

  # CUDA
  install -D -m755 "libcuda.so.${pkg_version}" "${pkg_prefix}/usr/lib/libcuda.so.${pkg_version}"
  install -D -m755 "libnvcuvid.so.${pkg_version}" "${pkg_prefix}/usr/lib/libnvcuvid.so.${pkg_version}"
  install -D -m755 "libnvidia-fatbinaryloader.so.${pkg_version}" "${pkg_prefix}/usr/lib/libnvidia-fatbinaryloader.so.${pkg_version}"
  
  # nvidia-xconfig
  install -D -m755 nvidia-xconfig "${pkg_prefix}/usr/bin/nvidia-xconfig"
  install -D -m644 nvidia-xconfig.1.gz "${pkg_prefix}/usr/share/man/man1/nvidia-xconfig.1.gz"
 
  # nvidia-bug-report
  install -D -m755 nvidia-bug-report.sh "${pkg_prefix}/usr/bin/nvidia-bug-report.sh"

  # nvidia-smi
  install -D -m755 nvidia-smi "${pkg_prefix}/usr/bin/nvidia-smi"
  install -D -m644 nvidia-smi.1.gz "${pkg_prefix}/usr/share/man/man1/nvidia-smi.1.gz"

  # license
  install -D -m644 LICENSE "${pkg_prefix}/usr/share/licenses/nvidia/LICENSE"
  ln -s nvidia "${pkg_prefix}/usr/share/licenses/nvidia-utils"
   
  # docs
  install -D -m644 README.txt "${pkg_prefix}/usr/share/doc/nvidia/README"
  install -D -m644 NVIDIA_Changelog "${pkg_prefix}/usr/share/doc/nvidia/NVIDIA_Changelog"
  ln -s nvidia "${pkg_prefix}/usr/share/doc/nvidia-utils"

  create_links
}

package_nvidia-settings() {
  pkg_description="Gtk Graphical User Interface for nVidia"
  pkg_deps=('nvidia-utils' 'gtk2')



  install -D -m755 nvidia-settings "${pkg_prefix}/usr/bin/nvidia-settings"
  install -D -m644 nvidia-settings.1.gz "${pkg_prefix}/usr/share/man/man1/nvidia-settings.1.gz"
  install -D -m644 nvidia-settings.desktop "${pkg_prefix}/usr/share/applications/nvidia-settings.desktop"
  install -D -m644 nvidia-settings.png "${pkg_prefix}/usr/share/pixmaps/nvidia-settings.png"
  install -D -m755 "libnvidia-gtk2.so.$pkg_version" "$pkg_prefix/usr/lib/libnvidia-gtk2.so.$pkg_version"
  install -D -m755 "libnvidia-gtk3.so.$pkg_version" "$pkg_prefix/usr/lib/libnvidia-gtk3.so.$pkg_version"
  sed -e 's:__UTILS_PATH__:/usr/bin:' -e 's:__PIXMAP_PATH__:/usr/share/pixmaps:' -i "${pkg_prefix}/usr/share/applications/nvidia-settings.desktop"

  # Install the autostart .desktop file, so that parameters saved through nvidia-settings
  # are automatically reloaded at each login
  install -D -m644 "${CACHE_PATH}/nvidia-restore-settings.desktop" "${pkg_prefix}/etc/xdg/autostart/nvidia-restore-settings.desktop"
  # key documentation and application profile
  install -D -m644 nvidia-application-profiles-${pkg_version}-key-documentation "${pkg_prefix}/usr/share/nvidia/nvidia-application-profiles-${pkg_version}-key-documentation"
  install -D -m644 nvidia-application-profiles-${pkg_version}-rc "${pkg_prefix}/usr/share/nvidia/nvidia-application-profiles-${pkg_version}-rc"
}
