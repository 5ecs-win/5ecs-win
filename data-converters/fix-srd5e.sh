#!/bin/sh
######################################################

for i in `ls *.html */*.html`
do
	H=`grep -n col-md-9 "$i" | cut -f1 -d:`
	F=`grep -n col-md-12 "$i" | cut -f1 -d:`

	sed "$H,$F!d" "$i" > /tmp/tmp/$$

	cp /tmp/tmp/$$ "$i"
done
