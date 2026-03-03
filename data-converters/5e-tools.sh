#!/bin/sh
#########################################################
#	first you need to grab the json files from github
#
#	sed -i 's/\(^			"name":\)\([a-Z\" ]*\)\(\",$\)/\1\2 2025\3/' ~/rpg/5etools/bestiary-xmm.json
#
#  for i in `ls bestiary*.json`; do sed '/^{$/,/^	"monster": \[/d' $i > /tmp/sdc/$i; done
#	 in the FIRST json (bestiary-aatm.json) you'll need to add { "monster": [
#	vi /tmp/sdc/*.json
#		search for ^^I^I}$
#		add a COMMA at the EOL
#		and remove the text underneath until you get to monster
#	cat /tmp/sdc/*.json > /tmp/sdc/all-json.txt
#	add "] }" to the last json file
#	remove all delimited quotes with :%s/\\"//g
#	cat /tmp/sdc/all-json.txt | jq --stream -r 'select(.[1]|scalars!=null) | "\(.[0]|join(".")): \(.[1]|tojson)"' | cut -f3- -d"." > /tmp/all-json.txt
#
# grep "^name:" ~/rpg/5etools/all-json.txt | cut -f2- -d: | sed 's/\\//g' | sort -f -u | cut -c2- | awk 'BEGIN { cnt=0; } { gsub("\"", "", $0); printf "nameSort[\"%s\"] = %d; ", $0, NR; cnt++; if ((cnt %20) == 1) { printf "\n"; } }' > /tmp/nameSort.txt

# then update 5e-tools.awk with the file /tmp/nameSort.txt in the BEGIN section

cat - << _EOF >> /tmp/sed.$$
s/ [ ]*/ /g
s/{@dice//g
s/{@variantrule//g
s/.XPHB//g
s/}//g
s/{@actSave//g
s/{@dc/DC:/g
s/{@damage/Damage:/g
s/, " /, "/g
s/ ", /", /g
s/( /(/g
s/22025/ 2025/
s/{@recharge /(Recharge /g
s/\Reactions.//g
s/\Actions.//g
s/{@action //g
s/{@adventure //g
s/{@atk //g
s/{@chance //g
s/{@condition //g
s/{@creature //g
s/{@deity //g
s/{@disease //g
s/{@filter //g
s/{@hit //g
s/{@i //g
s/{@item //g
s/{@quickref //g
s/{@recharge//g
s/{@sense //g
s/{@skill //g
s/{@spell //g
s/{@status //g
s/{@book //g
s/{@h1 //g
s/{@h11 //g
s/{@h16 //g
s/{@h18 //g
s/{@h19 //g
s/{@h2 //g
s/{@h20 //g
s/{@h21 //g
s/{@h22 //g
s/{@h23 //g
s/{@h26 //g
s/{@h27 //g
s/{@h3 //g
s/{@h32 //g
s/{@h4 //g
s/{@h40 //g
s/{@h45 //g
s/{@h5 //g
s/{@h7 //g
s/{@hThe //g
s/{@table //g
s/"mw /"/g
s/"rs /"/g
s/"ms /"/g
s/" mw /"/g
s/" rs /"/g
s/" ms /"/g
_EOF

#awk -f 5e-tools.awk ~/rpg/5etools/bestiary-xmm.txt | sed -f /tmp/sed.$$ | more

rm /tmp/copyDetails.txt

awk -f 5e-tools.awk ~/rpg/5etools/all-json.txt | sed -f /tmp/sed.$$ | sed 's/\\//g' | sed 's/+++/\\n+/g'

cat /tmp/copyDetails.txt 

# awk -f hb-adventurers.awk -v monCnt=4096 < hb-adventurers.txt | sed 's/\\//g' | sed 's/+++/\\n+/g' > hb-adventurers.h
cat hb-adventurers.h

#awk -f 5e-tools.awk ~/rpg/5etools-2014/all-json.txt | sed -f /tmp/sed.$$ | sed 's/\\//g' | sed 's/+++/\\n+/g'

cp /tmp/copyDetails.txt ~/rpg/5etools/ > /dev/null 2>&1

# sort -n +1 -2 -t"|" srdv55monster.snt > srdv55monster.sntt; mv srdv55monster.sntt srdv55monster.snt
