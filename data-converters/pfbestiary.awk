BEGIN {
	FS="|";
	printf "i=0;\n";
	srand();

	printf "=003083\n" > "pfsrdmon.snt";

	monCnt=0;
}

# 01 - Name
# 02 - CR
# 03 - XP
# 04 - Race
# 05 - Class
# 06 - MonsterSource
# 07 - Alignment
# 08 - Size
# 09 - Type
# 10 - SubType
# 11 - Init
# 12 - Senses
# 13 - Aura
# 14 - AC
# 15 - AC_Mods
# 16 - HP
# 17 - HD
# 18 - HP_Mods
# 19 - Saves
# 20 - Fort
# 21 - Ref
# 22 - Will
# 23 - Save_Mods
# 24 - DefensiveAbilities
# 25 - DR
# 26 - Immune
# 27 - Resist
# 28 - SR
# 29 - Weaknesses
# 30 - Speed
# 31 - Speed_Mod
# 32 - Melee
# 33 - Ranged
# 34 - Space
# 35 - Reach
# 36 - SpecialAttacks
# 37 - SpellLikeAbilities
# 38 - SpellsKnown
# 39 - SpellsPrepared
# 40 - SpellDomains
# 41 - AbilityScores
# 42 - AbilityScore_Mods
# 43 - BaseAtk
# 44 - CMB
# 45 - CMD
# 46 - Feats
# 47 - Skills
# 48 - RacialMods
# 49 - Languages
# 50 - SQ
# 51 - Environment
# 52 - Organization
# 53 - Treasure
# 54 - Description_Visual
# 55 - Group
# 56 - Source
# 57 - IsTemplate
# 58 - SpecialAbilities
# 59 - Description
# 60 - FullText
# 61 - Gender
# 62 - Bloodline
# 63 - ProhibitedSchools
# 64 - BeforeCombat
# 65 - DuringCombat
# 66 - Morale
# 67 - Gear
# 68 - OtherGear
# 69 - Vulnerability
# 70 - Note
# 71 - CharacterFlag
# 72 - CompanionFlag
# 73 - Fly
# 74 - Climb
# 75 - Burrow
# 76 - Swim
# 77 - Land
# 78 - TemplatesApplied
# 79 - OffenseNote
# 80 - BaseStatistics
# 81 - ExtractsPrepared
# 82 - AgeCategory
# 83 - DontUseRacialHD
# 84 - VariantParent
# 85 - Mystery
# 86 - ClassArchetypes
# 87 - Patron
# 88 - CompanionFamiliarLink
# 89 - FocusedSchool
# 90 - Traits
# 91 - AlternateNameForm
# 92 - StatisticsNote
# 93 - LinkText
# 94 - id
# 95 - UniqueMonster
# 96 - MR
# 97 - Mythic
# 98 - MT

#############################################
function roll(n) { return 1 + int(rand() * n) }

#############################################
function isdigit(stg) {
   gsub("[+-]*[0-9]*", "", stg);
   if (length(stg) == 0) { return 1; }
   return 0;
}

