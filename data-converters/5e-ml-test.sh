#!/bin/sh
###################################################
#

mc=10

sed "s/^|actions='''/|actions=\n\n/" "$1" | sed "s/[Mm]elee [Ww]eapon [Aa]ttack:/Melee Weapon Attack:/" | awk -v monCnt=$mc -f 5e-monst-list.awk 
