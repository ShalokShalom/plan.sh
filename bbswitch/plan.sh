pkg_origin=cosmos

_extramodules=extramodules-4.11
_kver="$(cat /lib/modules/${_extramodules}/version)"

pkg_name=bbswitch
pkg_version=0.8
pkg_description="Kernel module allowing to switch dedicated graphics card on Optimus laptops"
pkg_upstream_url="http://github.com/Bumblebee-Project/bbswitch"
pkg_license=('GPL')
install=bbswitch.install
pkg_deps=('linux>=4.11' 'linux<4.12')
pkg_build_deps=('linux-headers')
pkg_source=("https://github.com/Bumblebee-Project/bbswitch/archive/v${pkg_version}.tar.gz")
pkg_shasum=('5b116b31ace3604ddf9d1fc1f4bc5807')

do_build() {
  make KDIR=/usr/src/linux-${_kver}
}

do_package() {
    msg2 "Building module for $_kver..."

    # KDIR is necessary even when cleaning
    #make KDIR=/usr/src/linux-${_kver} clean
    mkdir -p $pkg_prefix//lib/modules/${_extramodules}
    install -D -m644 bbswitch.ko $pkg_prefix/lib/modules/${_extramodules}
    gzip "${pkg_prefix}/lib/modules/${_extramodules}/bbswitch.ko"
    #automatically update bbswitch.install
    sed -i -e "s/EXTRAMODULES='.*'/EXTRAMODULES='${_extramodules}'/" "${startdir}/bbswitch.install"
}
