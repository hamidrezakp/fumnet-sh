#!/bin/bash

username="xxx"
password="yyy"

# Get the token (magic)
token=$(curl -s 34.107.221.82 | sed 's/^.*fgtauth.\(.*\)".*/\1/')

# If already logged in, exit
if [[ $token = "success" ]];
then exit 0;
fi

# Simulate the redirection
url="https://access.um.ac.ir:443/fgtauth?${token}"
curl -s $url

data=$(echo "4Tredir=http%3A%2F%2F34.107.221.82&magic=${token}&username=${username}&password=${password}")
curl -s --data-raw $data "https://access.um.ac.ir/" 
