BEGIN {
	FS="|";
#	printf "Name|Level|Size|4|HP|Armor|AC|8|Weapon/OB|Missile/OB|Search|SOH|SpecialMsg\n";
	srand();
}

{
	printf "strcpy(sm[i].c_name, \"%s\");\n", $1;
	printf "sm[i].i_levels[0] = %d;\n", $2;
	printf "sm[i].f_challengeRating = %d;\n", $2;
	printf "sm[i].i_hp[HP_MAX] = %d;\n", $5;
	printf "sm[i].i_hp[HP_CUR] = %d;\n", $5;
	printf "sm[i].i_armorClass[AC_NORMAL] = %d;\n", $7;
	if ($8 == "Y") { printf "sm[i].i_armorClass[AC_TOUCH] = 25;\n"; }
	if ($6 == "No") { printf "sm[i].i_armorClassSplit[AC_SECTION_ARMOR] = 0;\n"; }
	else if ($6 == "SL") { printf "sm[i].i_armorClassSplit[AC_SECTION_ARMOR] = 1;\n"; }
	else if ($6 == "RL") { printf "sm[i].i_armorClassSplit[AC_SECTION_ARMOR] = 2;\n"; }
	else if ($6 == "Ch") { printf "sm[i].i_armorClassSplit[AC_SECTION_ARMOR] = 3;\n"; }
	else if ($6 == "Pl") { printf "sm[i].i_armorClassSplit[AC_SECTION_ARMOR] = 4;\n"; }

	printf "sm[i].i_noAttacks = 1;\n";
	printf "sm[i].i_inGroup = -1;\n";

	if (length($9) > 0) {
		printf "strcpy(sm[i].w_weapons[0].c_description, \"Attack - %s\");\n", $9;
		split($9, wp, "/");
		printf "sm[i].w_weapons[0].i_attackBonus[0] = %d;\n", wp[1];
		if ((rand() * 2) > 1) {
			printf "strcpy(sm[i].w_weapons[0].c_table, \"1E\");\n";
			printf "strcpy(sm[i].w_weapons[0].c_damage, \"S\");\n";
		} else {
			printf "strcpy(sm[i].w_weapons[0].c_table, \"1C\");\n";
			printf "strcpy(sm[i].w_weapons[0].c_damage, \"K\");\n";
		}
		printf "strcpy(sm[i].w_weapons[0].c_message, \"%s\");\n", $9;
		printf "sm[i].w_weapons[0].i_noAttacks = 1;\n";
	}
	if (length($10) > 0) {
		printf "strcpy(sm[i].w_weapons[1].c_description, \"Missile - %s\");\n", $10;
		split($10, wp, "/");
		printf "sm[i].w_weapons[1].i_attackBonus[0] = %d;\n", wp[1];
		printf "strcpy(sm[i].w_weapons[1].c_table, \"MS\");\n";
		printf "strcpy(sm[i].w_weapons[1].c_damage, \"P\");\n";
		printf "strcpy(sm[i].w_weapons[1].c_message, \"%s\");\n", $10;
		printf "sm[i].w_weapons[1].i_noAttacks = 1;\n";
	}

	if (length($11) > 0) { printf "sm[i].i_skills[SKILL_SEARCH] = %d;\n", $11; }
	if (length($12) > 0) { printf "sm[i].i_skills[SKILL_SOH] = %d;\n", $12; }
	if (length($13) > 0) { printf "strcpy(sm[i].c_items, \"%s\");\n", $13; }
	
	printf "i++;\n\n";
}
