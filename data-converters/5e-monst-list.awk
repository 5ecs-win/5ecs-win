function addnote (str) {
	if (donote != 1 && length(str) > 1) {
		printf "fputs(\"+%d|%d|\", nof);\n", monCnt, monCnt;
		donote = 1;
	}
	printf "fputs(\"%s|\", nof);\n", str;
}

function note () {
	if (index($0, "&lt;div") != 0) {
		return;
	}
	if (donote != 1 && length($0) > 1) {
		printf "fputs(\"+%d|%d|\", nof);\n", monCnt, monCnt;
		donote = 1;
	}
	gsub("\"", "");
	gsub("{{5..", "");
	gsub("..5e SRD:", "");
	gsub("}}", "");
	gsub("]]", "");
	gsub("&lt;br/>", "");
	printf "fputs(\"%s|\", nof);\n", $0;
}

function weapon () {
	FS=" ";
	monWeapCnt=0;
	while (1) {
		getline;
		if (substr($0, 0, 1) == "|") {
			if (index($0, "legendary=") > 0) {
				FS="=";
				getline;
				gsub("}}", "", $3);
#printf "Legendary Action: %d", $3;
				lac = $3 + 0;
				if (lac > 0) { str = sprintf("Legendary Actions: %d", lac); addnote(str); }
				while (lac > 0) {
					getline;
					if (length($0) > 0) {
						gsub("'", "", $0);
						addnote($0);
						lac -= 1;
					}
				}
			}
			break;
		}
		if (length($0) > 0) {
			if ($0 == "}}") {
				return;
			}
			gsub("'[']*", "");
			gsub("\"", "");
#printf "W: %s\n", $0;
			if ($1 == "Multiattack." || $1 == "Multiattack:") {
				gsub("Multiattack[:.] ", "");
				gsub("Melee Weapon Attack: ", "");
				if (index($0, "makes two") > 0 || index($0, "makes 2") > 0) { printf "sm[%d].i_noAttacks = 2;\n", monCnt; }
				else if (index($0, "makes three") > 0 || index($0, "makes 3") > 0) { printf "sm[%d].i_noAttacks = 3;\n", monCnt; }
				else if (index($0, "makes four") > 0 || index($0, "makes 4") > 0) { printf "sm[%d].i_noAttacks = 4;\n", monCnt; }
				else if (index($0, "makes five") > 0 || index($0, "makes 5") > 0) { printf "sm[%d].i_noAttacks = 5;\n", monCnt; }
				printf "sm[%d].w_weapons[%d].i_attackBonus[0] = 0;\n", monCnt, monWeapCnt;
				printf "strncpy(sm[%d].w_weapons[%d].c_message, \"%s\", 79);\n", monCnt, monWeapCnt, $0;
				printf "strncpy(sm[%d].w_weapons[%d].c_description, \"%s\", 30);\n", monCnt, monWeapCnt, $0;
			} else {
				idx = match($0, ".eapon .ttack");
				idx1 = match($0, ".elee .ttack");
				idx2 = match($0, ".pell .ttack");
#printf "W: %s %d:%d:%d\n", $0, idx, idx1, idx2;
				if (idx > 0 || idx1 > 0 || idx2 > 0) {
					if (idx == 0) { idx = idx1; }
					if (idx == 0) { idx = idx2; }
					weapDesc = substr($0, 0, idx-2);
					gsub("{{5..", "", weapDesc);
					gsub("}}", "", weapDesc);
					gsub(".elee", "", weapDesc);
					gsub(".anged", "", weapDesc);
					gsub(".artial", "", weapDesc);
					gsub(".pell", "", weapDesc);
					gsub("\. $", "", weapDesc);
					printf "strncpy(sm[%d].w_weapons[%d].c_description, \"%s\", 30);\n", monCnt, monWeapCnt, weapDesc;
					idx3 = match($0, "to hit");
					weapLine=substr($0, idx3 - 9);
#printf "WL: %s : %d\n", weapLine, idx3 - 9;
					weapFldCnt = split(weapLine, weap, " ");
#printf "WL: %s:%s:%s\n", weap[1], weap[2], weap[3];
					weapFld=1;
					if (weap[2] == "to" && (weap[3] == "hit," || weap[3] == "hit")) {
						printf "sm[%d].w_weapons[%d].i_attackBonus[0] = %d;\n", monCnt, monWeapCnt, weap[1];
						weapFld=4;
					} else if (weap[3] == "to") {
						printf "sm[%d].w_weapons[%d].i_attackBonus[0] = %d;\n", monCnt, monWeapCnt, weap[2];
						weapFld=5;
					}
					while (weapFld <= weapFldCnt) {
						if (weap[weapFld] == "reach") {
							printf "sm[%d].w_weapons[%d].i_reach = %d;\n", monCnt, monWeapCnt, weap[weapFld+1];
							weapFld++;
						} else if (weap[weapFld] == "Hit:" || weap[weapFld] == "hit:" || weap[weapFld] == "Hit." || weap[weapFld] == "hit.") {
							weapFld++; weapFld++;
							gsub("[()]", "", weap[weapFld]);
							if (weap[weapFld+1] == "+") {
								gsub(")", "", weap[weapFld+2]);
								printf "strncpy(sm[%d].w_weapons[%d].c_damage, \"%s+%s\", 30);\n", monCnt, monWeapCnt, weap[weapFld], weap[weapFld+2];
							} else {
								printf "strncpy(sm[%d].w_weapons[%d].c_damage, \"%s\", 30);\n", monCnt, monWeapCnt, weap[weapFld];
							}
						}
						weapFld++;
					}
				}
			}
			monWeapCnt++;
		}
	}
	FS="=";
}

