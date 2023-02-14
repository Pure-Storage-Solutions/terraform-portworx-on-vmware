#!/bin/bash
/usr/sbin/pvresize /dev/sdb
#/sbin/lvextend -l +100%FREE -r /dev/mapper/sysvg-lv_root
/sbin/lvextend -L +20G -r /dev/mapper/sysvg-lv_home
/sbin/lvextend -L +10G -r /dev/mapper/sysvg-lv_var
/sbin/lvextend -L +15G -r /dev/mapper/sysvg-lv_log
/sbin/lvextend -L +15G -r /dev/mapper/sysvg-lv_audit
/sbin/lvextend -L +10G -r /dev/mapper/sysvg-lv_tmp 
/sbin/lvextend -L +5G -r /dev/mapper/sysvg-lv_opt 
/sbin/swapoff /dev/mapper/sysvg-lv_swap
/sbin/lvextend -L +10G  /dev/mapper/sysvg-lv_swap
/usr/sbin/mkswap /dev/mapper/sysvg-lv_swap
/sbin/swapon /dev/mapper/sysvg-lv_swap
/sbin/lvextend -l +100%FREE -r /dev/mapper/sysvg-lv_root
/usr/sbin/xfs_growfs /var
/usr/sbin/xfs_growfs /home
/usr/sbin/xfs_growfs /log
/usr/sbin/xfs_growfs /audit
/usr/sbin/xfs_growfs /tmp
/usr/sbin/xfs_growfs /opt
/usr/sbin/xfs_growfs /root
