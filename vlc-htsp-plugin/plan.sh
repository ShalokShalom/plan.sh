pkg_origin=

pkg_name=vlc-htsp-plugin
pkg_version=0.2.1
_commit=49802312472224f369f2ec2964edfefbef3e3527
pkg_description="Plugin for VLC to access TVHeadend via HTSP allows VLC to act as a standalone TVHeadend client."
pkg_upstream_url="https://github.com/BtbN/vlc-htsp-plugin/"
pkg_license=('GPL2')
pkg_deps=('vlc')
pkg_source=("https://github.com/BtbN/vlc-htsp-plugin/archive/${_commit}.zip")
pkg_shasum=('19cfb474c81850aa93ea33ead4a827c0')

do_build() {
    cd ${pkg_name}-${_commit}

    make
}

do_package() {
    cd ${pkg_name}-${_commit}
    
    make DESTDIR=${pkg_prefix} install
}
