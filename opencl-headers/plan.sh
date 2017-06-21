pkg_origin=cosmos

pkg_name=opencl-headers
pkg_version=2.2.20170611
_pkg_version=22
pkg_description='OpenCL (Open Computing Language) header files'
pkg_upstream_url='https://www.khronos.org/registry/cl/'
pkg_license=('custom')
pkg_deps=('libcl')
pkg_source=('LICENSE.txt'
        "https://raw.githubusercontent.com/KhronosGroup/OpenCL-Headers/master/opencl${_pkg_version}/CL/cl_ext.h"
        "https://raw.githubusercontent.com/KhronosGroup/OpenCL-Headers/master/opencl${_pkg_version}/CL/cl_gl_ext.h"
        "https://raw.githubusercontent.com/KhronosGroup/OpenCL-Headers/master/opencl${_pkg_version}/CL/cl_egl.h"
        "https://raw.githubusercontent.com/KhronosGroup/OpenCL-Headers/master/opencl${_pkg_version}/CL/cl_gl.h"
        "https://raw.githubusercontent.com/KhronosGroup/OpenCL-Headers/master/opencl${_pkg_version}/CL/cl.h"
        "https://github.com/KhronosGroup/OpenCL-CLHPP/releases/download/v2.0.10/cl2.hpp"
        "https://raw.githubusercontent.com/KhronosGroup/OpenCL-Headers/master/opencl${_pkg_version}/CL/cl_platform.h"
        "https://raw.githubusercontent.com/KhronosGroup/OpenCL-Headers/master/opencl${_pkg_version}/CL/cl_dx9_media_sharing.h"
        "https://raw.githubusercontent.com/KhronosGroup/OpenCL-Headers/master/opencl${_pkg_version}/CL/cl_d3d10.h"
        "https://raw.githubusercontent.com/KhronosGroup/OpenCL-Headers/master/opencl${_pkg_version}/CL/cl_d3d11.h"
        "https://raw.githubusercontent.com/KhronosGroup/OpenCL-Headers/master/opencl${_pkg_version}/CL/opencl.h")
pkg_shasum=('8e59f0e0f64326e826007b49700fba76'
         '0be05487e184ac36cf789d3badfdede2'
         '8982a32bca3c81bfab06c265e0a4130e'
         'c7f42a37356c2d4e42f2692921ed09a7'
         'b1dac507ba9b9abf0d6060f4acd5f414'
         '8c8fe562cde0d89bbb82bb8fb733f545'
         'c38d1b78cd98cc809fa2a49dbd1734a5'
         '46b468ebdfb2938beb6647862da6b9ba'
         '6d92fb282cab5cfa91aa05d62ed1953e'
         '64634186074ea8570ea24ce50b328968'
         '2608ee0f7a6101216cdfe3046591da30'
         '687394644e8c4ec4fd3d77f2f86bc042')

do_package() {
   install -dm755 ${pkg_prefix}/usr/include/CL

   for h in $(ls -1 *.h *.hpp); do
      install -m 644 ${h} ${pkg_prefix}/usr/include/CL/
   done

   install -D -m644 ../LICENSE.txt ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