#############################################
function parseAC(ac, acsplit) {
	gsub(",", "", ac); c = split(ac, acsep, " ");
	printf "sm[%d].i_armorClass[AC_NORMAL] = %d;\n", monCnt, acsep[1];
	printf "sm[%d].i_armorClass[AC_TOUCH] = %d;\n", monCnt, acsep[3];
	printf "sm[%d].i_armorClass[AC_FLATFOOTED] = %d;\n", monCnt, acsep[5];

	gsub("[)(]", " ", acsplit);
	gsub("[(,)]", "", acsplit); c = split(acsplit, acsplitsep, " ");
	for (x = 1; x <= c; x++) {
		if (isdigit(acsplitsep[x]) == 1) {
			nbr = acsplitsep[x];
		} else {
			if (acsplitsep[x] == "armor") { printf "sm[%d].i_armorClassSplit[AC_SECTION_ARMOR] = %d;\n", monCnt, nbr; }
			if (acsplitsep[x] == "Dex") { printf "sm[%d].i_armorClassSplit[AC_SECTION_DEX] = %d;\n", monCnt, nbr; }
			if (acsplitsep[x] == "dodge") { printf "sm[%d].i_armorClassSplit[AC_SECTION_DODGE] = %d;\n", monCnt, nbr; }
			if (acsplitsep[x] == "natural") { printf "sm[%d].i_armorClassSplit[AC_SECTION_NATURAL] = %d;\n", monCnt, nbr; }
			if (acsplitsep[x] == "size") { printf "sm[%d].i_armorClassSplit[AC_SECTION_SIZE] = %d;\n", monCnt, nbr; }
			if (acsplitsep[x] == "shield") { printf "sm[%d].i_armorClassSplit[AC_SECTION_SHIELD] = %d;\n", monCnt, nbr; }
			if (acsplitsep[x] == "deflection" && isdigit(acsplitsep[x+1]) == 1) { printf "sm[%d].i_armorClassSplit[AC_SECTION_DEFLECTION] = %d;\n", monCnt, nbr; }
		}
	}
}

#############################################
function parseWeapons(weapCnt, weapons) {
	if (length(weapons) < 2) {
		return;
	}
	noattks=1;
	c = split(weapons, wpsep, ",");
	for (j=1; j<=c; j++) {
		cc = split(wpsep[j], wp, " ");
		magic=0; st=1; desc=""; mesg="";
		if (isdigit(wp[1]) == 1) {
			if (substr(wp[1], 1, 1) == "+") { 
				printf "sm[%d].w_weapons[%d].i_magicalBonus = %d;\n", monCnt, j+weapCnt, wp[1]; magic=wp[1]+0;
			} else { 
				printf "sm[%d].w_weapons[%d].i_noAttacks = %d;\n", monCnt, j+weapCnt, wp[1]; 
			}
			st=2;
			mesg=wp[1];
		} else {
			printf "sm[%d].w_weapons[%d].i_noAttacks = 1;\n", monCnt, j+weapCnt;
			printf "sm[%d].w_weapons[%d].i_magicalBonus = 0;\n", monCnt, j+weapCnt;
		}
		for (i=st; i<=cc; i++) {
			if (wp[i] != "or" && wp[i] != "plus" && wp[i] != "and") {
				if (length(mesg) > 0) {
					mesg = sprintf("%s %s", mesg, wp[i]);
				} else {
					mesg = sprintf("%s", wp[i]);
				}
			}
			if (substr(wp[i], 1, 1) == "(") {
				gsub("[()]", "",  wp[i]);
				if (index(wp[i], "/") > 0) {
					split(wp[i], dam, "/");
					printf "strncpy(sm[%d].w_weapons[%d].c_damage, \"%s\", 20);\n", monCnt, j+weapCnt, dam[1];
					printf "strncpy(sm[%d].w_weapons[%d].c_critical, \"%s\", 20);\n", monCnt, j+weapCnt, dam[2];
				} else {
					printf "strncpy(sm[%d].w_weapons[%d].c_damage, \"%s\", 20);\n", monCnt, j+weapCnt, wp[i];
				}
			} else {
				if (substr(wp[i], 1, 1) == "+" || substr(wp[i], 1, 1) == "-") {
					ccc = split(wp[i], ab, "/");
					for (k=1; k<=ccc; k++) {
						printf "sm[%d].w_weapons[%d].i_attackBonus[%d] = %d;\n", monCnt, j+weapCnt, k-1, ab[k];
					}
				} else {
					if (wp[i] == "or" || wp[i] == "plus" || wp[i] == "and") {
						if (wp[i] == "plus" || wp[i] == "and") {
							noattks++;
						}
						gsub("[()]", "",  desc);
						if (magic == 0) {
							printf "strncpy(sm[%d].w_weapons[%d].c_description, \"%s\", 30);\n", monCnt, j+weapCnt, desc;
						} else {
							printf "strncpy(sm[%d].w_weapons[%d].c_description, \"%s +%d\", 30);\n", monCnt, j+weapCnt, desc, magic;
						}
						if (index(mesg, ")") == 0 && index(mesg, "(") > 0) {
							printf "strncpy(sm[%d].w_weapons[%d].c_message, \"%s)\", 40);\n", monCnt, j+weapCnt, mesg;
						} else {
							printf "strncpy(sm[%d].w_weapons[%d].c_message, \"%s\", 40);\n", monCnt, j+weapCnt, mesg;
						}
						printf "sm[%d].w_weapons[%d].c_available = 1;\n", monCnt, j+weapCnt;
						weapCnt++;
						magic=0; st=1; desc=""; mesg="";
						printf "sm[%d].w_weapons[%d].i_noAttacks = 1;\n", monCnt, j+weapCnt;
						gsub("[()]", "",  wp[i+1]);
					} else {
						if (length(desc) > 0) {
							desc = sprintf("%s %s", desc, wp[i]);
						} else {
							desc = sprintf("%s", wp[i]);
						}
					}
				}
			}
		}
		gsub("[()]", "",  desc);
		if (magic == 0) {
			printf "strncpy(sm[%d].w_weapons[%d].c_description, \"%s\", 30);\n", monCnt, j+weapCnt, desc;
		} else {
			printf "strncpy(sm[%d].w_weapons[%d].c_description, \"%s +%d\", 30);\n", monCnt, j+weapCnt, desc, magic;
		}
		if (index(mesg, ")") == 0 && index(mesg, "(") > 0) {
			printf "strncpy(sm[%d].w_weapons[%d].c_message, \"%s)\", 40);\n", monCnt, j+weapCnt, mesg;
		} else {
			printf "strncpy(sm[%d].w_weapons[%d].c_message, \"%s\", 40);\n", monCnt, j+weapCnt, mesg;
		}
		printf "sm[%d].w_weapons[%d].c_available = 1;\n", monCnt, j+weapCnt;
	}
	printf "sm[%d].i_noAttacks = %d;\n", monCnt, noattks;
}