function stattobonus (stat) {
   if (stat == 0 || stat == 1) return -5;
   if (stat == 2 || stat == 3) return -4;
   if (stat == 4 || stat == 5) return -3;
   if (stat == 6 || stat == 7) return -2;
   if (stat == 8 || stat == 9) return -1;
   if (stat == 10 || stat == 11) return +0;
   if (stat == 12 || stat == 13) return +1; 
   if (stat == 14 || stat == 15) return +2;
   if (stat == 16 || stat == 17) return +3; 
   if (stat == 18 || stat == 19) return +4;
   if (stat == 20 || stat == 21) return +5;
   if (stat == 22 || stat == 23) return +6;
   if (stat == 24 || stat == 25) return +7;
   if (stat == 26 || stat == 27) return +8;
   if (stat == 28 || stat == 29) return +9;
   if (stat > 29) return +10;
}

function bonustostat (bonus) {
	stat = 10;
	bonus += 0;
	if (bonus < 0) { stat = 11 + (bonus * 2); } else { stat = 10 + (bonus * 2); }
	return stat;
}

BEGIN {
	#monCnt=325;
	FS="=";
	monName = -1;
	hp = 0;
	hd = "";
	sv[0] = sv[1] = sv[2] = sv[3] = sv[4] = sv[5] = sv[6] = 0;
	st[0] = st[1] = st[2] = st[3] = st[4] = st[5] = st[6] = 0;
	sk[0] = sk[1] = sk[2] = sk[3] = sk[4] = sk[5] = sk[6] = 0;
	savesok = 0;
	profbonus = 0;
	armor = 0;
	shield = 0;
	hdhp = 4.5;
}

