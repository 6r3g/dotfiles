#!/bin/sh

while true; do dig A @resolver1.opendns.com -4 myip.opendns.com +short > /tmp/ippub4 && dig AAAA @resolver1.opendns.com -6 myip.opendns.com +short > /tmp/ippub6;  sleep 5; done
