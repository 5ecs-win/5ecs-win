BEGIN {
	FS="|";
	getline;
	monCnt=0;
}

function addnote (str) {
	gsub("\"", "", str);
   if (donote != 1 && length(str) > 1) {
      printf "fputs(\"+++%d|%d|\", nof);\n", monCnt, monCnt;
      donote = 1;
   }
   printf "fputs(\"%s|\", nof);\n", str;
}

function weapon (str) {
	if (length(str) == 0) { return; }
	gsub("\/", " / ", str); gsub(".near.", "NEAR", str); gsub(".close.", "CLOSE", str); gsub(".far.", "FAR", str);
	nf = split(str, wp, " ");
#printf "WP: %s %d\n", str, nf;
	if (wp[1] == "1" || wp[1] == "2" || wp[1] == "3" || wp[1] == "4") {
		printf "sm[%d].w_weapons[%d].i_noAttacks = %d;\n", monCnt, weapCnt, wp[1];
	}
	printf "strncpy(sm[%d].w_weapons[%d].c_description, \"%s\", 20);\n", monCnt, weapCnt, str;
	printf "strncpy(sm[%d].w_weapons[%d].c_message, \"%s\", 79);\n", monCnt, weapCnt, str;

	i = index(str, "+"); text = substr(str, i); 
	e = index(text, " "); if (e == 0) { e = 10; } text = substr(str, i, e);
	printf "sm[%d].w_weapons[%d].i_attackBonus[0] = %d;\n", monCnt, weapCnt, text;

	i = index(str, "("); 
	if (i> 0) {
		text = substr(str, i); 
		gsub(",", " + ", text);
		e = index(text, "+");
		if (e == 0) { e = index(text, ")"); text = substr(str, i+1, e-2); }
		else { text = substr(str, i+1, e-2); }
		gsub(" ", "", text); gsub(",", "", text);
		if (index(str, " + 1") > 0) { text=text "+1"; }
		if (index(str, " + 2") > 0) { text=text "+2"; }
		if (index(str, " + 3") > 0) { text=text "+3"; }
		printf "strcpy(sm[%d].w_weapons[%d].c_damage, \"%s\");\n", monCnt, weapCnt, text;
	}
	printf "sm[%d].w_weapons[%d].c_available = 1;\n", monCnt, weapCnt;

	weapCnt++;
}

# head -5 /data/rpg/shadowdark/shadowdark_monster_database.csv | awk -f ~/5ecs/data-converters/sdark-monst.awk | sed 's/""/"/g'| sed 's/+++/\\n+/g'
#                                     6         9         14        17
# Monster|5e CR|Source|Flavor Text|AC|HP|ATK|MV|S|D|C|I|W|Ch|AL|LV|Talent 1|Talent 2|....|Talent 10|

