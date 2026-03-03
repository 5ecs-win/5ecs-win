#!/bin/sh
###################################################

awk -f 5e-monst.awk < 5e-monst.txt | sed "s/desc://" > 5e-monst.h
mc=324

#mc=738

ls /tmp/mon/*.mon |
while (true)
do
	read m
	if [ -z "$m" ]
	then
		break
	fi
	#echo "$m"
	sed "s/^|actions='''/|actions=\n\n/" "$m" | sed "s/[Mm]elee [Ww]eapon [Aa]ttack:/Melee Weapon Attack:/" | awk -v monCnt=$mc -f 5e-monst-list.awk 
	mc=`expr $mc + 1`
done | sed 's/"Bit"/"Bite"/' > 5e-monst-list.h

g++ -Wno-write-strings -Wall -c pDBlibrary.cxx
g++ 5e-monst-list.c -o 5e-monst-list pDBlibrary.o

if [ $? -eq 0 ]
then
	./5e-monst-list
	if [ $? -eq 0 ]
	then
		cp 5e-monst-list.h 5e-monst.h tmp/
		rm 5e-monst-list pDBlibrary.o 5e-monst-list.h 5e-monst.h srdv5monster.bin
	fi
fi
