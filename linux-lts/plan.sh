pkg_origin=cosmos

pkgbase="linux-lts"
pkg_name=('linux-lts' 'linux-lts-headers' 'linux-lts-docs') 
_kernelname=${pkg_name#linux}
_basekernel=3.10
pkg_version=3.10.89
pkg_build_deps=('xmlto' 'docbook-xsl' 'kmod' 'inetutils' 'bc')
pkg_license=('GPL2')
pkg_upstream_url="http://www.kernel.org"
pkg_source=("https://www.kernel.org/pub/linux/kernel/v3.x/linux-$_basekernel.tar.xz"
        "https://www.kernel.org/pub/linux/kernel/v3.x/patch-${pkg_version}.xz"
        # the main kernel config files
        'config'
        # standard config files for mkinitcpio ramdisk
        'linux-lts.preset'
        'change-default-console-loglevel.patch')
pkg_shasum=('4f25cd5bec5f8d5a7d935b3f2ccb8481'
         '6cbb82eb3972bc719c7b4889c45693db'
         '0242fe5bf621f3bfcf51b110cdbbbc8e'
         '232b52576a62c7a333e9fe7a1e1ca359'
         '9d3c56a4b999c8bfbd4018089a62f662')

do_build() {
  cd ${CACHE_PATH}/linux-$_basekernel

  # add upstream patch
  patch -p1 -i "${CACHE_PATH}/patch-${pkg_version}"

  # add latest fixes from stable queue, if needed
  # http://git.kernel.org/?p=linux/kernel/git/stable/stable-queue.git

  # Some chips detect a ghost TV output
  #patch -p1 -i "${CACHE_PATH}/i915-fix-ghost-tv-output.patch"

  # set DEFAULT_CONSOLE_LOGLEVEL to 4 (same value as the 'quiet' kernel param)
  # remove this when a Kconfig knob is made available by upstream
  # (relevant patch sent upstream: https://lkml.org/lkml/2011/7/26/227)
  patch -p1 -i "${CACHE_PATH}/change-default-console-loglevel.patch"

  # fix ext4 module to mount ext3/2 correct
  #patch -p1 -i "${CACHE_PATH}/ext4-options.patch"
  
  # module initialisation
  #patch -p1 -i "${CACHE_PATH}/module-symbol-waiting-3.0.patch"
  #patch -p1 -i "${CACHE_PATH}/module-init-wait-3.0.patch"

  cat "${CACHE_PATH}/config" > ./.config

  if [ "${_kernelname}" != "" ]; then
    sed -i "s|CONFIG_LOCALVERSION=.*|CONFIG_LOCALVERSION=\"${_kernelname}\"|g" ./.config
  fi

  # set extraversion to pkgrel
  sed -ri "s|^(EXTRAVERSION =).*|\1 -${pkgrel}|" Makefile

  # get kernel version
  make prepare

  # load configuration
  # Configure the kernel. Replace the line below with one of your choice.
  #make menuconfig # CLI menu for configuration
  #make nconfig # new CLI menu for configuration
  #make xconfig # X-based configuration
  #make oldconfig # using old config from previous kernel version
  # ... or manually edit .config

  ####################
  # stop here
  # this is useful to configure the kernel
  #msg "Stopping build"
  #return 1
  ####################

  yes "" | make config

  # build!
  make ${MAKEFLAGS} bzImage modules
}

package_linux-lts() {
  pkg_description="The Linux LTS-Kernel and modules"
  groups=('lts')
  pkg_deps=('coreutils' 'linux-firmware' 'kmod' 'mkinitcpio')
  optpkg_deps=('crda: to set the correct wireless channels of your country')
  provides=("linux=$pkg_version")
  backup=("etc/mkinitcpio.d/${pkg_name}.preset")
  install=${pkg_name}.install

  cd "${CACHE_PATH}/linux-${_basekernel}"

  KARCH=x86

  # get kernel version
  _kernver="$(make kernelrelease)"

  mkdir -p "${pkg_prefix}"/{lib/modules,lib/firmware,boot}
  make INSTALL_MOD_PATH="${pkg_prefix}" modules_install
  cp arch/$KARCH/boot/bzImage "${pkg_prefix}/boot/vmlinuz-${pkg_name}"

  # add vmlinux
  install -D -m644 vmlinux "${pkg_prefix}/usr/src/linux-${_kernver}/vmlinux"

  # install fallback mkinitcpio.conf file and preset file for kernel
  install -D -m644 "${CACHE_PATH}/${pkg_name}.preset" "${pkg_prefix}/etc/mkinitcpio.d/${pkg_name}.preset"

  # set correct depmod command for install
  sed \
    -e  "s/KERNEL_NAME=.*/KERNEL_NAME=${_kernelname}/g" \
    -e  "s/KERNEL_VERSION=.*/KERNEL_VERSION=${_kernver}/g" \
    -i "${startdir}/${pkg_name}.install"
  sed \
    -e "s|ALL_kver=.*|ALL_kver=\"/boot/vmlinuz-${pkg_name}\"|g" \
    -e "s|default_image=.*|default_image=\"/boot/initramfs-${pkg_name}.img\"|g" \
    -e "s|fallback_image=.*|fallback_image=\"/boot/initramfs-${pkg_name}-fallback.img\"|g" \
    -i "${pkg_prefix}/etc/mkinitcpio.d/${pkg_name}.preset"

  # remove build and source links
  rm -f "${pkg_prefix}"/lib/modules/${_kernver}/{source,build}
  # remove the firmware
  rm -rf "${pkg_prefix}/lib/firmware"
  # gzip -9 all modules to save 100MB of space
  find "${pkg_prefix}" -name '*.ko' -exec gzip -9 {} \;
  # make room for external modules
  ln -s "../extramodules-${_basekernel}${_kernelname:--LTS}" "${pkg_prefix}/lib/modules/${_kernver}/extramodules"
  # add real version for building modules and running depmod from post_install/upgrade
  mkdir -p "${pkg_prefix}/lib/modules/extramodules-${_basekernel}${_kernelname:--LTS}"
  echo "${_kernver}" > "${pkg_prefix}/lib/modules/extramodules-${_basekernel}${_kernelname:--LTS}/version"
}

package_linux-lts-headers() {
  pkg_description="Header files and scripts for building modules for linux lts-kernel"
  provides=("linux-headers=$pkg_version")

  mkdir -p "${pkg_prefix}/lib/modules/${_kernver}"

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
    media net pcmcia scsi sound trace uapi video xen; do
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
  mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}/fs/xfs"
  mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}/mm"
  cp fs/xfs/xfs_sb.h "${pkg_prefix}/usr/src/linux-${_kernver}/fs/xfs/xfs_sb.h"

  #aufs3-util need
  #sed -i "s:__user::g" "${pkg_prefix}/usr/src/linux-${_kernver}/include/uapi/linux/aufs_type.h"

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

package_linux-lts-docs() {
  pkg_description="Kernel hackers manual - HTML documentation that comes with the Linux lts-kernel."
  provides=("linux-docs=$pkg_version")

  cd "${CACHE_PATH}/linux-${_basekernel}"

  mkdir -p "${pkg_prefix}/usr/src/linux-${_kernver}"
  cp -al Documentation "${pkg_prefix}/usr/src/linux-${_kernver}"
  find "${pkg_prefix}" -type f -exec chmod 444 {} \;
  find "${pkg_prefix}" -type d -exec chmod 755 {} \;

  # remove a file already in linux package
  rm -f "${pkg_prefix}/usr/src/linux-${_kernver}/Documentation/DocBook/Makefile"
}
