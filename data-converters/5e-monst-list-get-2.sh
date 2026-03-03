#!/bin/sh
##########################################
# https://www.dandwiki.com/wiki/5e_Monsters

mkdir /tmp/mon

for m in `cat 5e-monst-list-2.txt`
do
	N=`echo "$m" | cut -f1 -d"(" | sed "s/_/ /g" | sed "s/ $//"`

#	wget -q -O /tmp/mon/"$N".txt "https://www.dandwiki.com/w/index.php?title=${m}&action=edit&section=1"

	S=`grep -n "^{{5e " /tmp/mon/"$N".txt | head -1 | cut -f1 -d:`
	# E=`grep -n "editpage-copywarn" /tmp/mon/"$N".txt | tail -1 | cut -f1 -d:`
	E=`grep -n "vote type" /tmp/mon/"$N".txt | tail -1 | cut -f1 -d:`

	if [ -z "$E" ]
	then
		E=`grep -n "Creatures Breadcrumb" /tmp/mon/"$N".txt | tail -1 | cut -f1 -d:`
	fi
	if [ -z "$E" ]
	then
		E=`grep -n "{{clear}}" /tmp/mon/"$N".txt | tail -1 | cut -f1 -d:`
	fi
	if [ -z "$E" ]
	then
		E=`grep -n "editOptions" /tmp/mon/"$N".txt | tail -1 | cut -f1 -d:`
	fi

	if [ -n "$S" -a -n "$E" ]
	then
		S=`expr $S + 1`
		E=`expr $E - 1`
		echo "|name=$N" > /tmp/tmp/"$N".mon
		sed "$S,$E!d" /tmp/mon/"$N".txt >> /tmp/tmp/"$N".mon
	fi
	MC=`expr $MC + 1`
done
