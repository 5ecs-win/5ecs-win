function addnote (str) {
   if (donote != 1 && length(str) > 1) {
      printf "fputs(\"+++%d|%d|\", nof);\n", monCnt, monCnt;
      donote = 1;
   }
   printf "fputs(\"%s|\", nof);\n", str;
}

BEGIN {
	FS=" ";
}

{
	if (length($0) < 10) { getline; }
	switch ($1) {
		case "##":
					monCnt++;
					monWeapCnt = 0; donote = 0; speed = ""; init_bonus = 0; actiontype = 0;
					printf "\nstrncpy(sm[%d].c_name, \"%s %s\", 30);\n", monCnt, $2, $3;
					printf "sm[%d].i_bleeding = 0;\n", monCnt;
					printf "sm[%d].i_disabledAt = 0;\n", monCnt;
					printf "sm[%d].i_unconciousAt = -1;\n", monCnt;
					printf "sm[%d].i_inactive = 0;\n", monCnt;
					printf "sm[%d].i_stun = 0;\n", monCnt;
					printf "sm[%d].i_noAttacks = 1;\n", monCnt;
					printf "sm[%d].i_monsterType = 2;\n", monCnt;
					printf "sm[%d].flags.f_isStabilised = 0;\n", monCnt;
					printf "sm[%d].flags.f_disabled = 0;\n", monCnt;
					printf "sm[%d].flags.f_ignoreCriticals = 0;\n", monCnt;
					printf "sm[%d].flags.f_autoStablise = 0;\n", monCnt;
					printf "sm[%d].flags.f_evasion = 0;\n", monCnt;
					printf "sm[%d].flags.f_srdMonster = 1;\n", monCnt;
					printf "sm[%d].i_hp[HP_CUR] = sm[%d].i_hp[HP_MAX] = 1;\n", monCnt, monCnt;
					break;

			case "**Saving":
					gsub(",", "", $0); fc = split($0, sa, " "); fp = 3;
					while (fp < fc) {
#printf "ST: %s %d\n", sa[fp], fp;
						switch (sa[fp]) {
							case "STR":	printf "sm[%d].i_savingThrows[SAVE_STR] = %d;\n", monCnt, sa[fp+1]; fp++; break;
							case "DEX":	printf "sm[%d].i_savingThrows[SAVE_DEX] = %d;\n", monCnt, sa[fp+1]; fp++; break;
							case "CON":	printf "sm[%d].i_savingThrows[SAVE_CON] = %d;\n", monCnt, sa[fp+1]; fp++; break;
							case "INT":	printf "sm[%d].i_savingThrows[SAVE_INT] = %d;\n", monCnt, sa[fp+1]; fp++; break;
							case "WIS":	printf "sm[%d].i_savingThrows[SAVE_WIS] = %d;\n", monCnt, sa[fp+1]; fp++; break;
							case "CHA":	printf "sm[%d].i_savingThrows[SAVE_CHA] = %d;\n", monCnt, sa[fp+1]; fp++; break;
						}
						fp++;
					}
					break;
			case "**Skills**":
					gsub("*", "", $0); addnote($0);
					gsub(",", "", $0); fc = split($0, sa, " "); fp = 2;
					while (fp < fc) {
						switch (sa[fp]) {
							case "Perception": printf "sm[%d].i_skills[SKILL_SPOT] = %d;\n", monCnt, sa[fp+1]; fp++; break;
							case "Stealth": printf "sm[%d].i_skills[SKILL_MOVESILENTLY] = %d;\n", monCnt, sa[fp+1]; fp++; break;
						}
						fp++;
					}
					break;
			case "**Senses**":
					printf "sm[%d].i_skills[SKILL_PASSPERCEPTION] = %d;\n", monCnt, $4; fp++; break;
					break;
			case "**Languages**":
					break;
			case "**Challenge**": printf "sm[%d].f_challengeRating = %.2f;\n", monCnt, $2;
					break;
			case "**Armor": printf "sm[%d].i_armorClass[AC_NORMAL] = %d;\n", monCnt, $3;
					break;
			case "**Hit": printf "sm[%d].i_hp[HP_CUR] = sm[%d].i_hp[HP_MAX] = %d;\n", monCnt, monCnt, $3;
					break;
			case "**Speed**": gsub("ft.", "", $0); printf "sm[%d].i_speed = %d;\n", monCnt, $2;
					break;
			case "###":
					if ($2 == "Actions") {
						actiontype = 0;
					} else if ($2 == "Reactions") {
						actiontype = 1;
					} else if ($2 == "Bonus") {
						actiontype = 2;
					}
					break;
			case "STR":
					getline; getline;
					printf "sm[%d].i_abilityStats[0][ABILITY_STR] = %d;\n", monCnt, $1;
					printf "sm[%d].i_savingThrows[SAVE_STR] = %d;\n", monCnt, ($1 - 10) / 2;
					printf "sm[%d].i_abilityStats[0][ABILITY_DEX] = %d;\n", monCnt, $3;
					printf "sm[%d].i_savingThrows[SAVE_DEX] = %d;\n", monCnt, ($3 - 10) / 2;
					printf "sm[%d].i_abilityStats[0][ABILITY_CON] = %d;\n", monCnt, $5;
					printf "sm[%d].i_savingThrows[SAVE_CON] = %d;\n", monCnt, ($5 - 10) / 2;
					printf "sm[%d].i_abilityStats[0][ABILITY_INT] = %d;\n", monCnt, $7;
					printf "sm[%d].i_savingThrows[SAVE_INT] = %d;\n", monCnt, ($7 - 10) / 2;
					printf "sm[%d].i_abilityStats[0][ABILITY_WIS] = %d;\n", monCnt, $9;
					printf "sm[%d].i_savingThrows[SAVE_WIS] = %d;\n", monCnt, ($9 - 10) / 2;
					printf "sm[%d].i_abilityStats[0][ABILITY_CHA] = %d;\n", monCnt, $11;
					printf "sm[%d].i_savingThrows[SAVE_CHA] = %d;\n", monCnt, ($11 - 10) / 2;
					break;
			default:
					sta = substr($0, 1, 3);
					if (sta == "***") {
						gsub("*", "", $0);
						if (actiontype == 1) { at = "Rection: "; }
						else if (actiontype == 2) { at = "Bonus: "; }
						else { at = ""; }
						if ($1 == "Multiattack.") {
							gsub("Multiattack. ", "", $0);
							if (index($0, "attacks once") > 0 && index($0, "and once") > 0) { printf "sm[%d].i_noAttacks = 2;\n", monCnt; }
							else if (index($0, "attacks once") > 0 && index($0, "and twice") > 0) { printf "sm[%d].i_noAttacks = 3;\n", monCnt; }
							else if (index($0, "attacks once") > 0 && index($0, "and three") > 0) { printf "sm[%d].i_noAttacks = 4;\n", monCnt; }
							else if (index($0, "makes two") > 0) { printf "sm[%d].i_noAttacks = 2;\n", monCnt; }
							else if (index($0, "makes three") > 0) { printf "sm[%d].i_noAttacks = 3;\n", monCnt; }
							printf "strncpy(sm[%d].w_weapons[%d].c_description, \"Multiattack\", 30);\n", monCnt, monWeapCnt;
							printf "strncpy(sm[%d].w_weapons[%d].c_message, \"%s\", 79);\n", monCnt, monWeapCnt, $0;
							if (length($0) > 78) { addnote($0); }
#printf "M: %s\n", $0;
						} else if (index($0, "to hit") > 0) {
							idx = index($0, "\.") - 1;
#printf "W: %s: %d\n", $0, idx;
							printf "strncpy(sm[%d].w_weapons[%d].c_description, \"%s%s\", 30);\n", monCnt, monWeapCnt, at, substr($0, 1, idx);
							idx = index($0, "to hit");
							printf "sm[%d].w_weapons[%d].i_attackBonus[0] = %d;\n", monCnt, monWeapCnt, substr($0, idx-3, 2);
							idx = index($0, "(") + 1; idx1 = index($0, ")");
							dam = substr($0, idx, idx1-idx); gsub(" ", "", dam);
							printf "strcpy(sm[%d].w_weapons[%d].c_damage, \"%s\");\n", monCnt, monWeapCnt, dam;
							printf "strncpy(sm[%d].w_weapons[%d].c_message, \"%s\", 79);\n", monCnt, monWeapCnt, $0;
							if (length($0) > 78) { addnote($0); }
						} else {
							idx = index($0, "\.") - 1;
							printf "strncpy(sm[%d].w_weapons[%d].c_description, \"%s%s\", 30);\n", monCnt, monWeapCnt, at, substr($0, 1, idx);
							printf "strncpy(sm[%d].w_weapons[%d].c_message, \"%s\", 79);\n", monCnt, monWeapCnt, $0;
							if (length($0) > 78) { addnote($0); }
#printf "O: %s\n", $0;
						}
						monWeapCnt++; if (monWeapCnt > 11) { monWeapCnt = 11; }
					} else {
#printf "d: #%s#\n", $0;
					}
	}
}

END {
}