{
#printf "1 = %s\n", $1;
	switch ($1) {
		case "|ac":
			printf "sm[%d].i_armorClass[AC_NORMAL] = %d;\n", monCnt, $2;
			armor = $2 + 0;
			break;
		case "|acrobatics":
			break;
		case "|actions":
			break;
		case "|alignment":
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
		case "|animalhandling":
			break;
		case "|arcana":
			break;
		case "|armor":
			if (armor == 0) {
				if ($2 == "plate") { armor = 1; }
				else if ($2 == "leather") { armor = 2; }
				else if ($2 == "studded") { armor = 3; }
				else if ($2 == "hide") { armor = 4; }
				else if ($2 == "breastplate") { armor = 5; }
				else if ($2 == "chain") { armor = 6; }
				else if ($2 == "scale") { armor = 7; }
			}
			break;
		case "|athletics":
			break;
		case "|cha":
			printf "sm[%d].i_abilityStats[0][ABILITY_CHA] = %d;\n", monCnt, $2;
			sv[5] = $2+0;
			break;
		case "|chamod":
			break;
		case "|chasave":
			#printf "sm[%d].i_savingThrows[SAVE_CHA] = %d;\n", monCnt, $2;
			st[5] = 1;
			break;
		case "|ci":
			ll = length($0);
			if (ll != 34 && ll != 35) {
				gsub("ci=", "CI:");
				note();
			}
			break;
		case "|con":
			printf "sm[%d].i_abilityStats[0][ABILITY_CON] = %d;\n", monCnt, $2;
			sv[2] = $2+0;
			break;
		case "|conmod":
			break;
		case "|consave":
			#printf "sm[%d].i_savingThrows[SAVE_CON] = %d;\n", monCnt, $2;
			st[2] = 1;
			break;
		case "|cr":
			nsaves = split($2, saves, " ");
			if (index(saves[1], "/") > 0) {
				if (saves[1] == "1/2") { saves[1] = "0.5"; }
				else if (saves[1] == "1/4") { saves[1] = "0.25"; }
				else if (saves[1] == "1/8") { saves[1] = "0.125"; }
				else { saves[1] = "1"; }
			} else if (index(saves[1], "&") > 0) { saves[1] = "1"; }
			if (saves[1] == "∞") { saves[1] = "10000"; }
			else if (saves[1] == "variable") { saves[1] = "10"; }
			else if (saves[1] == "X") { saves[1] = "10"; }
			else if (saves[1] == "-") { saves[1] = "0"; }
			if (length(saves[1]) == 0) { saves[1] = "1"; }
			printf "sm[%d].f_challengeRating = %s;\n", monCnt, saves[1];
			cr = saves[1] + 0;
			break;
		case "|deception":
			break;
		case "|description":
			break;
		case "|dex":
			printf "sm[%d].i_abilityStats[0][ABILITY_DEX] = %d;\n", monCnt, $2;
			sv[1] = $2+0;
			break;
		case "|dexmod":
			break;
		case "|dexsave":
			#printf "sm[%d].i_savingThrows[SAVE_DEX] = %d;\n", monCnt, $2;
			st[1] = 1;
			break;
		case "|di":
			ll = length($0);
			if (ll != 31 && ll != 32) {
				gsub("di=", "DI:");
				note();
			}
			break;
		case "|dr":
			break;
		case "|dv":
			break;
		case "|features":
			while (1) {
				getline;
				if (index($1, "Regeneration") > 0) {
					nwords = split($1, words, " ");
					while (nwords > 0) {
						if (words[nwords] == "regains") {
							printf "sm[%d].i_regeneration = %d;\n", monCnt, words[nwords+1];
							break;
						}
						nwords--;
					}
				}
				if ($1 == "|actions") { 
					weapon();
					break; 
				} else if ($1 == "}}") { 
					break;
				}
				gsub("'", "");
				note();
			}
			break;
		case "|hd":
			if (length($2) < 10 && length(hd) == 0) {
				printf "strcpy(sm[%d].c_hitDice, \"%s\");\n", monCnt, $2;
				hd=$2+0;
			}
			break;
		case "|history":
			break;
		case "|hp":
		   printf "sm[%d].i_hp[HP_MAX] = %d;\n", monCnt, $2;
         printf "sm[%d].i_hp[HP_CUR] = %d;\n", monCnt, $2;
			hp = $2 + 0;
         break;
		case "|hpdice":
			if (length($2) < 10 && length(hd) == 0) {
				printf "strcpy(sm[%d].c_hitDice, \"%s\");\n", monCnt, $2;
				hd = $2+0;
			}
			break;
		case "|insight":
			break;
		case "|int":
			printf "sm[%d].i_abilityStats[0][ABILITY_INT] = %d;\n", monCnt, $2;
			sv[3] = $2+0;
			break;
		case "|intimidation":
			break;
		case "|intmod":
			break;
		case "|intsave":
			#printf "sm[%d].i_savingThrows[SAVE_INT] = %d;\n", monCnt, $2;
			st[3] = 1;
			break;
		case "|investigation":
			break;
		case "|languages":
			break;
		case "|legendary":
			getline;
			gsub("}}", "=", $0);
#printf "Legendary Action: %d", $3;
#			str = sprintf("Legendary Action: %d", $3);
#			addnote(str);
			break;
		case "|medicine":
			break;
		case "|name":
			monCnt++;
			   printf "\n";
				gsub("%27", "'", $2);
				gsub("%C3", "", $2);
				gsub("%60", "", $2);
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
				donote = 0;
			break;
		case "|nature":
			break;
		case "|perception":
			if ($2 == "yes") { sk[0] = 1; }
			if ($2 == "expertise") { sk[0] = 2; }
			break;
		case "|performance":
			break;
		case "|persuasion":
			break;
		case "|proficiency":
			profbonus = $2+0;
			break;
		case "|race":
			break;
		case "|racemanual":
			break;
		case "|reactions":
			break;
		case "|religion":
			break;
		case "|saves":
			if (length($0) < 10) { break; }
			gsub("}}", "", $2);
			gsub("]]", "", $2);
			gsub("{{5E|", "", $2);
			gsub("..5E|", "", $2);
			gsub("..5e|", "", $2);
			gsub("SRD:|", "", $2);
			gsub("{{5.|Wisdom|", "", $2);
			gsub("{{5.|Strength|", "", $2);
			gsub("{{5.|Intelligence|", "", $2);
			gsub("{{5.|Dexterity|", "", $2);
			gsub("{{5.|Constitution|", "", $2);
			gsub("{{5.|Charisma|", "", $2);
			gsub("Wisdom", "Wis", $2);
			gsub("Strength", "Str", $2);
			gsub("Intelligence", "Int", $2);
			gsub("Dexterity", "Dex", $2);
			gsub("Constitution", "Con", $2);
			gsub("Charisma", "Cha", $2);
			gsub("[|]", "", $2);
#printf "SV = %s\n", $2
			nsaves = split($2, saves, ",");
			cnt = 1;
			while (cnt <= nsaves) {
				split(saves[cnt], save, " ");
				switch (save[1]) {
					case "Str": 
					case "str": 
#			printf "sm[%d].i_abilityStats[0][ABILITY_STR] = %d;\n", monCnt, bonustostat(save[2]);
			printf "sm[%d].i_savingThrows[SAVE_STR] = %d;\n", monCnt, save[2];
			savesok = 1;
						break;
					case "Dex": 
					case "dex": 
#			printf "sm[%d].i_abilityStats[0][ABILITY_DEX] = %d;\n", monCnt, bonustostat(save[2]);
			printf "sm[%d].i_savingThrows[SAVE_DEX] = %d;\n", monCnt, save[2];
			savesok = 1;
						break;
					case "Con": 
					case "con": 
#			printf "sm[%d].i_abilityStats[0][ABILITY_CON] = %d;\n", monCnt, bonustostat(save[2]);
			printf "sm[%d].i_savingThrows[SAVE_CON] = %d;\n", monCnt, save[2];
			savesok = 1;
						break;
					case "Int": 
					case "int": 
#			printf "sm[%d].i_abilityStats[0][ABILITY_INT] = %d;\n", monCnt, bonustostat(save[2]);
			printf "sm[%d].i_savingThrows[SAVE_INT] = %d;\n", monCnt, save[2];
			savesok = 1;
						break;
					case "Wis": 
					case "wis": 
#			printf "sm[%d].i_abilityStats[0][ABILITY_WIS] = %d;\n", monCnt, bonustostat(save[2]);
			printf "sm[%d].i_savingThrows[SAVE_WIS] = %d;\n", monCnt, save[2];
			savesok = 1;
						break;
					case "Cha": 
					case "cha": 
#			printf "sm[%d].i_abilityStats[0][ABILITY_CHA] = %d;\n", monCnt, bonustostat(save[2]);
			printf "sm[%d].i_savingThrows[SAVE_CHA] = %d;\n", monCnt, save[2];
			savesok = 1;
						break;
				}
				cnt++;
			}
			break;
		case "|senses":
			break;

		case "|shapechanger":
			break;
		case "|shield":
			if ($2 == "no") { shield = 0; } else { shield = 1; }
			break;

		case "|size":
			switch ($2) {
				case "colossal":
				case "Colossal":
				case "Colossal+":
					printf "sm[%d].i_space = 40;\n", monCnt;
					hdhp = 10.5;
					break;
				case "gargantuan":
				case "Gargantuan":
				case "Gargantuan ":
					printf "sm[%d].i_space = 30;\n", monCnt;
					hdhp = 10.5;
					break;
				case "Giant":
					printf "sm[%d].i_space = 20;\n", monCnt;
					hdhp = 6.5;
					break;
				case "huge":
				case "Huge":
					printf "sm[%d].i_space = 20;\n", monCnt;
					hdhp = 6.5;
					break;
				case "large":
				case "Large":
				case "Large ":
					printf "sm[%d].i_space = 10;\n", monCnt;
					hdhp = 5.5;
					break;
				case "medium":
				case "Medium":
					printf "sm[%d].i_space = 5;\n", monCnt;
					hdhp = 4.5;
					break;
				case "small":
				case "Small":
					printf "sm[%d].i_space = 0;\n", monCnt;
					hdhp = 3.5;
					break;
				case "tiny":
				case "Tiny":
					printf "sm[%d].i_space = 0;\n", monCnt;
					hdhp = 2.5;
					break;
				case "Titan":
				case "Titanic":
					printf "sm[%d].i_space = 50;\n", monCnt;
					hdhp = 50.5;
					break;
			}
			break;
		case "|skills":
			if (length($0) < 10) {
				break;
			}
			gsub("{{5..", "", $0);
			gsub("}}", "", $0);
			gsub("=", ": ", $0);
			gsub("|", "", $0);
			skillCnt = split($0, skills, " ");
			skillFld = 1;
			while (skillFld <= skillCnt) {
				if (skills[skillFld] == "Perception" || skills[skillFld] == "{{5s|Perception}}") {
					printf "sm[%d].i_skills[SKILL_SPOT] = %d;\n", monCnt, skills[skillFld+1];
				} else if (skills[skillFld] == "Stealth" || skills[skillFld] == "{{5s|Stealth}}") {
					printf "sm[%d].i_skills[SKILL_MOVESILENTLY] = %d;\n", monCnt, skills[skillFld+1];
				}
				skillFld++;
			}
			note();
			break;
		case "|sleightofhand":
			break;
		case "|speed":
			printf "sm[%d].i_speed = %d;\n", monCnt, $2;
			break;
		case "|stealth":
			if ($2 == "yes") { sk[1] = 1; }
			if ($2 == "expertise") { sk[1] = 2; }
			#printf "sm[%d].i_skills[SKILL_MOVESILENTLY] = %d;\n", monCnt, $1;
			break;
		case "|str":
			printf "sm[%d].i_abilityStats[0][ABILITY_STR] = %d;\n", monCnt, $2;
			sv[0] = $2+0;
			break;
		case "|strmod":
			break;
		case "|strsave":
			#printf "sm[%d].i_savingThrows[SAVE_STR] = %d;\n", monCnt, $2;
			st[0] = 1;
			break;
		case "|style":
			break;
		case "|survival":
			break;
		case "|swarm":
			break;
		case "|type":
			break;
		case "|wis":
			printf "sm[%d].i_abilityStats[0][ABILITY_WIS] = %d;\n", monCnt, $2;
			sv[4] = $2+0;
			break;
		case "|wismod":
			break;
		case "|wissave":
			#printf "sm[%d].i_savingThrows[SAVE_WIS] = %d;\n", monCnt, $2;
			st[4] = 1;
			break;
		case "|xp":
			if ($2 == "???") { printf "sm[%d].i_xp[0] = 0;\n", monCnt; break; }
			if ($2 == "1E25") { printf "sm[%d].i_xp[0] = 1000000;\n", monCnt; break; }
			if (length($2) > 1 && length($2) < 10) {
				gsub("[,XxPp ]", "", $2);
				if ($2 == "Variable" || $2 == "Atleast10000" || $2 == "1100(2900)") {
					break;
				}
				printf "sm[%d].i_xp[0] = %s;\n", monCnt, $2;
			}
			break;
		default:
			break;
	}
}

