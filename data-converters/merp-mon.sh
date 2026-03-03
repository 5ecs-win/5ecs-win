#!/bin/sh
##############################################

awk -f merp-mon.awk < merp-mon.txt > merp-mon.h
sed "s/	/|/g" merp-mon-2.txt | awk -f merp-mon-2.awk >> merp-mon.h

vi merp-mon.h

g++ -Wno-write-strings -Wall -c pDBlibrary.cxx
g++ merp-mon.c -o merpmon pDBlibrary.o

if [ $? -eq 0 ]
then
	./merpmon
	rm pDBlibrary.o merpmon # merp-mon.h
fi
