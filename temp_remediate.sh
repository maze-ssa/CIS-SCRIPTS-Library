cp -pr /tmp /tmp_bak
systemctl unmask tmp.mount
systemctl enable tmp.mount
cp -pr /etc/systemd/system/local-fs.target.wants/tmp.mount /etc/systemd/system/local-fs.target.wants/tmp.mount_bak
sed -i 's/Options=mode=1777,strictatime/Options=mode=1777,strictatime,noexec,nodev,nosuid/g' /etc/systemd/system/local-fs.target.wants/tmp.mount
systemctl status tmp.mount
systemctl start tmp.mount
systemctl daemon-reload
mount -o remount,nodev /tmp
mount -o remount,nosuid /tmp
mount -o remount,noexec /tmp
mount -o remount,noexec /dev/shm
systemctl status tmp.mount
cp -pr /tmp_bak/* /tmp/
cp -p /etc/fstab /etc/fstab_bak
echo "tmpfs /dev/shm tmpfs defaults,nodev,nosuid,noexec,relatime 0 0" >> /etc/fstab
echo "tmpfs /tmp tmpfs defaults,nodev,nosuid,noexec,relatime 0 0" >> /etc/fstab
mount | grep /tmp
mount | grep /dev/shm