END {
	if (donote == 1) {
		printf "fputs(\"\\n\", nof);\n";
	}
	if (hp == 0 && length(hd) > 0) {
		hp = (hd * hdhp) + (stattobonus(sv[2]) * hd);
		printf "sm[%d].i_hp[HP_MAX] = %d;\n", monCnt, hp;
      printf "sm[%d].i_hp[HP_CUR] = %d;\n", monCnt, hp;
	}
	if (profbonus == 0) { profbonus = 1 + (cr / 4); }
	if (savesok == 0) {
#printf "%d %d:%d:%d:%d:%d:%d\n", profbonus, sv[0], sv[1], sv[2], sv[3], sv[4], sv[5], sv[6];
#printf "%d:%d:%d:%d:%d:%d\n", st[0], st[1], st[2], st[3], st[4], st[5], st[6];
		#if (st[0] != 0 && sv[0] != 0) { printf "sm[%d].i_savingThrows[SAVE_STR] = %d;\n", monCnt, profbonus + stattobonus(sv[0]); }
		#if (st[1] != 0 && sv[1] != 0) { printf "sm[%d].i_savingThrows[SAVE_DEX] = %d;\n", monCnt, profbonus + stattobonus(sv[1]); }
		#if (st[2] != 0 && sv[2] != 0) { printf "sm[%d].i_savingThrows[SAVE_CON] = %d;\n", monCnt, profbonus + stattobonus(sv[2]); }
		#if (st[3] != 0 && sv[3] != 0) { printf "sm[%d].i_savingThrows[SAVE_INT] = %d;\n", monCnt, profbonus + stattobonus(sv[3]); }
		#if (st[4] != 0 && sv[0] != 0) { printf "sm[%d].i_savingThrows[SAVE_WIS] = %d;\n", monCnt, profbonus + stattobonus(sv[4]); }
		#if (st[5] != 0 && sv[5] != 0) { printf "sm[%d].i_savingThrows[SAVE_CHA] = %d;\n", monCnt, profbonus + stattobonus(sv[5]); }
		if (sv[0] != 0) { printf "sm[%d].i_savingThrows[SAVE_STR] = %d;\n", monCnt, profbonus + stattobonus(sv[0]); }
		if (sv[1] != 0) { printf "sm[%d].i_savingThrows[SAVE_DEX] = %d;\n", monCnt, profbonus + stattobonus(sv[1]); }
		if (sv[2] != 0) { printf "sm[%d].i_savingThrows[SAVE_CON] = %d;\n", monCnt, profbonus + stattobonus(sv[2]); }
		if (sv[3] != 0) { printf "sm[%d].i_savingThrows[SAVE_INT] = %d;\n", monCnt, profbonus + stattobonus(sv[3]); }
		if (sv[4] != 0) { printf "sm[%d].i_savingThrows[SAVE_WIS] = %d;\n", monCnt, profbonus + stattobonus(sv[4]); }
		if (sv[5] != 0) { printf "sm[%d].i_savingThrows[SAVE_CHA] = %d;\n", monCnt, profbonus + stattobonus(sv[5]); }
	}
	if (armor == 0) {
		printf "sm[%d].i_armorClass[AC_NORMAL] = %d;\n", monCnt, 10 + stattobonus(sv[1]);
	} else if (armor < 10) {
		if (armor == 1) { armor = 18; }
		else if (armor == 2) { armor = 11 + stattobonus(sv[1]); }
		else if (armor == 3) { armor = 12 + stattobonus(sv[1]); }
		else if (armor == 4) { armor = 12 + stattobonus(sv[1]); if (armor > 14) { armor = 14; } }
		else if (armor == 5) { armor = 14 + stattobonus(sv[1]); if (armor > 16) { armor = 16; } }
		else if (armor == 6) { armor = 13 + stattobonus(sv[1]); if (armor > 15) { armor = 15; } }
		else if (armor == 7) { armor = 14 + stattobonus(sv[1]); if (armor > 16) { armor = 16; } }
		else { armor = 10 + stattobonus(sv[1]); }
		if (shield == 1) { armor += 2; }
		printf "sm[%d].i_armorClass[AC_NORMAL] = %d;\n", monCnt, armor;
	}
	if (sk[0] == 1) { printf "sm[%d].i_skills[SKILL_SPOT] = %d;\n", monCnt, profbonus + stattobonus(sv[4]); }
	if (sk[0] == 2) { printf "sm[%d].i_skills[SKILL_SPOT] = %d;\n", monCnt, (profbonus + stattobonus(sv[4]))*2; }

	if (sk[1] == 1) { printf "sm[%d].i_skills[SKILL_MOVESILENTLY] = %d;\n", monCnt, profbonus + stattobonus(sv[1]); }
	if (sk[1] == 2) { printf "sm[%d].i_skills[SKILL_MOVESILENTLY] = %d;\n", monCnt, (profbonus + stattobonus(sv[1]))*2; }

	if (sv[1] != 0) { printf "sm[%d].i_initiative[0] = %d;\n", monCnt, stattobonus(sv[1]); }
}
