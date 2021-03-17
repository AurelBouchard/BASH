#!/bin/bash

# @Author : butch
# le but de ce programme est de faire des trucs cool


# variables :
IP_ADDR=$(ifconfig $iface | awk '/inet/{gsub(" *inet addr:","");print $2; exit}')

# fonctions :
echo $IP_ADDR
