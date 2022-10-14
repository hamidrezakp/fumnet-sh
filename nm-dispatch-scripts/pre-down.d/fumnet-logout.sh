#!/bin/sh -e
# Script to dispatch NetworkManager events
#
# Runs `fumnet logout` when disconnecting from Ferdowsi University of Mashhad networks
# See NetworkManager(8) for further documentation of the dispatcher events.

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

if [ -x "/usr/bin/logger" ]; then
	logger="/usr/bin/logger -s -t fumnet"
else
	logger=":"
fi

if fumnet is-fum-network $CONNECTION_ID; then
	$logger -p user.debug "Disconnected from one of FUM networks [$CONNECTION_ID], trying to logout"
	fumnet logout
fi
