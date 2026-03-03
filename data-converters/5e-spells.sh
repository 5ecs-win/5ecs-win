#!/bin/sh
################################################################
#########################################################
#  first you need to grab the json files from github
#
#  for i in `ls spell*.json`; do cat $i | jq --stream -r 'select(.[1]|scalars!=null) | "\(.[0]|join(".")): \(.[1]|tojson)"' | cut -f3- -d"."; done > /tmp/all-json.txt

rm /tmp/sdc/*.html

cat - << _EOF > /tmp/sed.$$
s/{@action//g
s/{@adventure//g
s/{@b//g
s/{@book//g
s/{@chance//g
s/{@classFeature//g
s/{@condition//g
s/{@creature//g
s/{@d20//g
s/{@damage/Damage/g
s/{@dc/DC/g
s/{@dice//g
s/{@filter//g
s/{@hazard//g
s/{@hit//g
s/{@i//g
s/{@item//g
s/{@note//g
s/{@quickref//g
s/{@race//g
s/{@scaledamage//g
s/{@scaledice//g
s/{@sense//g
s/{@skill//g
s/{@spell//g
s/{@status//g
s/{@variantrule//g
s/|XPHB//g
s/}//g
s/  / /g
_EOF

#awk -f 5e-spells.awk ~/rpg/5etools/spells/all-json.txt

cat ~/rpg/5etools/spells/all-json.txt | awk -f 5e-spells.awk 
#cat /tmp/all-json.txt | awk -f 5e-spells.awk 

for s in `ls /tmp/sdc/*html`
do
	sed -i -f /tmp/sed.$$ $s
done
