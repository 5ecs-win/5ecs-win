BEGIN {
	FS=":";
	monName = -1;
}

{
	switch($1) {
		case "acrobatics": 
			break;
		case "actions": 
			weapGo = 1;
			break;
		case "alignment": 
			val = 7;
			switch ($2) {
				case "chaotic evil":
					val = 9;
					break;
				case "chaotic good":
					val = 7;
					break;
				case "chaotic neutral":
					val = 8;
					break;
				case "lawful evil":
					val = 3;
					break;
				case "lawful good":
					val = 1;
					break;
				case "lawful neutral":
					val = 2;
					break;
				case "neutral":
					val = 5;
					break;
				case "neutral evil":
					val = 6;
					break;
				case "neutral good":
					val = 4;
					break;
			}
			printf "sm[%d].i_alignment = %d;\n", monCnt, val;
			break;
		case "arcana": 
			break;
		case "armor_class": 
			printf "sm[%d].i_armorClass[AC_NORMAL] = %d;\n", monCnt, $2;
			break;
		case "athletics": 
			break;
		case "attack_bonus": 
			if (monWeapCnt == -1) {
			} else {
				if ($2 != "0") {
					printf "sm[%d].w_weapons[%d].i_attackBonus[0] = %d;\n", monCnt, monWeapCnt, $2;
				}
			}
			break;
		case "burrow": 
			break;
		case "challenge_rating": 
			printf "sm[%d].f_challengeRating = %f;\n", monCnt, $2;
			break;
		case "charisma": 
			printf "sm[%d].i_abilityStats[0][ABILITY_CHA] = %d;\n", monCnt, $2;
			break;
		case "charisma_save": 
			printf "sm[%d].i_savingThrows[SAVE_CHA] = %d;\n", monCnt, $2;
			break;
		case "climb": 
			break;
		case "condition_immunities": 
			break;
		case "constitution": 
			printf "sm[%d].i_abilityStats[0][ABILITY_CON] = %d;\n", monCnt, $2;
			break;
		case "constitution_save": 
			printf "sm[%d].i_savingThrows[SAVE_CON] = %d;\n", monCnt, $2;
			break;
		case "damage_bonus": 
			printf "strcat(sm[%d].w_weapons[%d].c_damage, \"+%s\");\n", monCnt, monWeapCnt, $2;
			break;
		case "damage_dice": 
			printf "strncpy(sm[%d].w_weapons[%d].c_damage, \"%s\", 20);\n", monCnt, monWeapCnt, $2;
			break;
		case "damage_immunities": 
			if (length($2) > 0) {
				printf "fputs(\"%s|\", nof);\n", $0;
			}
			break;
		case "damage_resistances": 
			if (length($2) > 0) {
				printf "fputs(\"%s|\", nof);\n", $0;
			}
			break;
		case "damage_vulnerabilities": 
			if (length($2) > 0) {
				printf "fputs(\"%s|\", nof);\n", $0;
			}
			break;
		case "deception": 
			break;
		case "desc": 
			if (monWeapCnt == -1) {
			} else {
				if (index($0, "makes five") > 0) { printf "sm[%d].i_noAttacks = 5;\n", monCnt; }
				else if (index($0, "makes four") > 0) { printf "sm[%d].i_noAttacks = 4;\n", monCnt; }
				else if (index($0, "makes three") > 0) { printf "sm[%d].i_noAttacks = 3;\n", monCnt; }
				else if (index($0, "makes two") > 0) { printf "sm[%d].i_noAttacks = 2;\n", monCnt; }
				gsub("Melee Weapon Attack: ", "");
				printf "strncpy(sm[%d].w_weapons[%d].c_message, \"%s\", 79);\n", monCnt, monWeapCnt, $0;
				melee = sprintf("%s", $0);
				gsub(":", " ", melee);
				wd = split(melee, wda, " ");
				cnt = 1;
				while (cnt <= wd) {
					if (wda[cnt] == "desc") {
						printf "sm[%d].w_weapons[%d].i_attackBonus[0] = %d;\n", monCnt, monWeapCnt, wda[cnt+1];
						cnt++;
					} else if (wda[cnt] == "Hit") {
						ts = sprintf("%s+%s", wda[cnt+2], wda[cnt+4]);
						gsub("[()]", "", ts);
						printf "strcat(sm[%d].w_weapons[%d].c_damage, \"%s\");\n", monCnt, monWeapCnt, ts;
					}
					cnt++;
				}
			}
			break;
		case "dexterity": 
			printf "sm[%d].i_abilityStats[0][ABILITY_DEX] = %d;\n", monCnt, $2;
			break;
		case "dexterity_save": 
			printf "sm[%d].i_savingThrows[SAVE_DEX] = %d;\n", monCnt, $2;
			break;
		case "fly": 
			break;
		case "form": 
			break;
		case "history": 
			break;
		case "hit_dice": 
			printf "strcpy(sm[%d].c_hitDice, \"%s\");\n", monCnt, $2;
			break;
		case "hit_points": 
			printf "sm[%d].i_hp[HP_MAX] = %d;\n", monCnt, $2;
			printf "sm[%d].i_hp[HP_CUR] = %d;\n", monCnt, $2;
			break;
		case "hover": 
			break;
		case "index": 
			monCnt = $2 - 1;
			monName = -1;
			break;
		case "insight": 
#/			printf "sm[%d].i_skills[SKILL_SPOT] = %d;\n", monCnt, $2;
			break;
		case "intelligence": 
			printf "sm[%d].i_abilityStats[0][ABILITY_INT] = %d;\n", monCnt, $2;
			break;
		case "intelligence_save": 
			printf "sm[%d].i_savingThrows[SAVE_INT] = %d;\n", monCnt, $2;
			break;
		case "intimidation": 
#/			printf "sm[%d].i_skills[SKILL_SPOT] = %d;\n", monCnt, $2;
			break;
		case "investigation": 
#/			printf "sm[%d].i_skills[SKILL_SPOT] = %d;\n", monCnt, $2;
			break;
		case "languages": 
			break;
		case "legendary_actions": 
			printf "fputs(\"Legendary Actions:|\", nof);\n";
			while (1) {
				getline;
				if ($0 == "}]") { break; }
				if ($1 == "name") { lan = $2; }
				if ($1 == "desc") { printf "fputs(\"%s %s|\", nof);\n", lan, $2; }
			}
			break;
		case "medicine": 
			break;
		case "name": 
			if (monName == -1) {
				printf "\n";
				printf "strncpy(sm[%d].c_name, \"%s\", 30);\n", monCnt, $2;
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
				monWeapCnt = -1;
				monName = 1;
				weapGo = -1;
				if (monCnt > 0) {
					printf "fputs(\"\\n+%d|%d|\", nof);\n", monCnt, monCnt;
				} else {
					printf "fputs(\"+%d|%d|\", nof);\n", monCnt, monCnt;
				}
			} else {
				if (weapGo == 1) {
					monWeapCnt++;
					printf "strncpy(sm[%d].w_weapons[%d].c_description, \"%s\", 30);\n", monCnt, monWeapCnt, $2;
					weapDamBonus = "";
				}
			}
			monName = 1;
			break;
		case "nature": 
			break;
		case "other_speeds": 
			break;
		case "perception": 
			printf "sm[%d].i_skills[SKILL_SPOT] = %d;\n", monCnt, $2;
			break;
		case "performance": 
			break;
		case "persuasion": 
#/			printf "sm[%d].i_skills[SKILL_SPOT] = %d;\n", monCnt, $2;
			break;
		case "reactions": 
			break;
		case "religion": 
			break;
		case "senses": 
			break;
		case "size": 
			switch ($2) {
				case "Gargantuan":
					printf "sm[%d].i_size = 40;\n", monCnt;
					printf "sm[%d].i_reach = 40;\n", monCnt;
					printf "sm[%d].i_space = 40;\n", monCnt;
					break;
				case "Huge":
					printf "sm[%d].i_size = 20;\n", monCnt;
					printf "sm[%d].i_reach = 20;\n", monCnt;
					printf "sm[%d].i_space = 20;\n", monCnt;
					break;
				case "Large":
					printf "sm[%d].i_size = 10;\n", monCnt;
					printf "sm[%d].i_reach = 10;\n", monCnt;
					printf "sm[%d].i_space = 10;\n", monCnt;
					break;
				case "Medium":
					printf "sm[%d].i_size = 5;\n", monCnt;
					printf "sm[%d].i_reach = 5;\n", monCnt;
					printf "sm[%d].i_space = 5;\n", monCnt;
					break;
				case "Small":
					printf "sm[%d].i_size = 5;\n", monCnt;
					printf "sm[%d].i_reach = 5;\n", monCnt;
					printf "sm[%d].i_space = 5;\n", monCnt;
					break;
				case "Tiny":
					printf "sm[%d].i_size = 5;\n", monCnt;
					printf "sm[%d].i_reach = 5;\n", monCnt;
					printf "sm[%d].i_space = 5;\n", monCnt;
					break;
			}
			break;
		case "special_abilities": 
			break;
		case "speed": 
			break;
		case "stealth": 
			printf "sm[%d].i_skills[SKILL_MOVESILENTLY] = %d;\n", monCnt, $2;
			break;
		case "strength": 
			printf "sm[%d].i_abilityStats[0][ABILITY_STR] = %d;\n", monCnt, $2;
			break;
		case "strength_save": 
			printf "sm[%d].i_savingThrows[SAVE_STR] = %d;\n", monCnt, $2;
			break;
		case "subtype": 
			break;
		case "survival": 
			break;
		case "swim": 
			break;
		case "type": 
			break;
		case "walk": 
			printf "sm[%d].i_speed = %d;\n", monCnt, $2;
			break;
		case "wisdom": 
			printf "sm[%d].i_abilityStats[0][ABILITY_WIS] = %d;\n", monCnt, $2;
			break;
		case "wisdom_save": 
			printf "sm[%d].i_savingThrows[SAVE_WIS] = %d;\n", monCnt, $2;
			break;
	}
}

END {
}
