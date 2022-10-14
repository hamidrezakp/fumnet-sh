#!/bin/bash

username="xxx"
password="yyy"

# Get the token (magic) and redirect url
redirect_url=$(curl detectportal.firefox.com/canonical.html -w %{redirect_url} -s -o /dev/null)
token=$(echo $redirect_url | sed 's/https:\/\/access.um.ac.ir:443\/fgtauth\??//')

# If already logged in, exit
if [[ $token = "" ]];
then exit 0;
fi

# Simulate the redirection
curl -s -o /dev/null $redirect_url

data=$(echo "4Tredir=http%3A%2F%2Fdetectportal.firefox.com%2Fcanonical.html&magic=${token}&username=${username}&password=${password}")
curl -s --data-raw $data "https://access.um.ac.ir/" -o /dev/null
