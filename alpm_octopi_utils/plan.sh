pkg_origin=

pkg_name=alpm_octopi_utils
pkg_version=1.0.0
_commit=6d93c06d0feec0df7e5958c33df281eda91a6700
pkg_description="Alpm utils for Octopi"
pkg_upstream_url="https://octopiproject.wordpress.com/"
pkg_license=('GPL3')
pkg_build_deps=('vala')
pkg_source=("https://github.com/aarnt/${pkg_name}/archive/${_commit}.zip")
pkg_shasum=('e08da8f28da2bdaae0f267653aaec009')
         
do_build() {
   cd ${pkg_name}-${_commit}
   
   make
}

do_package() {
   cd ${pkg_name}-${_commit}
   
   install -D -m755 src/libalpm_octopi_utils.so ${pkg_prefix}/usr/lib/libalpm_octopi_utils.so
   install -D -m644 src/libalpm_octopi_utils.pc ${pkg_prefix}/usr/lib/pkgconfig/libalpm_octopi_utils.pc
   install -D -m644 src/alpm_octopi_utils.h ${pkg_prefix}/usr/include/alpm_octopi_utils.h   

}