#############################################

#############################################
{
	printf "strncpy(sm[%d].c_name, \"%s\", 30);\n", monCnt, $1;

	val = 0;
	switch ($7) {
		case "LG": val = 1; break;
		case "LN": val = 2; break;
		case "LE": val = 3; break;
		case "NG": val = 4; break;
		case "N": val = 5; break;
		case "NE": val = 6; break;
		case "CG": val = 7; break;
		case "CN": val = 8; break;
		case "CE": val = 9; break;
	}
	printf "sm[%d].i_alignment = %d;\n", monCnt, val;

	printf "sm[%d].i_hp[HP_MAX] = %d;\n", monCnt, $16;
	printf "sm[%d].i_hp[HP_CUR] = %d;\n", monCnt, $16;

	printf "sm[%d].i_bleeding = 0;\n", monCnt;
	printf "sm[%d].i_disabledAt = 0;\n", monCnt;
	printf "sm[%d].i_unconciousAt = -1;\n", monCnt;

	printf "sm[%d].i_savingThrows[SAVE_FORTITUDE] = %d;\n", monCnt, $20;
	printf "sm[%d].i_savingThrows[SAVE_REFLEX] = %d;\n", monCnt, $21;
	printf "sm[%d].i_savingThrows[SAVE_WISDOM] = %d;\n", monCnt, $22;

	parseAC($14,$15);

	printf "sm[%d].i_bab[BAB_MELEE][0] = %d;\n", monCnt, $43;
#	printf "sm[%d].i_bab[BAB_MELEE][1] = %d;\n", monCnt, $
#	printf "sm[%d].i_bab[BAB_MELEE][2] = %d;\n", monCnt, $
#	printf "sm[%d].i_bab[BAB_RANGED][0] = %d;\n", monCnt, $
#	printf "sm[%d].i_bab[BAB_RANGED][1] = %d;\n", monCnt, $
#	printf "sm[%d].i_bab[BAB_RANGED][2] = %d;\n", monCnt, $

	split($44, grap, " ");	# CMB
	if (isdigit(grap[1]) == 1) { printf "sm[%d].i_bab[BAB_GRAPPLE][0] = %d;\n", monCnt, grap[1]; }
	split($45, grap, " ");	# CMD
	if (isdigit(grap[1]) == 1) { printf "sm[%d].i_bab[BAB_GRAPPLE][2] = %d;\n", monCnt, grap[1]; }

	printf "sm[%d].i_initiative[0] = %d;\n", monCnt, $11;

	split($30, spd, " ");
	printf "sm[%d].i_speed = %d;\n", monCnt, spd[1];

	printf "sm[%d].i_inactive = 0;\n", monCnt;
	printf "sm[%d].i_stun = 0;\n", monCnt;

#	printf "sm[%d].i_regeneration = %d;\n", monCnt, $

	c = split($27, resist, ",");
	for (i=1; i<=c; i++) {
		split(resist[i], resistsep, " ");
		if (resistsep[1] == "fire") { printf "sm[%d].i_resistances[0] = %d;\n", monCnt, resistsep[2]; }
		if (resistsep[1] == "acid") { printf "sm[%d].i_resistances[1] = %d;\n", monCnt, resistsep[2]; }
		if (resistsep[1] == "cold") { printf "sm[%d].i_resistances[2] = %d;\n", monCnt, resistsep[2]; }
		if (resistsep[1] == "electricity") { printf "sm[%d].i_resistances[3] = %d;\n", monCnt, resistsep[2]; }
		if (resistsep[1] == "sonic") { printf "sm[%d].i_resistances[4] = %d;\n", monCnt, resistsep[2]; }
		if (resistsep[1] == "poison") { printf "sm[%d].i_resistances[5] = %d;\n", monCnt, resistsep[2]; }
	}
#	printf "strcpy(sm[%d].c_iconFile, "icons/monster/goblin_runner.png"); = %d;\n", $
#	printf "strcpy(sm[%d].c_items, ""); = %d;\n", $

#	printf "sm[%d].i_negateCrit = %d;\n", $

	if (index($2, "/") > 0) {
		split($2, cr, "/");
		crval = 1 / cr[2];
		printf "sm[%d].f_challengeRating = %f;\n", monCnt, crval;
	} else {
		printf "sm[%d].f_challengeRating = %d;\n", monCnt, $2;
	}

	printf "sm[%d].i_d20Rolls[0] = %d;\n", monCnt, roll(20);
	printf "sm[%d].i_d20Rolls[1] = %d;\n", monCnt, roll(20);
	printf "sm[%d].i_d20Rolls[2] = %d;\n", monCnt, roll(20);
	printf "sm[%d].i_d20Rolls[3] = %d;\n", monCnt, roll(20);
	printf "sm[%d].i_d20Rolls[4] = %d;\n", monCnt, roll(20);
	printf "sm[%d].i_d20Rolls[5] = %d;\n", monCnt, roll(20);
	printf "sm[%d].i_d20Rolls[6] = %d;\n", monCnt, roll(20);

#	printf "sm[%d].i_spellDC[0] = %d;\n", $
#	printf "sm[%d].i_spellDC[1] = %d;\n", $
#	printf "sm[%d].i_spellDC[2] = %d;\n", $
#	printf "sm[%d].i_spellDC[3] = %d;\n", $
#	printf "sm[%d].i_spellDC[4] = %d;\n", $
#	printf "sm[%d].i_spellDC[5] = %d;\n", $
#	printf "sm[%d].i_spellDC[6] = %d;\n", $
#	printf "sm[%d].i_spellDC[7] = %d;\n", $
#	printf "sm[%d].i_spellDC[8] = %d;\n", $
#	printf "sm[%d].i_spellFailure = %d;\n", $

	gsub(",", "", $41); split($41, statsep, " ");
	printf "sm[%d].i_abilityStats[0][0] = %d;\n", monCnt, statsep[2];
	printf "sm[%d].i_abilityStats[1][0] = %d;\n", monCnt, statsep[2];
	printf "sm[%d].i_abilityStats[0][1] = %d;\n", monCnt, statsep[4];
	printf "sm[%d].i_abilityStats[1][1] = %d;\n", monCnt, statsep[4];
	printf "sm[%d].i_abilityStats[0][2] = %d;\n", monCnt, statsep[6];
	printf "sm[%d].i_abilityStats[1][2] = %d;\n", monCnt, statsep[6];
	printf "sm[%d].i_abilityStats[0][3] = %d;\n", monCnt, statsep[8];
	printf "sm[%d].i_abilityStats[1][3] = %d;\n", monCnt, statsep[8];
	printf "sm[%d].i_abilityStats[0][4] = %d;\n", monCnt, statsep[10];
	printf "sm[%d].i_abilityStats[1][4] = %d;\n", monCnt, statsep[10];
	printf "sm[%d].i_abilityStats[0][5] = %d;\n", monCnt, statsep[12];
	printf "sm[%d].i_abilityStats[1][5] = %d;\n", monCnt, statsep[12];

	c = split($47, skills, ",");
	for (i=1; i<=c; i++) {
		split(skills[i], skillsep, " ");
		if (skillsep[1] == "Perception") { printf "sm[%d].i_skills[SKILL_SEARCH] = %d;\n", monCnt, skillsep[2]; }
		if (skillsep[1] == "Stealth") { printf "sm[%d].i_skills[SKILL_MOVESILENTLY] = %d;\n", monCnt, skillsep[2]; }
		if (skillsep[1] == "Concentration") { printf "sm[%d].i_skills[SKILL_CONCENTRATION] = %d;\n", monCnt, skillsep[2]; }
	}

	if (length($28) > 0) { printf "sm[%d].i_spellResistance = %d;\n", monCnt, $28; }
	if (length($25) > 0) {	# type/hp/weapon
		split($25, drsep, "/");
		if (isdigit(drsep[1]) == 1) {
			printf "sm[%d].i_damageReduction[0] = %d;\n", monCnt, drsep[1];
			c = split(drsep[2], drsep1, " ");
#"None", "Magic Weapon", "Any", "Adamantine", "Bludgeoning", "Chaotic", "Cold Iron", "Epic", "Evil", "Good", "Lawful", "Magic", "Silver", "Slashing"
			drt = 0;
			if (drsep1[1] == "adamantine" || drsep1[1] == "adamantine,") { drt = 3; }
			if (drsep1[1] == "bludgeoning") { drt = 4; }
			if (drsep1[1] == "chaotic") { drt = 5; }
			if (drsep1[1] == "cold" || drsep1[1] == "cold-iron,") { drt = 6; }
			if (drsep1[1] == "epic") { drt = 7; }
			if (drsep1[1] == "evil") { drt = 8; }
			if (drsep1[1] == "good" || drsep1[1] == "good,") { drt = 9; }
			if (drsep1[1] == "lawful") { drt = 10; }
			if (drsep1[1] == "magic") { drt = 11; }
			if (drsep1[1] == "silver") { drt = 12; }
			if (drsep1[1] == "slashing") { drt = 13; }
			printf "sm[%d].i_damageReduction[1] = %d;\n", monCnt, drt;
#			printf "sm[%d].i_damageReduction[2] = %d;\n", monCnt, $
		}
	}

	split($34, size, " ");
	if (length(size[1]) > 0) { printf "sm[%d].i_size = %d;\n", monCnt, size[1]; } else { printf "sm[%d].i_size = 3;\n", monCnt; }
	split($35, reach, " ");
	if (length(reach[1]) > 0) { printf "sm[%d].i_reach = %d;\n", monCnt, reach[1]; } else { printf "sm[%d].i_reach = 5;\n", monCnt; }

	printf "sm[%d].i_xp[MAX] = %d;\n", monCnt, $3;
	printf "sm[%d].i_inGroup = -1;\n", monCnt;
	gsub("[)(]", "", $17);
	printf "strcpy(sm[%d].c_hitDice, \"%s\");\n", monCnt, $17;

	printf "sm[%d].flags.f_isStabilised = 0;\n", monCnt;
	printf "sm[%d].flags.f_disabled = 0;\n", monCnt;
	printf "sm[%d].flags.f_ignoreCriticals = 0;\n", monCnt;
	printf "sm[%d].flags.f_autoStablise = 0;\n", monCnt;
	printf "sm[%d].flags.f_evasion = 0;\n", monCnt;
	printf "sm[%d].flags.f_srdMonster = 1;\n", monCnt;

#	printf "sm[%d].spellsAvailable.i_maxLevel0 = %d;\n", $
#	printf "sm[%d].spellsAvailable.i_maxLevel1 = %d;\n", $
#	printf "sm[%d].spellsAvailable.i_maxLevel2 = %d;\n", $
#	printf "sm[%d].spellsAvailable.i_maxLevel3 = %d;\n", $
#	printf "sm[%d].spellsAvailable.i_maxLevel4 = %d;\n", $
#	printf "sm[%d].spellsAvailable.i_maxLevel5 = %d;\n", $
#	printf "sm[%d].spellsAvailable.i_maxLevel6 = %d;\n", $
#	printf "sm[%d].spellsAvailable.i_maxLevel7 = %d;\n", $
#	printf "sm[%d].spellsAvailable.i_maxLevel8 = %d;\n", $
#	printf "sm[%d].spellsAvailable.i_maxLevel9 = %d;\n", $
#	printf "sm[%d].spellsAvailable.i_curLevel0 = %d;\n", $
#	printf "sm[%d].spellsAvailable.i_curLevel1 = %d;\n", $
#	printf "sm[%d].spellsAvailable.i_curLevel2 = %d;\n", $
#	printf "sm[%d].spellsAvailable.i_curLevel3 = %d;\n", $
#	printf "sm[%d].spellsAvailable.i_curLevel4 = %d;\n", $
#	printf "sm[%d].spellsAvailable.i_curLevel5 = %d;\n", $
#	printf "sm[%d].spellsAvailable.i_curLevel6 = %d;\n", $
#	printf "sm[%d].spellsAvailable.i_curLevel7 = %d;\n", $
#	printf "sm[%d].spellsAvailable.i_curLevel8 = %d;\n", $
#	printf "sm[%d].spellsAvailable.i_curLevel9 = %d;\n", $

	parseWeapons(-1, $32);

################# dump out all the notes for the monster as well
	printf "+%d|%d|", monCnt, monCnt >> "pfsrdmon.snt";
	if (length($24) > 0) { printf "Def.Abil: %s|", $24 >> "pfsrdmon.snt"; }
	if (length($25) > 0) { printf "DR: %s|", $25 >> "pfsrdmon.snt"; }
	if (length($26) > 0) { printf "Immune: %s|", $26 >> "pfsrdmon.snt"; }
	if (length($29) > 0) { printf "Weaknessess: %s|", $29 >> "pfsrdmon.snt"; }
	if (length($36) > 0) { printf "Sp. Attks: %s|", $36 >> "pfsrdmon.snt"; }
	if (length($37) > 0) { printf "%s|", $37 >> "pfsrdmon.snt"; }
	if (length($38) > 0) { printf "%s|", $38 >> "pfsrdmon.snt"; }
	if (length($39) > 0) { printf "%s|", $39 >> "pfsrdmon.snt"; }
	if (length($46) > 0) { printf "Feats: %s|", $46 >> "pfsrdmon.snt"; }
	if (length($47) > 0) { printf "Skills: %s|", $47 >> "pfsrdmon.snt"; }
	if (length($53) > 0) { printf "Treasure: %s|", $53 >> "pfsrdmon.snt"; }
	if (length($58) > 0) { printf "Sp. Abil: %s|", $58 >> "pfsrdmon.snt"; }
	printf "\n" >> "pfsrdmon.snt";

	monCnt++;
#	printf "i++;\n";
}

END {
	printf "i = %d;\n", monCnt;
}
