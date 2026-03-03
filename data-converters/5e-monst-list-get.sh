#!/bin/sh
##########################################
# https://www.dandwiki.com/wiki/5e_Monsters

mkdir /tmp/mon

for m in `cat 5e-monst-list.txt`
do
	wget -q -O /tmp/mon/"$m".txt "https://www.dandwiki.com/w/index.php?title=${m}_(5e_Creature)&action=edit&section=1"

	S=`grep -n "^{{5e " /tmp/mon/"$m".txt | head -1 | cut -f1 -d:`
	E=`grep -n "editpage-copywarn" /tmp/mon/"$m".txt | tail -1 | cut -f1 -d:`

	if [ -n "$S" -a -n "$E" ]
	then
		echo "$m"
		echo "|name=$m" | sed "s/_/ /g" > /tmp/tmp/"$m".mon
		sed "$S,$E!d" /tmp/mon/"$m".txt >> /tmp/tmp/"$m".mon
	fi
done
