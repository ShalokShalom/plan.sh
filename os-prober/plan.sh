pkg_origin=cosmos
pkg_name=os-prober
pkg_version=1.75
pkg_description="Utility to detect other operating systems on a set of drives."
pkg_upstream_url="https://packages.debian.org/unstable/utils/os-prober"
pkg_license=('GPL')
pkg_deps=('sh')
pkg_build_deps=('gcc' 'sed')
pkg_source=("ftp://ftp.us.debian.org/debian/pool/main/o/os-prober/${pkg_name}_${pkg_version}.tar.xz")
#pkg_source=("http://ftp.free.org/pub/frugalware/frugalware-current/source/base/${pkg_name}/${pkg_name}_${pkg_version}.tar.gz")
pkg_shasum=('acf4f8818af3cee051aa6f927a451e55')

do_build() {

  # adjust lib dir to allow detection of 64-bit distros
  sed -e "s:/lib/ld\*\.so\*:/lib*/ld*.so*:g" -i os-probes/mounted/common/90linux-distro 

  rm -f Makefile
  make newns
}

do_package() {

  install -D -m755 linux-boot-prober ${pkg_prefix}/usr/bin/linux-boot-prober
  install -D -m755 os-prober ${pkg_prefix}/usr/bin/os-prober
  install -D -m755 newns ${pkg_prefix}/usr/lib/os-prober/newns
  install -D -m755 common.sh ${pkg_prefix}/usr/share/os-prober/common.sh
  
  for dir in os-probes os-probes/mounted os-probes/init linux-boot-probes linux-boot-probes/mounted; do
    install -dm755 ${pkg_prefix}/usr/lib/$dir
    install -m755 -t ${pkg_prefix}/usr/lib/$dir "$dir"/common/*
    [[ -d "$dir"/x86 ]] && cp -r "$dir"/x86/* ${pkg_prefix}/usr/lib/$dir
  done

  install -Dm755 os-probes/mounted/powerpc/20macosx ${pkg_prefix}/usr/lib/os-probes/mounted/20macosx

  install -dm755 ${pkg_prefix}/var/lib/os-prober
}



