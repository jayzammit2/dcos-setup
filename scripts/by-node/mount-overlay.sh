# The OverlayFS storage driver avoids known issues with devicemapper in loop-lvm mode and allows containers
# to use docker-in-docker, if they want. See the following link for more information
#
# https://dcos.io/docs/1.8/administration/installing/custom/system-requirements/install-docker-centos/
#
# Additional information on the OverlayFS can be found at
#
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/7.2_release_notes/technology-preview-file_systems

# ------ MOUNT OVERLAY FILE SYSTEM ------
#
# NOTE: Comment out if you do not have a device to make an overlay filesystem on and mount.  If
# you do, set the OVERLAYFS variable in env.sh.  The default is set to /dev/vdb

mkdir -p /opt/dcos-setup
mv ~/env.sh /opt/dcos-setup
cd /opt/dcos-setup
source ./env.sh

mkfs -t xfs -n ftype=1 ${OVERLAYFS} 
mkdir /mnt/mesos
mount -t xfs ${OVERLAYFS} /mnt/mesos/
xfs_info ${OVERLAYFS} | grep ftype

# NOTE: Need to change the tee syntex so that I can use the OVERLAYFS env variable instead of hard coading /dev/vdb
tee /etc/fstab << '__EOF__'
/dev/vdb /mnt/mesos xfs defaults 1 2
__EOF__

df -h

# ------ END MOUNT OVERLAY FILE SYSTEM ------
