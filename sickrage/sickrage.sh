#!/bin/bash
set -e

#
# Display settings on standard out.
#

USER="sickrage"

echo "SickRage settings"
echo "================="
echo
echo "  User:       ${USER}"
echo "  UID:        ${SICKRAGE_UID:=666}"
echo "  GID:        ${SICKRAGE_GID:=666}"
echo
echo "  Config:     ${CONFIG:=/datadir/config.ini}"
echo

#
# Change UID / GID of SickRage user.
#

printf "Updating UID / GID... "
[[ $(id -u ${USER}) == ${SICKRAGE_UID} ]] || usermod  -o -u ${SICKRAGE_UID} ${USER}
[[ $(id -g ${USER}) == ${SICKRAGE_GID} ]] || groupmod -o -g ${SICKRAGE_GID} ${USER}
echo "[DONE]"

#
# Set directory permissions.
#

printf "Set permissions... "
touch ${CONFIG}
chown -R ${USER}: /sickrage
chown ${USER}: /datadir /media $(dirname ${CONFIG}) ${CONFIG}
echo "[DONE]"

#
# Finally, start SickRage.
#

echo "Starting SickRage..."
exec su -pc "./SickBeard.py --nolaunch --datadir=$(dirname ${CONFIG}) --config=${CONFIG}" ${USER}