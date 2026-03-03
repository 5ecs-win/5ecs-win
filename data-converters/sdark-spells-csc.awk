# sort -t"|" -k 3,2 /data/rpg/shadowdark/unofficial_shadowdark_spell_list.csv | awk -f ~/5ecs/data-converters/sdark-spells-csc.awk | sed 's/|/"/g'

BEGIN {
	FS="|";
}

# Source|Spell Name|Tier #|Spell Type|Duration|Range|Description
#   int   spellid;
#   int   level;
#   char  *name;
#   int   sclass[12];
#   char *range, *duration, *components, *material, *castingtime;
#   int   ritual, concentration;
#   char  *spelltext;

{
	if (NF < 7) { printf "### Error %d\n", NR; }
	cleric = wizard = 0;
	if (index($4, "Priest") != 0) { cleric = 1; }
	if (index($4, "Wizard") != 0) { wizard = 1; }
	gsub("\"", "", $5);
	gsub("\"", "", $6);
	gsub("\"", "", $7);
	printf "{%d, %d, |%s|, {0,0,%d,0,0,0,0,0,0,0,0,%d}, |%s|, |%s|, ||, ||, ||, 0, 0, |%s|},\n", NR-1, $3, $2, cleric, wizard, $6, $5, $7;
}
