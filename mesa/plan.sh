pkg_origin=cosmos

pkgbase=mesa
pkg_name=('mesa' 'libgl')
pkg_version=17.1.2
_pkg_version=17.1.2
pkg_build_deps=('glproto' 'libdrm' 'libxxf86vm' 'libxdamage' 'libva' 'expat' 'llvm' 'libx11' 'libxt' 'gcc-libs'
             'dri2proto' 'python2' 'libxml2' 'imake' 'systemd' 'libvdpau' 'wayland' 'dri3proto'
             'presentproto' 'libxshmfence' 'elfutils' 'libomxil-bellagio' 'clang' 'python2-mako'
             'lm_sensors' 'libunwind')
pkg_upstream_url="https://www.mesa3d.org/"
pkg_license=('custom')
pkg_source=("https://mesa.freedesktop.org/archive/${pkg_name}-${pkg_version}.tar.xz"
#pkg_source=("mesa::git://anongit.freedesktop.org/mesa/mesa#branch=master"
       'LICENSE'
       'nouveau_locking_1.patch'
       'nouveau_locking_2.patch'
       'nouveau_locking_3.patch')
pkg_shasum=('4d2eaf5955740b044afd95ed167c906c'
         '5c65a0fe315dd347e09b1f2826a1df5a'
         'ededc541392e39597e7429a2a5bc6711'
         'edf9329a180353ed0d39d1c76c3dd10a'
         'ac45fd5de8d0d8e7ddd13a085800b577')
  
do_build() {
    # http://www.linuxfromscratch.org/blfs/view/svn/x/mesa.html 
    # libpthread-stubs package is useless on Linux
    sed -i -e 's|pthread_stubs_possible="yes"|pthread_stubs_possible="no"|' configure.ac
    
    # work in progress for nouveau fixes in qtwebengine
    patch -p1 -i ${CACHE_PATH}/nouveau_locking_1.patch
    patch -p1 -i ${CACHE_PATH}/nouveau_locking_2.patch
    patch -p1 -i ${CACHE_PATH}/nouveau_locking_3.patch
    
    ./autogen.sh --prefix=/usr \
    --sysconfdir=/etc \
    --with-dri-driverdir=/usr/lib/xorg/modules/dri \
    --with-gallium-drivers=r300,r600,nouveau,radeonsi,svga,swrast,virgl,swr \
    --with-dri-drivers=i915,i965,r200,radeon,nouveau,swrast \
    --with-vulkan-drivers=intel,radeon \
    --enable-llvm \
    --with-platforms=x11,drm,wayland \
    --enable-llvm-shared-libs \
    --with-clang-libdir=/usr/lib \
    --enable-shared-glapi \
    --enable-gbm \
    --enable-glx-tls \
    --enable-dri \
    --enable-glx \
    --enable-nine \
    --enable-gallium-osmesa \
    --enable-gles1 \
    --enable-gles2 \
    --enable-egl \
    --enable-texture-float \
    --enable-xa \
    --enable-vdpau \
    --enable-dri3 \
    --enable-omx \
    --enable-lmsensors
    #--enable-openvg currently not ported yet with gallium-egl removal
    
  make
}

package_libgl() {
  pkg_deps=("mesa=${pkg_version}")
  pkg_description="Mesa 3-D graphics library and DRI software rasterizer"

  install -m755 -d ${pkg_prefix}/usr/lib
  install -m755 -d ${pkg_prefix}/usr/lib/xorg/modules/extensions

  ln -s libglx.xorg ${pkg_prefix}/usr/lib/xorg/modules/extensions/libglx.so
  
  ln -s mesa-libGL.so.1.2.0      ${pkg_prefix}/usr/lib/libGL.so
  ln -s mesa-libGL.so.1.2.0      ${pkg_prefix}/usr/lib/libGL.so.1
  ln -s mesa-libGL.so.1.2.0      ${pkg_prefix}/usr/lib/libGL.so.1.2.0

  install -m755 -d ${pkg_prefix}/usr/share/licenses/libgl
  install -m644 ${CACHE_PATH}/LICENSE ${pkg_prefix}/usr/share/licenses/libgl/
}

package_mesa() {
  pkg_deps=('libx11' 'libxt' 'gcc-libs' 'libvdpau' 'dri2proto' 'glproto' 'wayland' 'elfutils'
           'libdrm' 'libxxf86vm' 'libxdamage' 'expat' 'libxshmfence' 'libomxil-bellagio' 'llvm'
           'lm_sensors' 'libunwind') 
  pkg_description="Mesa 3-D graphics libraries and include files"
  provides=('libglapi''libgles' 'libegl' 'khrplatform-devel' 'ati-dri' 'intel-dri' 'svga-dri' 'nouveau-dri')
  conflicts=('libglapi' 'libgles' 'libegl' 'khrplatform-devel' 'ati-dri' 'intel-dri' 'svga-dri' 'nouveau-dri')
  replaces=('libglapi' 'libgles' 'libegl' 'khrplatform-devel' 'ati-dri' 'intel-dri' 'svga-dri' 'nouveau-dri')

  #cd "${CACHE_PATH}/mesa"
  make DESTDIR=${pkg_prefix} install

  # rename libgl.so to make it possible to package separately 
  mv ${pkg_prefix}/usr/lib/libGL.so.1.2.0 	${pkg_prefix}/usr/lib/mesa-libGL.so.1.2.0
  rm ${pkg_prefix}/usr/lib/libGL.so{,.1}

  install -m755 -d ${pkg_prefix}/usr/share/licenses/mesa
  install -m644 ${CACHE_PATH}/LICENSE ${pkg_prefix}/usr/share/licenses/mesa/
}
