#!/bin/sh
#
# Meant for use on limited resource devices without many standard linux utilities
# This will perform the sometimes painful symbolic linking process once you have
# copied a busybox executable to a system
#
# BEWARE: the system may have a "real" version of an application that busybox provides
#         such as "lsof". This installer will effectively override use of that "real"
#         "lsof" tool (just an example) unless the path to the busybox symlinks are
#         added to the END of the $PATH as opposed to the beginning. It depends on
#         the system as to whether you want to prepend or append to your $PATH value!!
#
#
# busybox works by examining argv[0] which is most easily set on an embedded device
# by using a symbolic link and letting the shell set argv[0] for you. With some shells
# you can use things like `exec -a <argv[0]> appname` to do this, but this is much less
# portable. The recommended way is using `ln`
#
# Below is a list of ALL busybox applications as well as a pared down list of the most
# useful ones, much smaller than the complete list. Please modify the $INSTALL_APPS
# assignment 
#
# AG
#
BUSYBOX=/tmp/busybox
WRITABLE_PATH=/tmp
ALL_APPS='[[' '[' acpid addgroup add-shell adduser adjtimex arp arping ash awk base64 basename beep blkid blockdev bootchartd brctl bunzip2 bzcat bzip2 cal cat catv chat chattr chgrp chmod chown chpasswd chpst chroot chrt chvt cksum clear cmp comm conspy cp cpio crond crontab cryptpw cttyhack cut date dc dd deallocvt delgroup deluser depmod devmem df dhcprelay diff dirname dmesg dnsd dnsdomainname dos2unix du dumpkmap dumpleases echo ed egrep eject env envdir envuidgid ether-wake expand expr fakeidentd false fbset fbsplash fdflush fdformat fdisk fgconsole fgrep find findfs flock fold free freeramdisk fsck fsck.minix fsync ftpd ftpget ftpput fuser getopt getty grep groups gunzip gzip halt hd hdparm head hexdump hostid hostname httpd hush hwclock id ifconfig ifdown ifenslave ifplugd ifup inetd init insmod install ionice iostat ip ipaddr ipcalc ipcrm ipcs iplink iproute iprule iptunnel kbd_mode kill killall killall5 klogd last less linux32 linux64 linuxrc ln loadfont loadkmap logger login logname logread losetup lpd lpq lpr ls lsattr lsmod lsof lspci lsusb lzcat lzma lzop lzopcat makedevs makemime man md5sum mdev mesg microcom mkdir mkdosfs mke2fs mkfifo mkfs.ext2 mkfs.minix mkfs.vfat mknod mkpasswd mkswap mktemp modinfo modprobe more mount mountpoint mpstat mt mv nameif nanddump nandwrite nbd-client nc netstat nice nmeter nohup nslookup ntpd od openvt passwd patch pgrep pidof ping ping6 pipe_progress pivot_root pkill pmap popmaildir poweroff powertop printenv printf ps pscan pstree pwd pwdx raidautorun rdate rdev readahead readlink readprofile realpath reboot reformime remove-shell renice reset resize rev rm rmdir rmmod route rpm rpm2cpio rtcwake runlevel run-parts runsv runsvdir rx script scriptreplay sed sendmail seq setarch setconsole setfont setkeycodes setlogcons setserial setsid setuidgid sh sha1sum sha256sum sha3sum sha512sum showkey slattach sleep smemcap softlimit sort split start-stop-daemon stat strings stty su sulogin sum sv svlogd swapoff swapon switch_root sync sysctl syslogd tac tail tar tcpsvd tee telnet telnetd test tftp tftpd time timeout top touch tr traceroute traceroute6 true tty ttysize tunctl udhcpc udhcpd udpsvd umount uname unexpand uniq unix2dos unlzma unlzop unxz unzip uptime users usleep uudecode uuencode vconfig vi vlock volname wall watch watchdog wc wget which who whoami whois xargs xz xzcat yes zcat zcip
ESSENTIAL_APPS=arp arping awk base64 basename blkid blockdev bunzip2 bzcat bzip2 cat chattr chmod chown chpasswd chroot cksum clear comm cp cpio cut dd df diff dirname dmesg du egrep env expr false fdisk fgrep find ftpd ftpget ftpput fuser getopt getty grep gunzip gzip hdparm head hexdump hostname httpd id ifconfig ip ipcs kill killall killall5 less ln logger login logname ls lsattr lsmod lsof lspci lsusb lzcat lzma lzop lzopcat mkdir mkswap mktemp more mount mv nc netstat nohup nslookup od passwd pgrep pidof ping ping6 pkill pmap printf ps pstree pwd readlink realpath reboot reset rm route script sed seq setconsole setlogcons setserial setsid setuidgid sh sha1sum sha256sum sha3sum sha512sum sleep sort split stat strings stty su sulogin sum swapoff swapon sync sysctl syslogd tail tar tee telnet telnetd tftp tftpd top touch tr traceroute traceroute6 true tty ttysize umount uname unexpand uniq unix2dos unlzma unlzop unxz unzip uptime usleep uudecode uuencode vi watch watchdog wc wget which who whoami whois xargs xz xzcat yes zcat zcip
INSTALL_APPS=$ALL_BUSYBOX
INSTALL_APPS=$ESSENTIAL_BUSYBOX
echo Confirming ${WRITABLE_PATH} is writable before performing symlinks ...
#
# If the mkdir -p check fails, make sure that the mkdir app or shell built-in exists and supports
# -p. If you know your directory is writable, you can remove the following check altogether if it
# is causing problems for you
#
mkdir -p "${WRITABLE_PATH}" || (
  echo "${WRITABLE_PATH} is not present or writable: FATAL"; exit 1
)
echo Looks good, performing symlinks ...
for APP in "${INSTALL_APPS}"; do
  ln -sf "${BUSYBOX}" "${WRITABLE_PATH}/${APP}"
done
echo "Done! All symlinks created!"
echo ""
echo "Please use the following command to 'install' the busybox applications (no space will be taken up)"
echo "WARN: this will cause ALL busybox supported apps to 'override' system applications that are not busybox based !!"
echo "      If you would like to only 'install' certain busybox applications, trim the list in busybox-apps.txt"
echo ""
echo "By default, override system apps with the busybox versions:"
echo "  $ export PATH=$WRITABLE_PATH:\$PATH"
echo ""
echo "By default, fallback to busybox versions when the system does not have them:"
echo "  $ export PATH=\$PATH:$WRITABLE_PATH"
echo ""
echo "Have fun"
echo ""
