# cat /data/rpg/shadowdark/unofficial_shadowdark_spell_list.csv | awk -f ~/5ecs/data-converters/sdark-spells.awk

BEGIN {
	FS="|";
	spellFile="";
}

# Source|Spell Name|Tier #|Spell Type|Duration|Range|Description

{
	if (length(spellFile) > 0) { close(spellFile); }
   gsub("/", " or ", $2);
   gsub("\"", "", $2); gsub("^ ", "", $2); spellName = $2;
   gsub(" ", "_", $2); gsub("^_", "", $2); gsub("'", "", $2);
   spellFile = sprintf("/tmp/sdc/%s.html", tolower($2));
   printf "<strong><bold><center>%s</strong></bold></center>\n", spellName > spellFile;

	printf "<p><strong>Tier:</strong> %s<br />\n", $3 >> spellFile;
	printf "<p><strong>Class:</strong> %s<br />\n", $4 >> spellFile;
	printf "<p><strong>Duration:</strong> %s<br />\n", $5 >> spellFile;
	printf "<p><strong>Range:</strong> %s<br />\n", $6 >> spellFile;
	printf "<p> %s<br />\n", $7 >> spellFile;
}
