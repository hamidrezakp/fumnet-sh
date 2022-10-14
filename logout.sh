#!/bin/bash

redirect_url=$(curl "https://access.um.ac.ir/logout?" -w %{redirect_url} -s -o /dev/null)

# Simulate the redirection
curl -s -o /dev/null $redirect_url
