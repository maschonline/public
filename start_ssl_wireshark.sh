#!/bin/bash

pkill -f firefox

export SSLKEYLOGFILE=$HOME/Desktop/Downloads/ssl.log.txt

wireshark &

firefox

