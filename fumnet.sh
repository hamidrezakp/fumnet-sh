#!/bin/bash
# Author: Hamid R. K. Pishghadam <kaveh@mail.um.ac.ir>
# License: MIT or Apache-2 by your choice
# https://github.com/hamidrezakp/fumnet

#
# CONFIG SECTION
#

# Username and Password
username="xxx"
password="yyy"

# The list of connection id's to login
connection_ids=("FUM-Fajr1" "WiFi-FUM")

#
# END CONFIG SECTION
#


connection_ids_len=$(echo "${#connection_ids[@]}")

contains() {
	[[ $1 =~ (^|[[:space:]])$2($|[[:space:]]) ]]
}

is_fum_network() {
	[[ $connection_ids_len -ne 0 ]] && contains $connection_ids $1
}

do_login() {
	# Get the magic and redirect url
	redirect_url=$(curl detectportal.firefox.com/canonical.html -w %{redirect_url} -s -o /dev/null)
	magic=$(echo $redirect_url | sed 's/https:\/\/access.um.ac.ir:443\/fgtauth\??//')

	# If already logged in, exit
	if [[ $magic = "" ]];
	then exit 0;
	fi

	# Simulate the redirection
	curl -s -o /dev/null $redirect_url

	data=$(echo "4Tredir=http%3A%2F%2Fdetectportal.firefox.com%2Fcanonical.html&magic=${magic}&username=$1&password=$2")
	curl -s --data-raw $data "https://access.um.ac.ir/" -o /dev/null
}

do_logout() {
	redirect_url=$(curl "https://access.um.ac.ir/logout?" -w %{redirect_url} -s -o /dev/null)

	# Simulate the redirection
	curl -s -o /dev/null $redirect_url
}

case "$1" in
	"login")
		# TODO: Check errors and invalid username
		do_login $username $password
	;;

	"logout")
		do_logout
	;;

	"is-fum-network")
		is_fum_network $2
	;;
	*)
		echo -e "try \`fumnet <SUBCOMMANDS>\`" \
			 "\n\n" \
			 "Subcommands:" \
			 "\n" \
			 "- login\n" \
			 "- logout\n" \
			 "- is-fum-network <CONNECTION_NAME>		Check if the provided CONNECTION_NAME is one of FUM networks"
		exit 1
	;;
esac
