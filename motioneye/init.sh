#!/bin/sh

# set a hostname for mDNS (default to motioneye.local)
if [ -n "${DEVICE_HOSTNAME}" ]
then
    curl -X PATCH --header "Content-Type:application/json" \
        --data "{\"network\": {\"hostname\": \"${DEVICE_HOSTNAME}\"}}" \
        "${BALENA_SUPERVISOR_ADDRESS}/v1/device/host-config?apikey=${BALENA_SUPERVISOR_API_KEY}" || true
fi

# load pi camera module
modprobe bcm2835-v4l2

# automount storage disks at /media/{UUID}
for uuid in $(blkid -sUUID -ovalue /dev/sd??)
do
    mkdir -pv /media/"${uuid}"
    mount -v UUID="${uuid}" /media/"${uuid}"
done

CONFIG=/etc/motioneye/motioneye.conf

# copy default configuration
test -f "${CONFIG}" || cp -v /usr/share/motioneye/extra/motioneye.conf.sample "${CONFIG}"

if [ -n "${SERVER_NAME}" ]
then
    MOTIONEYE_SERVER_NAME="${SERVER_NAME}"
else
    MOTIONEYE_SERVER_NAME="${BALENA_DEVICE_NAME_AT_INIT}"
fi

# set server name
sed '/^server_name /d' -i "${CONFIG}"
sed "$ a\server_name ${MOTIONEYE_SERVER_NAME}" -i "${CONFIG}"

# start motioneye server
/usr/local/bin/meyectl startserver -c /etc/motioneye/motioneye.conf