{
	if (NF < 20) { printf "Error at line %d\n", NR; }
	printf "\nstrncpy(sm[%d].c_name, \"%s\", 30);\n", monCnt, $1;
	printf "sm[%d].i_bleeding = 0;\n", monCnt;
	printf "sm[%d].i_disabledAt = 0;\n", monCnt;
	printf "sm[%d].i_unconciousAt = -1;\n", monCnt;
	printf "sm[%d].i_inactive = 0;\n", monCnt;
	printf "sm[%d].i_stun = 0;\n", monCnt;
	printf "sm[%d].i_noAttacks = 1;\n", monCnt;
	printf "sm[%d].flags.f_isStabilised = 0;\n", monCnt;
	printf "sm[%d].flags.f_disabled = 0;\n", monCnt;
	printf "sm[%d].flags.f_ignoreCriticals = 0;\n", monCnt;
	printf "sm[%d].flags.f_autoStablise = 0;\n", monCnt;
	printf "sm[%d].flags.f_evasion = 0;\n", monCnt;
	printf "sm[%d].flags.f_srdMonster = 1;\n", monCnt;
	printf "sm[%d].i_hp[HP_CUR] = sm[%d].i_hp[HP_MAX] = 1;\n", monCnt, monCnt;
	printf "sm[%d].i_levels[0] = %d;\n", monCnt, $16;

#	if (index($4, "huge") > 1) { printf "sm[%d].i_space = 20;\n", monCnt; printf "sm[%d].i_size = 4;\n", monCnt; }
#	else if (index($4, "large") > 1) { printf "sm[%d].i_space = 10;\n", monCnt; printf "sm[%d].i_size = 3;\n", monCnt; }
#	else if (index($4, "medium") > 1) { printf "sm[%d].i_space = 10;\n", monCnt; printf "sm[%d].i_size = 3;\n", monCnt; }

#	printf "sm[%d].i_space = 5;\n", monCnt; printf "sm[%d].i_size = 3;\n", monCnt;

	printf "sm[%d].i_armorClass[AC_NORMAL] = %d;\n", monCnt, $5;
	printf "sm[%d].i_hp[HP_MAX] = %d;\n", monCnt, $6;
	printf "sm[%d].i_hp[HP_CUR] = %d;\n", monCnt, $6;
	printf "sm[%d].i_initiative[0] = %d;\n", monCnt, $10;

	printf "sm[%d].i_savingThrows[SAVE_STR] = %d;\n", monCnt, $9;
	printf "sm[%d].i_savingThrows[SAVE_DEX] = %d;\n", monCnt, $10;
	printf "sm[%d].i_savingThrows[SAVE_CON] = %d;\n", monCnt, $11;
	printf "sm[%d].i_savingThrows[SAVE_INT] = %d;\n", monCnt, $12;
	printf "sm[%d].i_savingThrows[SAVE_WIS] = %d;\n", monCnt, $13;
	printf "sm[%d].i_savingThrows[SAVE_CHA] = %d;\n", monCnt, $14;

	if ($15 == "L") { printf "sm[%d].i_alignment = 1;\n", monCnt; }
	else if ($15 == "N") { printf "sm[%d].i_alignment = 5;\n", monCnt; }
	else if ($15 == "C") { printf "sm[%d].i_alignment = 9;\n", monCnt; }
	else { printf "sm[%d].i_alignment = 5;\n", monCnt; }

	gsub("^ [ ]*", "", $2); gsub(" [\.]", "", $2); #printf "CR=%s#\n", $2;
	split($2, crf, " ");
	if (crf[1] == "1/4" || crf[1] == "0") { cr = 0.25; }
	else if (crf[1] == "1/8") { cr = 0.20; }
	else if (crf[1] == "1/2") { cr = 0.50; }
	else { cr = crf[1] + 0; }

	printf "sm[%d].f_challengeRating = %.2f;\n", monCnt, cr;
	gsub(" [ ]*", " ", crf[2]);
	if (length(crf[2]) > 0) { addnote(crf[2]); }

	split($8, move, " "); mv = 30;
	if (move[1] == "close") { mv = 10; }
	else if (move[1] == "near") { mv = 30; }
	else if (move[1] == "far") { mv = 60; }
	else if (move[1] == "double" && move[2] == "near") { mv = 60; }
	printf "sm[%d].i_speed = %d;\n", monCnt, mv; 
	gsub(" [ ]*", " ", $8); if (length($8) > 1) { text = sprintf("Speed: %s", $8); addnote(text); }

#printf "WPTxt: %s\n", $7;
	weapCnt = 0;
	ai = index($7, " and ");
	if (ai > 0) {
		text = substr($7, 0, ai); weapon(text);
		text = substr($7, ai+4); weapon(text);
		printf "sm[%d].i_noAttacks = sm[%d].w_weapons[0].i_noAttacks + sm[%d].w_weapons[1].i_noAttacks;\n", monCnt, monCnt, monCnt;
	}
	oi = index($7, " or ");
	if (oi > 0) {
		text = substr($7, 0, oi); weapon(text);
		text = substr($7, oi+4); weapon(text);
		printf "sm[%d].i_noAttacks = sm[%d].w_weapons[0].i_noAttacks;\n", monCnt, monCnt;
	}
	if (ai == 0 && oi == 0) { 
		weapon($7) 
		printf "sm[%d].i_noAttacks = sm[%d].w_weapons[0].i_noAttacks;\n", monCnt, monCnt;
	}
	if (length($4) > 1) { addnote($4); }
	if (length($17) > 1) { addnote($17); }
	if (length($18) > 1) { addnote($18); }
	if (length($19) > 1) { addnote($19); }
	if (length($20) > 1) { addnote($20); }
	if (length($21) > 1) { addnote($21); }
	if (length($22) > 1) { addnote($22); }
	if (length($23) > 1) { addnote($23); }
	if (length($24) > 1) { addnote($24); }
	if (length($25) > 1) { addnote($25); }
	if (length($26) > 1) { addnote($26); }

	monCnt++;
   donote = 0;
}
