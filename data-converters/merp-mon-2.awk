BEGIN {
	FS="|";
#	printf "Name|Level|Encounter|Size/Crit|Speed|HP|Armor|DB|Attacks|Message\n";
	srand();
}

{
	printf "strcpy(sm[i].c_name, \"%s\");\n", $1;
	printf "sm[i].i_levels[0] = %d;\n", $2;
	printf "sm[i].f_challengeRating = %d;\n", $2;
	printf "sm[i].i_hp[HP_MAX] = %d;\n", $6;
	printf "sm[i].i_hp[HP_CUR] = %d;\n", $6;
	printf "sm[i].i_armorClass[AC_NORMAL] = %d;\n", $8;
	# if ($8 == "Y") { printf "sm[i].i_armorClass[AC_TOUCH] = 25;\n"; }
	split($7, armor, "/");
	if (armor[1] == "No" || armor[1] == "Ne") { printf "sm[i].i_armorClassSplit[AC_SECTION_ARMOR] = 0;\n"; }
	else if (armor[1] == "SL") { printf "sm[i].i_armorClassSplit[AC_SECTION_ARMOR] = 1;\n"; }
	else if (armor[1] == "RL") { printf "sm[i].i_armorClassSplit[AC_SECTION_ARMOR] = 2;\n"; }
	else if (armor[1] == "Ch" || armor[1] == "CH") { printf "sm[i].i_armorClassSplit[AC_SECTION_ARMOR] = 3;\n"; }
	else if (armor[1] == "Pl" || armor[1] == "PL" || armor[1] == "PI") { printf "sm[i].i_armorClassSplit[AC_SECTION_ARMOR] = 4;\n"; }

	split($4, size, "/");
	switch (substr(size[1], 1, 1)) {
		case "S": printf "sm[i].i_size = 0;\n"; break;
		case "M": printf "sm[i].i_size = 1;\n"; break;
		case "L": printf "sm[i].i_size = 2;\n"; break;
		case "H": printf "sm[i].i_size = 3;\n"; break;
	}
	split($5, speed, "/");
	switch (speed[1]) {
		case "CR":
		case "VS": printf "sm[i].i_speed = 10;\n"; break;
		case "SL":
		case "S": printf "sm[i].i_speed = 15;\n"; break;
		case "MD":
		case "M": printf "sm[i].i_speed = 20;\n"; break;
		case "MF": printf "sm[i].i_speed = 25;\n"; break;
		case "FA":
		case "F": printf "sm[i].i_speed = 30;\n"; break;
		case "VF": printf "sm[i].i_speed = 40;\n"; break;
		case "BF": printf "sm[i].i_speed = 50;\n"; break;
		default: printf "sm[i].i_speed = 20;\n"; break;
	}
		# if they are undead they ignore bleed/stun
	if (NR >= 192 && NR <= 211) {
		if (NR != 210) {
			printf "sm[i].flags.f_ignoreBleed = 1;\n";
			printf "sm[i].flags.f_ignoreStun = 1;\n";
		}
	}

	printf "sm[i].i_noAttacks = 1;\n";
	printf "sm[i].i_inGroup = -1;\n";

	if (length($10) > 0 || length($11) > 0) { 
		printf "strcpy(sm[i].c_items, \"%s ", $10; 
		if (length($11) > 0) { printf "%s ", $11; }
		if (length($12) > 0) { printf "%s ", $12; }
		if (length($13) > 0) { printf "%s ", $13; }
		if (length($14) > 0) { printf "%s ", $14; }
		if (length($15) > 0) { printf "%s ", $15; }
		if (length($16) > 0) { printf "%s ", $16; }
		if (length($17) > 0) { printf "%s ", $17; }
		if (length($18) > 0) { printf "%s ", $18; }

		smesg = sprintf("%s %s %s %s %s %s %s %s %s", $10, $11, $12, $13, $14, $15, $16, $17, $18);

		if (length($3) > 0) { if ($3 > 1) { printf "# Enc %s ", $3; } }

		printf "\");\n"
	}

	gsub("O", "0", $9);

	if (length($9) > 0) {
		attacks = split($9, attk, "/");
		printf "sm[i].i_noAttacks = %d;\n", attacks;
		for (i=1;i<=attacks;i++) {
			printf "strcpy(sm[i].w_weapons[%d].c_description, \"Attack - %s\");\n", i-1, attk[i];
			printf "sm[i].w_weapons[%d].i_noAttacks = 1;\n", i-1;
			brac = index(attk[i], "(");
			brace = index(attk[i], ")");
			if (brac > 0) {
				ob = substr(attk[i], 1, brac-1);
				crt = substr(attk[i], 1, brac-1);
				bval = substr(attk[i], brac+1, (brace-brac-1));
#printf "OB = %s BVAL = %s\n", ob, bval;
				if (bval == "2x") {
					printf "sm[i].w_weapons[%d].i_noAttacks = 2;\n", i-1;
				} else {
					gsub("'", "", bval);
					printf "sm[i].w_weapons[%d].i_range = %d;\n", i-1, bval;
				}
			} else {
				brac = index(attk[i], "&");
				if (brac > 0) {	# multiple attacks	TODO
					printf "sm[i].w_weapons[%d].i_noAttacks = 2;\n", i-1;
				}
				ob = sprintf("%s", attk[i]); 
				crt = sprintf("%s", attk[i]); 
			}
			printf "sm[i].w_weapons[%d].i_attackBonus[0] = %d;\n", i-1, ob;
			gsub("[A-z]", "", ob);
			gsub("[0-9]", "", crt);
			if (length(crt) > 2) {
				attksz = substr(crt, 1, 1);
				attkty = substr(crt, 2, 2);
			} else {
				attksz = "M";
				attkty = crt;
			}
#printf "OB = %s CRT = %s\n", ob, crt;
			switch (attksz) {
				case "S": printf "sm[i].w_weapons[%d].i_size = 0;\n", i-1; break;
				case "M": printf "sm[i].w_weapons[%d].i_size = 1;\n", i-1; break;
				case "L": printf "sm[i].w_weapons[%d].i_size = 2;\n", i-1; break;
				case "H": printf "sm[i].w_weapons[%d].i_size = 3;\n", i-1; break;
			}
			switch (attkty) {
				case "we": 
# or should we do this in the combat program
							printf "strcpy(sm[i].w_weapons[%d].c_description, \"Attack - %d/we\");\n", i-1, ob;
							if ((rand() * 2) > 1) {
								printf "strcpy(sm[i].w_weapons[%d].c_table, \"1E\");\n", i-1;	# broadsword details
								printf "strcpy(sm[i].w_weapons[%d].c_damage, \"S\");\n", i-1;
							} else {
								printf "strcpy(sm[i].w_weapons[%d].c_table, \"1C\");\n", i-1;	# mace details
								printf "strcpy(sm[i].w_weapons[%d].c_damage, \"K\");\n", i-1;
							}
							printf "sm[i].w_weapons[%d].i_fumble = 5;\n", i-1;
							break;
				case "ro": printf "strcpy(sm[i].w_weapons[%d].c_table, \"MS\");\n", i-1;	# missile attack
							printf "strcpy(sm[i].w_weapons[%d].c_damage, \"K\");\n", i-1;
							printf "sm[i].w_weapons[%d].i_fumble = 2;\n", i-1;
							break;
				case "poison":
				case "oi":
							printf "strcpy(sm[i].w_weapons[%d].c_table, \"PZ\");\n", i-1;
							plvl = index(smesg, "Lvl");
							if (plvl > 0) {
								printf "sm[i].w_weapons[%d].i_attackBonus[0] = %s;\n", i-1, substr(smesg, plvl+4, 1);
							} else {
								printf "sm[i].w_weapons[%d].i_attackBonus[0] = %d;\n", i-1, $2;
							}
					break;
				case "disease":
				case "is":
				case "swallow":
				case "wa":
				case "special":
				case "pe":
				case "spell":
				case "spells":
				case "bl":
				case "+bleeding":
					break;
# these need to be done
				case "a&":
				case "cb":
				case "h&":
				case "hr":
				case "ky":
				case "pa":
				case "th":
				case "wh":
					break;

				case "ol": printf "strcpy(sm[i].w_weapons[%d].c_table, \"SW\");\n", i-1;
							printf "sm[i].w_weapons[%d].i_fumble = 2;\n", i-1;
							break;
				case "Ti": printf "strcpy(sm[i].w_weapons[%d].c_table, \"TC\");\n", i-1;
							printf "strcpy(sm[i].w_weapons[%d].c_damage, \"S\");\n", i-1;
							printf "sm[i].w_weapons[%d].i_fumble = 2;\n", i-1;
							break;
				case "Pi": printf "strcpy(sm[i].w_weapons[%d].c_table, \"TC\");\n", i-1;
							printf "strcpy(sm[i].w_weapons[%d].c_damage, \"S\");\n", i-1;
							if (attksz == "L" || attksz == "H")
								printf "strcpy(sm[i].w_weapons[%d].c_critical, \"k\");\n", i-1;
							printf "sm[i].w_weapons[%d].i_fumble = 2;\n", i-1;
							break;
				case "Ba": printf "strcpy(sm[i].w_weapons[%d].c_table, \"GR\");\n", i-1;
							printf "strcpy(sm[i].w_weapons[%d].c_damage, \"G\");\n", i-1;
							if (attksz == "L" || attksz == "H")
								printf "strcpy(sm[i].w_weapons[%d].c_critical, \"k\");\n", i-1;
							printf "sm[i].w_weapons[%d].i_fumble = 2;\n", i-1;
							break;
				case "Bi": printf "strcpy(sm[i].w_weapons[%d].c_table, \"TC\");\n", i-1;
							printf "strcpy(sm[i].w_weapons[%d].c_damage, \"P\");\n", i-1;
							printf "strcpy(sm[i].w_weapons[%d].c_critical, \"sc\");\n", i-1;
							printf "sm[i].w_weapons[%d].i_fumble = 2;\n", i-1;
							break;
				case "Cl": printf "strcpy(sm[i].w_weapons[%d].c_table, \"TC\");\n", i-1;
							printf "strcpy(sm[i].w_weapons[%d].c_damage, \"S\");\n", i-1;
							printf "strcpy(sm[i].w_weapons[%d].c_critical, \"pb\");\n", i-1;
							printf "sm[i].w_weapons[%d].i_fumble = 2;\n", i-1;
							break;
				case "Cr": printf "strcpy(sm[i].w_weapons[%d].c_table, \"TC\");\n", i-1;
							printf "strcpy(sm[i].w_weapons[%d].c_damage, \"K\");\n", i-1;
							if (attksz == "L" || attksz == "H")
								printf "strcpy(sm[i].w_weapons[%d].c_critical, \"k\");\n", i-1;
							printf "sm[i].w_weapons[%d].i_fumble = 2;\n", i-1;
							break;
				case "Gr": printf "strcpy(sm[i].w_weapons[%d].c_table, \"TC\");\n", i-1;
							printf "strcpy(sm[i].w_weapons[%d].c_damage, \"G\");\n", i-1;
							printf "strcpy(sm[i].w_weapons[%d].c_critical, \"Uc\");\n", i-1;
							printf "sm[i].w_weapons[%d].i_fumble = 2;\n", i-1;
							break;
				case "Ho": printf "strcpy(sm[i].w_weapons[%d].c_table, \"TC\");\n", i-1;
							printf "strcpy(sm[i].w_weapons[%d].c_damage, \"P\");\n", i-1;
							if (attksz == "L" || attksz == "H")
								printf "strcpy(sm[i].w_weapons[%d].c_critical, \"kc\");\n", i-1;
							printf "sm[i].w_weapons[%d].i_fumble = 2;\n", i-1;
							break;
				case "Ts": printf "strcpy(sm[i].w_weapons[%d].c_table, \"TC\");\n", i-1;
							printf "strcpy(sm[i].w_weapons[%d].c_damage, \"K\");\n", i-1;
							if (attksz == "L" || attksz == "H")
								printf "strcpy(sm[i].w_weapons[%d].c_critical, \"K\");\n", i-1;
							printf "sm[i].w_weapons[%d].i_fumble = 2;\n", i-1;
							break;
				case "TS": printf "strcpy(sm[i].w_weapons[%d].c_table, \"TC\");\n", i-1;
							printf "strcpy(sm[i].w_weapons[%d].c_damage, \"K\");\n", i-1;
							if (attksz == "L" || attksz == "H")
								printf "strcpy(sm[i].w_weapons[%d].c_critical, \"K\");\n", i-1;
							printf "sm[i].w_weapons[%d].i_fumble = 2;\n", i-1;
							break;
				case "St": printf "strcpy(sm[i].w_weapons[%d].c_table, \"TC\");\n", i-1;
							printf "strcpy(sm[i].w_weapons[%d].c_damage, \"P\");\n", i-1;
							if (attksz == "L" || attksz == "H")
								printf "strcpy(sm[i].w_weapons[%d].c_critical, \"kc\");\n", i-1;
							printf "sm[i].w_weapons[%d].i_fumble = 2;\n", i-1;
							break;
				case "da":	# dagger attack
							printf "strcpy(sm[i].w_weapons[%d].c_table, \"1E\");\n", i-1;	# dagger details
							printf "strcpy(sm[i].w_weapons[%d].c_damage, \"Pc\");\n", i-1;
							printf "sm[i].w_weapons[%d].i_fumble = 2;\n", i-1;
							break;
				case "Br":	# bolt attack
							printf "strcpy(sm[i].w_weapons[%d].c_table, \"SO\");\n", i-1;
							printf "strcpy(sm[i].w_weapons[%d].c_critical, \"H\");\n", i-1;
							printf "sm[i].w_weapons[%d].i_fumble = 3;\n", i-1;
							break;
				default:
#printf "unknown %s\n", attkty;
							printf "strcpy(sm[i].w_weapons[%d].c_table, \"%s\");\n", i-1, attkty;
							printf "sm[i].w_weapons[%d].i_fumble = 5;\n", i-1;
							break;
			}
#			printf "strcpy(sm[i].w_weapons[%d].c_damage, \"S\");\n", i-1;
#			printf "strcpy(sm[i].w_weapons[%d].c_message, \"%s\");\n", i-1, attk[i];
		}
	}

#	if (length($11) > 0) { printf "sm[i].i_skills[SKILL_SEARCH] = %d;\n", $11; }
#	if (length($12) > 0) { printf "sm[i].i_skills[SKILL_SOH] = %d;\n", $12; }
#	if (length($13) > 0) { printf "strcpy(sm[i].c_items, \"%s\");\n", $13; }
	
	printf "i++;\n\n";
}
