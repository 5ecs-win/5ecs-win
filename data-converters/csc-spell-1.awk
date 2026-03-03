# grep "Spirit Sh" ~/rpg/5etools/csc-spells/all-sources-json.txt | grep name: | cut -f2 -d: | awk -f csc-spell-1.awk
# cat sources.json | jq --stream -r 'select(.[1]|scalars!=null) | "\(.[0]|join(".")): \(.[1]|tojson)"' > /tmp/all-sources-json.txt
# awk -f ~/5ecs/data-converters/csc-spell-1.awk < /tmp/all-sources-json.txt | sort

BEGIN {
	for (i=0; i<12; i++) { spc[i] = 0; }
	FS=".";
	spellname="";
	spellidx=-1;
}

{
	if (spellname != $2) {
		if (spellidx != -1) {
			printf "splclass[\"%s\"] = \"", spellname;
			for (i=0; i<11; i++) { printf "%d,", spc[i]; } printf "%d\";\n", spc[i];
			for (i=0; i<12; i++) { spc[i] = 0; }
		}
		spellname = $2;
		spellidx++;
	}
	gsub("name: \"", "", $5);
	gsub("\"", "", $5);
	gsub(" ", "", $5);
	if ($5 == "Barbarian") { i = 0; }
	else if ($5 == "Bard") { i = 1; }
	else if ($5 == "Cleric") { i = 2; }
	else if ($5 == "Druid") { i = 3; }
	else if ($5 == "Fighter") { i = 4; }
	else if ($5 == "Monk") { i = 5; }
	else if ($5 == "Paladin") { i = 6; }
	else if ($5 == "Ranger") { i = 7; }
	else if ($5 == "Rogue") { i = 8; }
	else if ($5 == "Sorcerer") { i = 9; }
	else if ($5 == "Warlock") { i = 10; }
	else if ($5 == "Wizard") { i = 11; }
	spc[i] = 1;
#printf "%s = %s\n", $2, $5;
}

END {
	printf "splclass[\"%s\"] = \"", spellname;
	for (i=0; i<11; i++) { printf "%d,", spc[i]; } printf "%d\";\n", spc[i];
}
