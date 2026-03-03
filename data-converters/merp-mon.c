// *******************************************************************************
// 	this will create the Srd monster from the creature file
/**********************************************************************
 *    Copyright Zen 2005+
 * #       This program is free software; you can redistribute it and/or
 * #       modify it under the terms of the GNU General Public License
 * #       as published by the Free Software Foundation; either version 2
 * #       of the License, or (at your option) any later version.
 * #
 * #       This program is distributed in the hope that it will be useful,
 * #       but WITHOUT ANY WARRANTY; without even the implied warranty of
 * #       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * #       GNU General Public License for more details.
 * #
 * #       You should have received a copy of the GNU General Public License
 * #       along with this program; if not, write to the Free Software
 * #       Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 * #
 * #
 * ###############################################################################
 
	g++ -Wno-write-strings -Wall -c pDBlibrary.cxx
	g++ merp-mon.c -o merp-mon pDBlibrary.o

 **********************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>

#include <fcntl.h>
#include <unistd.h>
#include <ctype.h>

#include "ADMPdata.h"
#include "pDBlibrary.h"

int writeAllPlayerData(char *);

FILE *inf, *nof;

ADMPplayer sm[MAX_QKMONSTERS+83];

// *******************************************************************************
int main(int argc, char **argv) {
	int i=0, j, k, w;
	int z,a,b;

	char ofn[] = "mrpdat/srdmonster";

	memset(&sm[0].c_name[0], '\0', sizeof(ADMPplayer)*(MAX_QKMONSTERS+83));

	if ((nof = fopen("mrpdat/srdmonster.snt", "w+")) == NULL) {
		printf("unable to open file ...\n");
		exit(0);
	}
	fprintf(nof, "=000382");


#include "merp-mon.h"

	writeAllPlayerData(ofn);

}

/********************************************************************************/
int pi_id=0, wi_id=0;

int writePlayerWeaponData() {
FILE *wfile;
ADMPweapon *wp;

	wfile = pdbFilePointer;
	if ((wp = (ADMPweapon *)pdbDataPointer) == NULL) { return -1; }

//	pdbPutInt(wfile, players[pid].i_id);
	pdbPutInt(wfile, pi_id);
	pdbPutInt(wfile, wi_id);
	pdbPutInt(wfile, wp->c_available);
	pdbPutString(wfile, &wp->c_description[0]);
	pdbPutInt(wfile, wp->i_attackBonus[0]);
	pdbPutInt(wfile, wp->i_attackBonus[1]);
	pdbPutInt(wfile, wp->i_attackBonus[2]);
	pdbPutInt(wfile, wp->i_attackBonus[3]);
	pdbPutString(wfile, wp->c_damage);
	pdbPutString(wfile, wp->c_critical);
	pdbPutInt(wfile, wp->i_magicalBonus);
	pdbPutInt(wfile, wp->i_range);
	pdbPutInt(wfile, wp->i_reach);
	pdbPutInt(wfile, wp->i_noAttacks);
	pdbPutString(wfile, wp->c_message);
	pdbPutInt(wfile, wp->c_attackType);
	pdbPutString(wfile, wp->c_table);
	pdbPutInt(wfile, wp->i_doneAttacks);
	pdbPutInt(wfile, wp->i_size);
	pdbPutInt(wfile, wp->i_type);
	pdbPutInt(wfile, wp->i_fumble);
	pdbPutInt(wfile, wp->i_critAdjust);

	return 0;
}

