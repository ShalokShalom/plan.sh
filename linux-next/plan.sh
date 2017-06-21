pkg_origin=cosmos

pkgbase=linux-next
pkg_name=('linux-next' 'linux-next-headers' 'linux-next-docs') 
_kernelname=${pkg_name#linux}
_basekernel=4.11
_srcname=linux-4.11
pkg_version=4.11.6
pkg_upstream_url="http://www.kernel.org/"
pkg_license=('GPL2')
pkg_build_deps=('xmlto' 'docbook-xsl' 'kmod' 'inetutils' 'bc' 'intel-ucode')
pkg_source=("https://www.kernel.org/pub/linux/kernel/v4.x/${_srcname}.tar.xz"
#pkg_source=("https://www.kernel.org/pub/linux/kernel/v4.x/testing/linux-4.11-rc8.tar.xz"
        "https://www.kernel.org/pub/linux/kernel/v4.x/patch-${pkg_version}.xz"
        # the main kernel config files
        'config'
        #aufs patches
        'aufs4-loopback.patch'
        'aufs4-base.patch'
        'aufs4-mmap.patch'
        'aufs4-standalone.patch'
        'aufs4-kbuild.patch'
        'aufs4.patch'
        'config.aufs'
        'lockdep-debug.patch'
        'tmpfs-idr.patch'
        'vfs-ino.patch'
        # standard config files for mkinitcpio ramdisk
        'linux-next.preset'
        '99-linux-next.hook'
        'change-default-console-loglevel.patch'
        'i8042-fix-aliases.patch'
        'RCU-ath9k.patch')
pkg_shasum=('251a5deee0fa6daf3f356b1bbda9eab8'
         '87c32d18a9c77d1c24da88e3c2365e28'
         '26e46ad6c455be5bcfac13f617fe9ced'
         'bee85cb32ae1aaf1bd74de48620490f2'
         'e6db16e3120f90a82c59aa0a6120117d'
         'fde067340c1013c14e748de3a7befb21'
         '18ad248bcaa107c19dd6038a3d3a3af5'
         'bd4880454b331a7484da92d79c175e65'
         '7b020276221c2a2f58c5921f2adf04ff'
         '260b2e47579140f61546f37d90e0b527'
         'e54b62bbde16342e0449aa64fc74d871'
         'b5cab83c6c285c1a47b9de23c49a26b3'
         '035cfb8aa33366e0ed4bde9cccbea10c'
         'e19be83ca72175a29b36d8ab08105050'
         'ae97691ba50d387f3ab98585514e3b22'
         'a262bedf26f26b7698143fc23de98457'
         '93dbf73af819b77f03453a9c6de2bb47'
         '351e3a6a77fab8d6a0d6af3851731782')

do_build() {
  cd "${CACHE_PATH}/linux-${_basekernel}"

  # add upstream patch
  patch -p1 -i "${CACHE_PATH}/patch-${pkg_version}"

  # add latest fixes from stable queue, if needed
  # http://git.kernel.org/?p=linux/kernel/git/stable/stable-queue.git

  # set DEFAULT_CONSOLE_LOGLEVEL to 4 (same value as the 'quiet' kernel param)
  # remove this when a Kconfig knob is made available by upstream
  # (relevant patch sent upstream: https://lkml.org/lkml/2011/7/26/227)
  ##patch -p1 -i "${CACHE_PATH}/change-default-console-loglevel.patch"
  
  patch -p1 -i "${CACHE_PATH}/i8042-fix-aliases.patch"
  
  # https://patchwork.ozlabs.org/patch/706835/
  #patch -p1 -i "${CACHE_PATH}/RCU-ath9k.patch"

  #aufs patches for Live:
  patch -p1 -i "${CACHE_PATH}/aufs4.patch"
  patch -p1 -i "${CACHE_PATH}/aufs4-base.patch"
  patch -p1 -i "${CACHE_PATH}/aufs4-kbuild.patch"
  patch -p1 -i "${CACHE_PATH}/aufs4-loopback.patch"
  patch -p1 -i "${CACHE_PATH}/aufs4-mmap.patch"
  patch -p1 -i "${CACHE_PATH}/aufs4-standalone.patch"
  patch -p1 -i "${CACHE_PATH}/lockdep-debug.patch"
  patch -p1 -i "${CACHE_PATH}/tmpfs-idr.patch"
  patch -p1 -i "${CACHE_PATH}/vfs-ino.patch"
  
  cat "${CACHE_PATH}/config" > ./.config

  cat "${CACHE_PATH}/config.aufs" >> ./.config

  if [ "${_kernelname}" != "" ]; then
    sed -i "s|CONFIG_LOCALVERSION=.*|CONFIG_LOCALVERSION=\"${_kernelname}\"|g" ./.config
  fi

  # set extraversion to pkgrel
  sed -ri "s|^(EXTRAVERSION =).*|\1 -${pkgrel}|" Makefile
  
  export KBUILD_BUILD_USER="k"
  export KBUILD_BUILD_HOST="`uname -m`.kaosx.us"

  # get kernel version
  make prepare
  
  # rewrite configuration
  yes "" | make config >/dev/null

  # build!
  make ${MAKEFLAGS} bzImage modules
}

package_linux-next() {
  pkg_description="The Linux Kernel and modules"
  pkg_deps=('coreutils' 'linux-firmware' 'kmod' 'mkinitcpio>=0.7')
  optpkg_deps=('crda: to set the correct wireless channels of your country')
  provides=("linux=$pkg_version")
  backup=("etc/mkinitcpio.d/${pkg_name}.preset")
  install=linux-next.install

  cd "${CACHE_PATH}/linux-${_basekernel}"

  KARCH=x86

  # get kernel version
  _kernver="$(make kernelrelease)"

  mkdir -p "${pkg_prefix}"/{lib/modules,lib/firmware,boot}
  make INSTALL_MOD_PATH="${pkg_prefix}" modules_install
  cp arch/$KARCH/boot/bzImage "${pkg_prefix}/boot/vmlinuz-${pkg_name}"

  # add vmlinux
  install -D -m644 vmlinux "${pkg_prefix}/usr/src/linux-${_kernver}/vmlinux"

  # install fallback mkinitcpio preset file and pacman hook for kernel
  install -D -m644 "${CACHE_PATH}/linux-next.preset" "${pkg_prefix}/etc/mkinitcpio.d/linux-next.preset"
  install -D -m644 "${CACHE_PATH}/99-linux-next.hook" "${pkg_prefix}/usr/share/libalpm/hooks/99-${pkgbase}.hook"

  # set correct depmod command for install
  sed \
    -e  "s/KERNEL_NAME=.*/KERNEL_NAME=${_kernelname}/" \
    -e  "s/KERNEL_VERSION=.*/KERNEL_VERSION=${_kernver}/" \
    -i "${startdir}/linux-next.install"
  sed \
    -e "1s|'linux.*'|'${pkg_name}'|" \
    -e "s|ALL_kver=.*|ALL_kver=\"/boot/vmlinuz-${pkg_name}\"|" \
    -e "s|default_image=.*|default_image=\"/boot/initramfs-${pkg_name}.img\"|" \
    -e "s|fallback_image=.*|fallback_image=\"/boot/initramfs-${pkg_name}-fallback.img\"|" \
    -i "${pkg_prefix}/etc/mkinitcpio.d/linux-next.preset"

  # remove build and source links
  rm -f "${pkg_prefix}"/lib/modules/${_kernver}/{source,build}
  # remove the firmware
  rm -rf "${pkg_prefix}/lib/firmware"
  # gzip -9 all modules to save 100MB of space
  find "${pkg_prefix}" -name '*.ko' -exec gzip -9 {} \;
  # make room for external modules
  ln -s "../extramodules-${_basekernel}${_kernelname:--NEXT}" "${pkg_prefix}/lib/modules/${_kernver}/extramodules"
  # add real version for building modules and running depmod from post_install/upgrade
  mkdir -p "${pkg_prefix}/lib/modules/extramodules-${_basekernel}${_kernelname:--NEXT}"
  echo "${_kernver}" > "${pkg_prefix}/lib/modules/extramodules-${_basekernel}${_kernelname:--NEXT}/version"
  
}

package_linux-next-headers() {
  pkg_description="Header files and scripts for building modules for linux kernel"
  provides=("linux-headers=$pkg_version")

  install -dm755 "${pkg_prefix}/lib/modules/${_kernver}"

  cd "${pkg_prefix}/lib/modules/${_kernver}"
  ln -sf ../../../usr/src/linux-${_kernver} build

  cd "${CACHE_PATH}/linux-${_basekernel}"
  install -D -m644 Makefile \
    "${pkg_prefix}/usr/src/linux-${_kernver}/Makefile"
  install -D -m644 kernel/Makefile \
    "${pkg_prefix}/usr/src/linux-${_kernver}/kernel/Makefile"
  install -D -m644 .config \
    "${pkg_prefix}/usr/src/linux-${_kernver}/.config"

  mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}/include"

  for i in acpi asm-generic config crypto drm generated linux math-emu \
    media net pcmcia scsi rdma soc sound trace uapi video xen; do
    cp -a include/${i} "${pkg_prefix}/usr/src/linux-${_kernver}/include/"
  done

  # copy arch includes for external modules
  mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}/arch/x86"
  cp -a arch/x86/include "${pkg_prefix}/usr/src/linux-${_kernver}/arch/x86/"

  # copy files necessary for later builds, like nvidia and vmware
  cp Module.symvers "${pkg_prefix}/usr/src/linux-${_kernver}"
  cp -a scripts "${pkg_prefix}/usr/src/linux-${_kernver}"

  # fix permissions on scripts dir
  chmod og-w -R "${pkg_prefix}/usr/src/linux-${_kernver}/scripts"
  mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}/.tmp_versions"

  mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}/arch/${KARCH}/kernel"

  cp arch/${KARCH}/Makefile "${pkg_prefix}/usr/src/linux-${_kernver}/arch/${KARCH}/"

  cp arch/${KARCH}/kernel/asm-offsets.s "${pkg_prefix}/usr/src/linux-${_kernver}/arch/${KARCH}/kernel/"

  # add headers for lirc package
  # pci
  for i in bt8xx cx88 saa7134; do
    mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}/drivers/media/pci/${i}"
    cp -a drivers/media/pci/${i}/*.h "${pkg_prefix}/usr/src/linux-${_kernver}/drivers/media/pci/${i}"
  done
  # usb
  for i in cpia2 em28xx pwc; do
    mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}/drivers/media/usb/${i}"
    cp -a drivers/media/usb/${i}/*.h "${pkg_prefix}/usr/src/linux-${_kernver}/drivers/media/usb/${i}"
  done
  # i2c
  mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}/drivers/media/i2c"
  cp drivers/media/i2c/*.h  "${pkg_prefix}/usr/src/linux-${_kernver}/drivers/media/i2c/"
  for i in cx25840; do
    mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}/drivers/media/i2c/${i}"
    cp -a drivers/media/i2c/${i}/*.h "${pkg_prefix}/usr/src/linux-${_kernver}/drivers/media/i2c/${i}"
  done

  # add docbook makefile
  install -D -m644 Documentation/DocBook/Makefile \
    "${pkg_prefix}/usr/src/linux-${_kernver}/Documentation/DocBook/Makefile"

  # add dm headers
  mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}/drivers/md"
  cp drivers/md/*.h "${pkg_prefix}/usr/src/linux-${_kernver}/drivers/md"

  # add inotify.h
  mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}/include/linux"
  cp include/linux/inotify.h "${pkg_prefix}/usr/src/linux-${_kernver}/include/linux/"

  # add wireless headers
  mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}/net/mac80211/"
  cp net/mac80211/*.h "${pkg_prefix}/usr/src/linux-${_kernver}/net/mac80211/"

  # add dvb headers for external modules
  mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}/drivers/media/dvb-core"
  cp drivers/media/dvb-core/*.h "${pkg_prefix}/usr/src/linux-${_kernver}/drivers/media/dvb-core/"
  # and...
  mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}/include/config/dvb/"
  cp include/config/dvb/*.h "${pkg_prefix}/usr/src/linux-${_kernver}/include/config/dvb/"

  # add dvb headers for http://mcentral.de/hg/~mrec/em28xx-new
  mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}/drivers/media/dvb-frontends/"
  cp drivers/media/dvb-frontends/lgdt330x.h "${pkg_prefix}/usr/src/linux-${_kernver}/drivers/media/dvb-frontends/"
  cp drivers/media/i2c/msp3400-driver.h "${pkg_prefix}/usr/src/linux-${_kernver}/drivers/media/i2c/"

  # add dvb headers
  mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}/drivers/media/usb/dvb-usb"
  cp drivers/media/usb/dvb-usb/*.h "${pkg_prefix}/usr/src/linux-${_kernver}/drivers/media/usb/dvb-usb/"
  mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}/drivers/media/dvb-frontends"
  cp drivers/media/dvb-frontends/*.h "${pkg_prefix}/usr/src/linux-${_kernver}/drivers/media/dvb-frontends/"
  mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}/drivers/media/tuners"
  cp drivers/media/tuners/*.h "${pkg_prefix}/usr/src/linux-${_kernver}/drivers/media/tuners/"

  # add xfs and shmem for aufs building
  mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}/fs/xfs/libxfs"
  mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}/mm"
  cp fs/xfs/libxfs/xfs_sb.h "${pkg_prefix}/usr/src/linux-${_kernver}/fs/xfs/libxfs/xfs_sb.h"

  #aufs4-util need
  sed -i "s:__user::g" "${pkg_prefix}/usr/src/linux-${_kernver}/include/uapi/linux/aufs_type.h"

  # copy in Kconfig files
  for i in `find . -name "Kconfig*"`; do
    mkdir -p "${pkg_prefix}"/usr/src/linux-${_kernver}/`echo ${i} | sed 's|/Kconfig.*||'`
    cp ${i} "${pkg_prefix}/usr/src/linux-${_kernver}/${i}"
  done

  chown -R root.root "${pkg_prefix}/usr/src/linux-${_kernver}"
  find "${pkg_prefix}/usr/src/linux-${_kernver}" -type d -exec chmod 755 {} \;

  # strip scripts directory
  find "${pkg_prefix}/usr/src/linux-${_kernver}/scripts" -type f -perm -u+w 2>/dev/null | while read binary ; do
    case "$(file -bi "${binary}")" in
      *application/x-sharedlib*) # Libraries (.so)
        /usr/bin/strip ${STRIP_SHARED} "${binary}";;
      *application/x-archive*) # Libraries (.a)
        /usr/bin/strip ${STRIP_STATIC} "${binary}";;
      *application/x-executable*) # Binaries
        /usr/bin/strip ${STRIP_BINARIES} "${binary}";;
    esac
  done

  # remove unneeded architectures
  rm -rf "${pkg_prefix}"/usr/src/linux-${_kernver}/arch/{alpha,arm,arm26,arm64,avr32,blackfin,c6x,cris,frv,h8300,hexagon,ia64,m32r,m68k,m68knommu,mips,microblaze,mn10300,openrisc,parisc,powerpc,ppc,s390,score,sh,sh64,sparc,sparc64,tile,unicore32,um,v850,xtensa}
}

package_linux-next-docs() {
  pkg_description="Kernel hackers manual - HTML documentation that comes with the Linux kernel."
  provides=("linux-docs=$pkg_version")

  cd "${CACHE_PATH}/linux-${_basekernel}"

  mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}"
  cp -al Documentation "${pkg_prefix}/usr/src/linux-${_kernver}"
  find "${pkg_prefix}" -type f -exec chmod 444 {} \;
  find "${pkg_prefix}" -type d -exec chmod 755 {} \;

  # remove a file already in linux package
  rm -f "${pkg_prefix}/usr/src/linux-${_kernver}/Documentation/DocBook/Makefile"
  # remove a files already in linux-headers
  rm -f "${pkg_prefix}/usr/src/linux-${_kernver}/Documentation/kbuild/Kconfig.recursion-issue-01"
  rm -f "${pkg_prefix}/usr/src/linux-${_kernver}/Documentation/kbuild/Kconfig.recursion-issue-02"
  rm -f "${pkg_prefix}/usr/src/linux-${_kernver}/Documentation/kbuild/Kconfig.select-break"
  
}
