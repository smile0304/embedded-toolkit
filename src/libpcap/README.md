# --- Specific to libpcap

Proceed as usual (assuming you sourced the [activate-script-helpers](https://github.com/mzpqnxow/gdb-static-cross/tree/master/activate-script-helpers) script appropriate for your toolchain)

```
$ source env.src
$ tar -xvzf libpcap-1.8.1.tar.gz
$ cd libpcap-1.8.1
$ export CFLAGS='-mips32r2' # Example, specify the ABI or whatever you'd like here
$ ./configure --prefix=$TOOLCHAIN_ROOT --host=$TOOLCHAIN_TARGET --with-pcap=linux CFLAGS="$CFLAGS"
$ make -j && make install
```

You should have a statically library for libpcap for that architecture, confirm with:

```
$ file libpcap.so
libpcap.so: current ar archive
```
