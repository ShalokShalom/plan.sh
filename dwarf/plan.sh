pkg_origin=
 
pkg_name=dwarf
pkg_version=20170416
pkg_description="DWARF Debugging Information Format is of interest to programmers working on compilers and debuggers"
pkg_license=('GPL' 'LGPL')
pkg_upstream_url="https://www.prevanders.net/dwarf.html"
pkg_deps=('elfutils')
pkg_source=("https://www.prevanders.net/libdwarf-${pkg_version}.tar.gz")
pkg_shasum=('6a53d2b55d3ee2da396d4d0711e5c251')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./configure --prefix=/usr \
    --enable-shared
  make dd
}

do_package() {
  cd ${pkg_name}-${pkg_version}/libdwarf

  install -dm755 ${pkg_prefix}/usr/lib
  install -m644 libdwarf.{a,so.1} ${pkg_prefix}/usr/lib/
  ln -s libdwarf.so.1 ${pkg_prefix}/usr/lib/libdwarf.so

  install -dm755 ${pkg_prefix}/usr/include/libdwarf
  install -m644 dwarf.h libdwarf.h ${pkg_prefix}/usr/include/libdwarf/

  cd ../../${pkg_name}-${pkg_version}/dwarfdump
  install -Dm755 dwarfdump ${pkg_prefix}/usr/bin/dwarfdump
  install -Dm644 dwarfdump.1 ${pkg_prefix}/usr/share/man/man1/dwarfdump.1
  install -Dm644 dwarfdump.conf ${pkg_prefix}/usr/lib/dwarfdump.conf
}