/********************************************************************************/
int writePlayerData() {
FILE *ofile;
ADMPplayer *pd;
int i;

	ofile = pdbFilePointer;
	if ((pd = (ADMPplayer *)pdbDataPointer) == NULL) { return -1; }

	pdbPutInt(ofile, pi_id);

	pdbPutString(ofile, pd->c_name);
	pdbPutInt(ofile, pd->i_race);
	pdbPutInt(ofile, pd->i_alignment);
	pdbPutInt(ofile, pd->i_classes[0]);
	pdbPutInt(ofile, pd->i_classes[1]);
	pdbPutInt(ofile, pd->i_classes[2]);
	pdbPutInt(ofile, pd->i_classes[3]);
	pdbPutInt(ofile, pd->i_levels[0]);
	pdbPutInt(ofile, pd->i_levels[1]);
	pdbPutInt(ofile, pd->i_levels[2]);
	pdbPutInt(ofile, pd->i_levels[3]);
	pdbPutInt(ofile, pd->i_hp[HP_MAX]);
	pdbPutInt(ofile, pd->i_hp[HP_CUR]);
	pdbPutInt(ofile, pd->i_hp[HP_NL]);
	pdbPutInt(ofile, pd->i_hp[HP_TMP]);
	pdbPutInt(ofile, pd->i_bleeding);
	pdbPutInt(ofile, pd->i_disabledAt);
	pdbPutInt(ofile, pd->i_unconciousAt);
	pdbPutInt(ofile, pd->i_savingThrows[SAVE_FORTITUDE]);
	pdbPutInt(ofile, pd->i_savingThrows[SAVE_REFLEX]);
	pdbPutInt(ofile, pd->i_savingThrows[SAVE_WISDOM]);
	pdbPutInt(ofile, pd->i_armorClass[AC_NORMAL]);
	pdbPutInt(ofile, pd->i_armorClass[AC_TOUCH]);
	pdbPutInt(ofile, pd->i_armorClass[AC_FLATFOOTED]);
	pdbPutInt(ofile, pd->i_armorClassSplit[AC_SECTION_DEX]);
	pdbPutInt(ofile, pd->i_armorClassSplit[AC_SECTION_SIZE]);
	pdbPutInt(ofile, pd->i_armorClassSplit[AC_SECTION_DEFLECTION]);
	pdbPutInt(ofile, pd->i_armorClassSplit[AC_SECTION_NATURAL]);
	pdbPutInt(ofile, pd->i_armorClassSplit[AC_SECTION_ARMOR]);
	pdbPutInt(ofile, pd->i_armorClassSplit[AC_SECTION_SHIELD]);
	pdbPutInt(ofile, pd->i_bab[BAB_MELEE][0]);
	pdbPutInt(ofile, pd->i_bab[BAB_RANGED][0]);
	pdbPutInt(ofile, pd->i_bab[BAB_GRAPPLE][0]);
	pdbPutInt(ofile, pd->i_bab[BAB_MELEE][1]);
	pdbPutInt(ofile, pd->i_bab[BAB_RANGED][1]);
	pdbPutInt(ofile, pd->i_bab[BAB_GRAPPLE][1]);
	pdbPutInt(ofile, pd->i_bab[BAB_MELEE][2]);
	pdbPutInt(ofile, pd->i_bab[BAB_RANGED][2]);
	pdbPutInt(ofile, pd->i_bab[BAB_GRAPPLE][2]);
	pdbPutInt(ofile, pd->i_initiative[0]);
	pdbPutInt(ofile, pd->i_initiative[1]);
	pdbPutInt(ofile, pd->i_speed);
	pdbPutInt(ofile, pd->i_inactive);
	pdbPutInt(ofile, pd->i_stun);
	pdbPutInt(ofile, pd->i_noAttacks);

	pdbPutFloat(ofile, pd->f_challengeRating);
	pdbPutInt(ofile, pd->i_d20Rolls[0]);
	pdbPutInt(ofile, pd->i_d20Rolls[1]);
	pdbPutInt(ofile, pd->i_d20Rolls[2]);
	pdbPutInt(ofile, pd->i_d20Rolls[3]);
	pdbPutInt(ofile, pd->i_d20Rolls[4]);
	pdbPutInt(ofile, pd->i_d20Rolls[5]);
	pdbPutInt(ofile, pd->i_d20Rolls[6]);
	pdbPutInt(ofile, pd->i_spellDC[0]);
	pdbPutInt(ofile, pd->i_spellDC[1]);
	pdbPutInt(ofile, pd->i_spellDC[2]);
	pdbPutInt(ofile, pd->i_spellDC[3]);
	pdbPutInt(ofile, pd->i_spellDC[4]);
	pdbPutInt(ofile, pd->i_spellDC[5]);
	pdbPutInt(ofile, pd->i_spellDC[6]);
	pdbPutInt(ofile, pd->i_spellFailure);
	pdbPutInt(ofile, pd->i_abilityStats[0][0]);
	pdbPutInt(ofile, pd->i_abilityStats[1][0]);
	pdbPutInt(ofile, pd->i_abilityStats[0][1]);
	pdbPutInt(ofile, pd->i_abilityStats[1][1]);
	pdbPutInt(ofile, pd->i_abilityStats[0][2]);
	pdbPutInt(ofile, pd->i_abilityStats[1][2]);
	pdbPutInt(ofile, pd->i_abilityStats[0][3]);
	pdbPutInt(ofile, pd->i_abilityStats[1][3]);
	pdbPutInt(ofile, pd->i_abilityStats[0][4]);
	pdbPutInt(ofile, pd->i_abilityStats[1][4]);
	pdbPutInt(ofile, pd->i_abilityStats[0][5]);
	pdbPutInt(ofile, pd->i_abilityStats[1][5]);
	pdbPutInt(ofile, pd->i_skills[SKILL_SEARCH]);
	pdbPutInt(ofile, pd->i_skills[SKILL_SOH]);
	pdbPutInt(ofile, pd->i_skills[SKILL_SPOT]);
	pdbPutInt(ofile, pd->i_skills[SKILL_OPENLOCKS]);
	pdbPutInt(ofile, pd->i_skills[SKILL_MOVESILENTLY]);
	pdbPutInt(ofile, pd->i_skills[SKILL_LISTEN]);
	pdbPutInt(ofile, pd->i_skills[SKILL_HIDE]);
	pdbPutInt(ofile, pd->i_skills[SKILL_CONCENTRATION]);
	pdbPutInt(ofile, pd->i_spellResistance);
	pdbPutInt(ofile, pd->i_damageReduction[0]);
	pdbPutInt(ofile, pd->i_damageReduction[1]);
	pdbPutInt(ofile, pd->i_damageReduction[2]);
	pdbPutInt(ofile, pd->i_size);
	pdbPutInt(ofile, pd->i_xp[MAX]);
	pdbPutInt(ofile, pd->i_xp[TMP]);
	pdbPutInt(ofile, pd->i_inGroup);
	pdbPutString(ofile, pd->c_hitDice);
	pdbPutInt(ofile, pd->flags.f_isStabilised);
	pdbPutInt(ofile, pd->flags.f_disabled);
	pdbPutInt(ofile, pd->flags.f_ignoreCriticals);
	pdbPutInt(ofile, pd->flags.f_autoStablise);
	pdbPutInt(ofile, pd->flags.f_evasion);

	pdbPutInt(ofile, pd->spellsAvailable.i_maxLevel0);
	pdbPutInt(ofile, pd->spellsAvailable.i_maxLevel1);
	pdbPutInt(ofile, pd->spellsAvailable.i_maxLevel2);
	pdbPutInt(ofile, pd->spellsAvailable.i_maxLevel3);
	pdbPutInt(ofile, pd->spellsAvailable.i_maxLevel4);
	pdbPutInt(ofile, pd->spellsAvailable.i_maxLevel5);
	pdbPutInt(ofile, pd->spellsAvailable.i_maxLevel6);
	pdbPutInt(ofile, pd->spellsAvailable.i_maxLevel7);
	pdbPutInt(ofile, pd->spellsAvailable.i_maxLevel8);
	pdbPutInt(ofile, pd->spellsAvailable.i_maxLevel9);
	pdbPutInt(ofile, pd->spellsAvailable.i_curLevel0);
	pdbPutInt(ofile, pd->spellsAvailable.i_curLevel1);
	pdbPutInt(ofile, pd->spellsAvailable.i_curLevel2);
	pdbPutInt(ofile, pd->spellsAvailable.i_curLevel3);
	pdbPutInt(ofile, pd->spellsAvailable.i_curLevel4);
	pdbPutInt(ofile, pd->spellsAvailable.i_curLevel5);
	pdbPutInt(ofile, pd->spellsAvailable.i_curLevel6);
	pdbPutInt(ofile, pd->spellsAvailable.i_curLevel7);
	pdbPutInt(ofile, pd->spellsAvailable.i_curLevel8);
	pdbPutInt(ofile, pd->spellsAvailable.i_curLevel9);

	pdbPutInt(ofile, pd->i_playerID);
	pdbPutInt(ofile, pd->i_stdMonsterID);
	pdbPutInt(ofile, pd->flags.f_npc);
	pdbPutInt(ofile, pd->i_regeneration);
	pdbPutString(ofile, pd->c_iconFile);
	pdbPutInt(ofile, pd->i_inGroup);
	pdbPutInt(ofile, pd->i_mapX);
	pdbPutInt(ofile, pd->i_mapY);
	pdbPutInt(ofile, pd->i_reach);
	pdbPutInt(ofile, pd->i_space);
	pdbPutInt(ofile, pd->flags.f_invisible);

	pdbPutInt(ofile, pd->i_resistances[RESIST_FIRE]);
	pdbPutInt(ofile, pd->i_resistancesUsed[RESIST_FIRE]);
	pdbPutInt(ofile, pd->i_resistances[RESIST_ACID]);
	pdbPutInt(ofile, pd->i_resistancesUsed[RESIST_ACID]);
	pdbPutInt(ofile, pd->i_resistances[RESIST_COLD]);
	pdbPutInt(ofile, pd->i_resistancesUsed[RESIST_COLD]);
	pdbPutInt(ofile, pd->i_resistances[RESIST_ELEC]);
	pdbPutInt(ofile, pd->i_resistancesUsed[RESIST_ELEC]);
	pdbPutInt(ofile, pd->i_resistances[RESIST_SONIC]);
	pdbPutInt(ofile, pd->i_resistancesUsed[RESIST_SONIC]);

	pdbPutString(ofile, pd->c_items);
	pdbPutInt(ofile, pd->i_negateCrit);
	pdbPutInt(ofile, pd->i_armorClassSplit[AC_SECTION_DODGE]);
	pdbPutInt(ofile, pd->i_useShieldOn);
	pdbPutInt(ofile, pd->i_useDodgeOn);
	pdbPutInt(ofile, pd->flags.f_wasViewed);
	pdbPutInt(ofile, pd->i_spellDC[7]);
	pdbPutInt(ofile, pd->i_spellDC[8]);
	pdbPutInt(ofile, pd->i_hp[HP_ENH]);
	pdbPutInt(ofile, pd->i_doneAttacks);

	pdbPutInt(ofile, pd->i_savingThrows[SAVE_MENTAL]);
	pdbPutInt(ofile, pd->i_savingThrows[SAVE_DISEASE]);

	pdbPutInt(ofile, pd->i_penalty[0]);
	pdbPutInt(ofile, pd->i_penalty[1]);
	pdbPutInt(ofile, pd->i_penalty[2]);
	pdbPutInt(ofile, pd->i_penalty[3]);
	pdbPutInt(ofile, pd->i_penalty[4]);

	pdbPutInt(ofile, pd->i_roundsUntil[0]);
	pdbPutInt(ofile, pd->i_roundsUntil[1]);
	pdbPutInt(ofile, pd->i_roundsUntil[2]);
	pdbPutInt(ofile, pd->i_roundsUntil[3]);
	pdbPutInt(ofile, pd->i_roundsUntil[4]);

	pdbPutInt(ofile, pd->i_armorClass[AC_NOPARRY]);

	for (i=0; i<MAX_D100XP; i++) { pdbPutInt(ofile, pd->c_d100XP[i]); }

	pdbPutInt(ofile, pd->i_armorClass[AC_NOPARRY]);
	pdbPutInt(ofile, pd->i_savingThrows[SAVE_POISON]);
	pdbPutInt(ofile, pd->i_savingThrows[SAVE_DISEASE]);
	pdbPutInt(ofile, pd->i_roundsUntil[ROUND_DEATH]);
	pdbPutInt(ofile, pd->i_roundsUntil[ROUND_SPELL_CHG]);
	pdbPutInt(ofile, pd->i_roundsUntil[ROUND_MISSILE_CHG]);
	pdbPutInt(ofile, pd->i_baseSpell);
	pdbPutInt(ofile, pd->i_directedSpells);

	pdbPutInt(ofile, pd->flags.f_ignoreBleed);
	pdbPutInt(ofile, pd->flags.f_ignoreStun);
	pdbPutInt(ofile, pd->i_noInGroup);

	return 0;
}
/********************************************************************************/
int writeAllPlayerData(char *fx) {
int i, w=0, j=0, k=0, l=0;
char of[256], wf[256];

	sprintf(of, "%s.std", fx);
	sprintf(wf, "%s.swp", fx);

	pdbClearFile(of);
	pdbClearFile(wf);

	pi_id = i = 0;
	for (i=0; i<MAX_QKMONSTERS+83; i++) {
//		l = i;
		if (sm[i].c_name[0] != '\0') { // && sm[i].i_hp[HP_MAX] > 0) {
			pi_id = i;
			pdbAddRecord(of, writePlayerData, (void *)sm[i].c_name);
			for (w=0; w<MAX_WEAPONS; w++) {
				if (sm[i].w_weapons[w].c_description[0] != '\0') { 
					wi_id = w;
					pdbAddRecord(wf, writePlayerWeaponData, (void *)&sm[i].w_weapons[w]);
				}
			}
		}
	}
	return 0;
}
