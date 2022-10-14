#!/bin/bash

cp fumnet.sh /usr/bin/fumnet
cp nm-dispatch-scripts/pre-up.d/fumnet-login.sh /etc/NetworkManager/dispatcher.d/pre-up.d/
cp nm-dispatch-scripts/pre-down.d/fumnet-logout.sh /etc/NetworkManager/dispatcher.d/pre-down.d/

chmod +x nm-dispatch-scripts/pre-up.d/fumnet-login.sh
chmod +x nm-dispatch-scripts/pre-down.d/fumnet-logout.sh
chmod +x /usr/bin/fumnet
