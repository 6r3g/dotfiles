#!/usr/bin/env bash

PICTURE=/tmp/i3lock.png
SCREENSHOT="/usr/bin/scrot -z $PICTURE"
BLUR="5x4"
$SCREENSHOT
convert $PICTURE -blur $BLUR $PICTURE
/usr/bin/i3lock -i $PICTURE
rm $PICTURE
