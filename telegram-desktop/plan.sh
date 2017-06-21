pkg_origin=

pkg_name=telegram-desktop
pkg_version=1.1.7
pkg_upstream_url="https://tdesktop.com/"
pkg_license=('GPL3')
pkg_description="Cloud-based mobile and desktop messaging app with a focus on security and speed."
pkg_deps=('qt5-base' 'portaudio' 'libexif')
install=telegram.install
pkg_source=("https://updates.tdesktop.com/tlinux/tsetup.${pkg_version}.tar.xz")
pkg_shasum=('71f3868770d89338a8a27c1b55486f6c')

do_package(){
  install -d ${pkg_prefix}/opt/Telegram

  cp Telegram/Telegram ${pkg_prefix}/opt/Telegram
  cp Telegram/Updater ${pkg_prefix}/opt/Telegram
}
