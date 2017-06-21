pkg_origin=cosmos

pkg_name=keyboardctl
pkg_version=0.1.6
_commit=a6e012fbeb016732f6571488220c809d6f7a5e32
pkg_description="Keymap setup program"
pkg_upstream_url="https://github.com/manjaro/keyboardctl"
pkg_license=('GPL')
pkg_deps=('kbd' 'xkeyboard-config' 'systemd')
pkg_build_deps=('git')
install=keyboardctl.install
pkg_source=("https://github.com/manjaro/keyboardctl/archive/${_commit}.zip")
pkg_shasum=('f66cef1f93450ab43627623c67cbbf56')

do_package() {

  make DESTDIR=${pkg_prefix} install
}
