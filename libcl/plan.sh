pkg_origin=cosmos

pkg_name=libcl
pkg_version=1.1.12
_pkg_version=381.22
pkg_description="OpenCL library and ICD loader from NVIDIA"
pkg_upstream_url="http://www.nvidia.com/"
pkg_deps=('gcc-libs')
pkg_license=('custom')
_pkg="NVIDIA-Linux-x86_64-${_pkg_version}-no-compat32"
pkg_source=("https://us.download.nvidia.com/XFree86/Linux-x86_64/${_pkg_version}/${_pkg}.run")
pkg_shasum=('0e9590d48703c8baa034b6f0f8bbf1e5')

do_build() {
    
    sh ${_pkg}.run --extract-only
}

do_package() {
    
    install -D -m755 libOpenCL.so.1.0.0 $pkg_prefix/usr/lib/libOpenCL.so.1.0.0
    ln -s /usr/lib/libOpenCL.so.1.0.0 $pkg_prefix/usr/lib/libOpenCL.so.1
    ln -s /usr/lib/libOpenCL.so.1 $pkg_prefix/usr/lib/libOpenCL.so
    
    install -D -m644 LICENSE $pkg_prefix/usr/share/licenses/$pkg_name/LICENSE
}
