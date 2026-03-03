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
 **********************************************************************/

/******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <ctype.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <errno.h>

#ifndef VISUALC
#include <dirent.h>
#include <unistd.h>
#else
#include <windows.h>
#include <direct.h>
#include <stdlib.h>
#define strncasecmp strnicmp
#endif

#include "pDBlibrary.h"
#include "gridMap.h"
#include "ADMPmerp.h"

/******************************************************************************/
#include <FL/Fl.H>
#include <FL/Fl_Input.H>
#include <FL/Fl_Output.H>
#include <FL/Fl_Choice.H>
#include <FL/Fl_Check_Button.H>
#include <FL/Fl_Browser.H>
#include <FL/Fl_Select_Browser.H>
#include <FL/Fl_Button.H>
#include <FL/Fl_Round_Button.H>
#include <FL/Fl_Check_Button.H>
#include <FL/Fl_Check_Browser.H>
#include <FL/Fl_Tabs.H>
#include <FL/Fl_Tile.H>
#include <FL/Fl_Window.H>
#include <FL/Fl_Scroll.H>
#include <FL/Fl_Counter.H>
#include <FL/Fl_Value_Slider.H>
#include <FL/Fl_File_Chooser.H>
#include <FL/Fl_Menu_Button.H>
#include <FL/Fl_Double_Window.H>
#include <FL/Fl_File_Chooser.H>
#include <FL/Fl_Help_View.H>
#include <FL/Fl_Text_Editor.H>
#include <FL/Fl_Text_Buffer.H>
#include <FL/Fl_PNG_Image.H>
#include <FL/Fl_JPEG_Image.H>
#include <FL/fl_show_colormap.H>
#include <FL/Fl_Progress.H>

#include "ADMPdata.h"
#include "ADMPexternals.h"

#include <dirent.h>
extern int scandir();
extern int alphasort();

/****************************************************************************/
#ifdef WINDOWS
//#ifdef VISUALC
//#define S_IRUSR 00400
//#define S_IWUSR 00200
//#endif
//#define S_IRGRP 00040
//#define S_IROTH 00004
extern void fchmod();
#endif

/****************************************************************************/
char d100TableId[MAX_D100TABLES][4], *d100TableMem[MAX_D100TABLES];
		// these start at 1 and go up
char d100ActionModifiers[5][8] = {{0,10,-10,20,0,0,0,0}, {0,-1,20,-1,20,-10,-20,0}, {0,0,0,0,0,0,0,0}, {0,0,0,0,0,0,0,0}, {0,10,-10,20,0,0,0,0}};
char d100ActionModifiersFlags[5][8] = {{0,0,0,0,0,0,0,0}, {0,0,0,0,0,0,0,0}, {0,0,0,0,0,0,0,0}, {0,0,0,0,0,0,0,0}, {0,0,0,0,0,0,0,0}};

char armorType[3][8] = {{"None"}, {"Leather"}, {"Metal"}};

char *d100AttkTbl=NULL, *d100CritTbl=NULL;

ADMPweapon d100WeaponUsed;

Fl_Browser* d1_DefenderList[5];
Fl_Browser* d1_CombatWeaponUsed[4];
Fl_Browser* d1_CombatWeaponDetails[4];
Fl_Input* d1_CombatParry[4][2];
Fl_Button* d1_CombatSpecAttk[4];
Fl_Input* d1_CombatAttkRoll[5];
Fl_Input* d1_CombatAdj[5];
Fl_Input* d1_CombatOB[5];
Fl_Button* d1_CombatCalc[5][3];
Fl_Input* d1_CombatCritRoll[4][2];
Fl_Choice* d1_CombatCrit[4][2];
Fl_Input* d1_CombatResults[5][8];
Fl_Button* d1_CombatAcceptThis[5];
Fl_Button* d1_CombatAcceptAll[5];
Fl_Check_Browser* d1_CombatModifiers[5];
Fl_Input* d1_CombatMods[5][4];
Fl_Input* d1_CombatAttkTable[4];
Fl_Input* d1_CombatCritTable[4][2];
Fl_Button* d1_CombatD100Roll[5];

/****************************************************************************/
extern int seed1, seed2, seed3;

extern ADMPsystem config;
extern ADMPplayer  players[MAX_MEMBERS+4], qkmonsters[MAX_QKMONSTERS+2];
extern ADMPweapon stdweapons[MAX_STDWEAPONS+2];

extern char mybuf1[2348], mybuf2[2348];

extern float ADMPversion;

extern FILE *logfile, *openf;

/******************************************************************************/
extern Fl_Menu_Item races[];
extern Fl_Menu_Item classes[];
extern Fl_Menu_Item realm[];
extern Fl_Double_Window *a_WeaponWindow, *a_Exit;
extern gridMap *combatGridMap, *externalGridMap;
extern Fl_Input  *quickmodsData[MAX_QUICKMODIFIERS][MAX_QUICKMODTYPES];

/******************************************************************************/
extern int doAreYouSure(char *);
extern void doSystemAlert(char *);
extern int getHPpercentage(int );
extern int getHPs(int );
extern int getAdjustment(int, int);
extern int getRND(int);
extern void setCombatDisplay(int );
extern void reloadNames(int );
extern void writeLog(char *);

void doD100LoadAllTables(char *);
void getD100CriticalRoll(char *, int , char);
void getD100AttackRoll(char *, int , int );
char *getD100Table(char *);
int getD100DiceRoll();
void doD100IgnoreAdjustment(int );
void doD100SelectDefender(int , int );
void doD100SelectWeapon(int , int );
void doD100SetDefenderListName(int );
void doD100FumbleResult(int , int , int );
void doD100WeaponParse(int, char *);
void doD100ActionModifiers(int, int);
int getD100ResistanceRoll(int, int);
int getStatBonus(int );

/******************************************************************************/
void d100Setup() {

	a_IActions->type(2);
	quickmodsData[0][0]->label("OB"); quickmodsData[0][0]->tooltip("Attack Bonus");
	quickmodsData[0][2]->label(" DB"); quickmodsData[0][2]->tooltip("Defensive Bonus");
	quickmodsData[0][4]->label("RR"); quickmodsData[0][4]->tooltip("All Saves");
	quickmodsData[22][0]->label("OB"); quickmodsData[22][0]->tooltip("Attack Bonus");
	quickmodsData[22][2]->label(" DB"); quickmodsData[22][2]->tooltip("Defensive Bonus");
	quickmodsData[22][4]->label("RR"); quickmodsData[22][4]->tooltip("All Saves");
	
	aEdit_ACNormal->label("DB: Norm");
	aEdit_ACNormal->tooltip("AG Bonus + Magic");
	aEdit_ACTouch->label("Shield");
	aEdit_ACFlatFoot->label("Parry");
	aEdit_ACNoParry->activate();
	aEdit_ACSecDex->deactivate();
	aEdit_ACSecSize->deactivate();
	aEdit_ACSecDeflection->deactivate();
	aEdit_ACSecNatural->deactivate();
	aEdit_ACSecArmor->deactivate();
	aEdit_ACSecShield->deactivate();
	aEdit_ACSecDodge->deactivate();
	aEdit_HitDice->deactivate();
	aEdit_NegateCritical->deactivate();
	aEdit_EnhHP->deactivate();
	aEdit_BABMelee1->deactivate();
	aEdit_BABMelee2->deactivate();
	aEdit_BABMelee3->deactivate();
	aEdit_BABRanged1->deactivate();
	aEdit_BABRanged2->deactivate();
	aEdit_BABRanged3->deactivate();
	aEdit_BABGrapple1->deactivate();
	aEdit_BABGrapple2->deactivate();
	aEdit_BABGrapple3->deactivate();
	aEdit_BaseSpells->activate();
	aEdit_DirectedSpells->activate();
	aEdit_Size->color(3); aEdit_Size->tooltip("Used to adjust TC.GR attacks");
	aEdit_WeaponSize->color(3); aEdit_WeaponSize->tooltip("Used to adjust TC.GR attacks");
	aQkAdd_WeaponSize->color(3); aQkAdd_WeaponSize->tooltip("Used to adjust TC.GR attacks");
	
	aEdit_SaveFort->label("RR: Ess");
	aEdit_SaveReflex->label("Cha");
	aEdit_SaveWill->label("Ment");
	aEdit_SavePoison->activate();
	aEdit_SaveDisease->activate();
	aEdit_RoundsSpellChg->activate();
	aEdit_RoundsMissileChg->activate();
	aEdit_RoundsDeathIn->activate();
	aEdit_InitBonus->label("M&&M Bonus");
	
	aEdit_ArmorWorn->activate(); aEdit_ArmorWorn->show();
	aEdit_ArmorLegWorn->activate(); aEdit_ArmorLegWorn->show();
	aEdit_ArmorArmWorn->activate(); aEdit_ArmorArmWorn->show();
	aEdit_ArmorHelmWorn->activate(); aEdit_ArmorHelmWorn->show();
	aEdit_ArmorWorn->resize(307, 272, 60, 25);
	aEdit_ArmorLegWorn->resize(400, 272, 60, 25);
	aEdit_ArmorArmWorn->resize(490, 272, 60, 25);
	aEdit_ArmorHelmWorn->resize(590, 272, 60, 25);
	
	aEdit_SkillSearch->label("Skills: Perc"); aEdit_SkillSearch->tooltip("Perception");
	aEdit_SkillSOH->label("Stalk");	aEdit_SkillSOH->tooltip("Stalk Hide");
	aEdit_SkillSpot->label("Rune");	aEdit_SkillSpot->tooltip("Read Runes");
	aEdit_SkillOLocks->label("U.Item");	aEdit_SkillOLocks->tooltip("Use Items");
	aEdit_SkillMoveSilently->label(""); aEdit_SkillMoveSilently->deactivate();
	aEdit_SkillConcentration->label(""); aEdit_SkillConcentration->deactivate();
	aEdit_SkillListen->label(""); aEdit_SkillListen->deactivate();
	aEdit_SkillHide->label(""); aEdit_SkillHide->deactivate();
//	aEdit_SkillSpot->resize(457,309,25,25);
	
	aEdit_d201->label("d100 Rolls");
	aEdit_SpellFailure->deactivate();
	aEdit_SpellResistance->deactivate();
	aEdit_DamReductionHP->deactivate();
	aEdit_DamReductionWeapon->deactivate();
	aEdit_DamReductionType->deactivate();
	aEdit_CRating->deactivate();
	aEdit_SpellDC0->deactivate();
	aEdit_SpellDC1->deactivate();
	aEdit_SpellDC2->deactivate();
	aEdit_SpellDC3->deactivate();
	aEdit_SpellDC4->deactivate();
	aEdit_SpellDC5->deactivate();
	aEdit_SpellDC6->deactivate();
	aEdit_SpellDC7->deactivate();
	aEdit_SpellDC8->deactivate();
	
	aEdit_SpellSlotMax0->deactivate();
	aEdit_SpellSlotCur0->deactivate();
	aEdit_SpellSlotMax1->deactivate();
	aEdit_SpellSlotCur1->deactivate();
	aEdit_SpellSlotMax2->deactivate();
	aEdit_SpellSlotCur2->deactivate();
	aEdit_SpellSlotMax3->deactivate();
	aEdit_SpellSlotCur3->deactivate();
	aEdit_SpellSlotMax4->deactivate();
	aEdit_SpellSlotCur4->deactivate();
	aEdit_SpellSlotMax5->deactivate();
	aEdit_SpellSlotCur5->deactivate();
	aEdit_SpellSlotMax6->deactivate();
	aEdit_SpellSlotCur6->deactivate();
	aEdit_SpellSlotMax7->deactivate();
	aEdit_SpellSlotCur7->deactivate();
	aEdit_SpellSlotMax8->deactivate();
	aEdit_SpellSlotCur8->deactivate();
	aEdit_SpellSlotMax9->deactivate();
	aEdit_SpellSlotCur9->deactivate();
	
	aEdit_WeaponAttkBonus1->label("OB");
	aEdit_WeaponAttkBonus2->deactivate();
	aEdit_WeaponAttkBonus3->deactivate();
	aEdit_WeaponAttkBonus4->deactivate();
	aEdit_WeaponDamage->label("Prim Crit"); aEdit_WeaponDamage->resize(503, 218, 40, 25);
	aEdit_WeaponCritical->label("2nd Crit"); aEdit_WeaponCritical->resize(503, 245, 40, 25);
	aEdit_WeaponFumble->activate();
	aEdit_WeaponCritAdjustment->activate();
	aEdit_WeaponSize->activate();
	aEdit_WeaponAttackTable->activate();
	
	//memset(&qkmonsters[0].c_name[0], '\0', sizeof(ADMPplayer)*MAX_QKMONSTERS+2);
	//memset(&stdweapons[0].c_available, '\0', sizeof(ADMPweapon) * MAX_STDWEAPONS);
	memset(config.system_mods[0].c_message, '\0', sizeof(ADMPmodifiers) * MAX_MODIFIERS);
	
	d1_SpellSearchFound->type(2);
	
		// TODO
	d1_CombatModifiers[0]->clear(); d1_CombatModifiers[1]->clear();
	d1_CombatModifiers[2]->clear(); d1_CombatModifiers[3]->clear();
	
	d1_CombatModifiers[0]->add("+15 Flank Attack");
	d1_CombatModifiers[0]->add("+35 Rear Attack");
	d1_CombatModifiers[0]->add("+20 Defender Surprised");
	d1_CombatModifiers[0]->add("+20 Defender Stunned/Down");
	d1_CombatModifiers[0]->add("-10 for each 10' moved");
	d1_CombatModifiers[0]->add("-20 Attacker at 50% health or less");
	d1_CombatModifiers[0]->add("-30 Changing/drawing a weapon");
	
		// Missile
	d1_CombatModifiers[2]->add("-10 for each 10' moved");
	d1_CombatModifiers[2]->add("-20 Attacker at 50% health or less");
	d1_CombatModifiers[2]->add("-30 Changing/drawing a weapon");
	
	aEdit_ACSecDex->hide();
	aEdit_ACSecSize->hide();
	aEdit_ACSecDeflection->hide();
	aEdit_ACSecNatural->hide();
	aEdit_ACSecArmor->hide();
	aEdit_ACSecShield->hide();
	aEdit_ACSecDodge->hide();
	aEdit_HitDice->hide();
	aEdit_NegateCritical->hide();
	aEdit_EnhHP->hide();
	aEdit_BABMelee1->hide();
	aEdit_BABMelee2->hide();
	aEdit_BABMelee3->hide();
	aEdit_BABRanged1->hide();
	aEdit_BABRanged2->hide();
	aEdit_BABRanged3->hide();
	aEdit_BABGrapple1->hide();
	aEdit_BABGrapple2->hide();
	aEdit_BABGrapple3->hide();
	aEdit_SkillMoveSilently->hide();
	aEdit_SkillConcentration->hide();
	aEdit_SkillListen->hide();
	aEdit_SkillHide->hide();
	aEdit_SpellFailure->hide();
	aEdit_SpellResistance->hide();
	aEdit_DamReductionHP->hide();
	aEdit_DamReductionWeapon->hide();
	aEdit_DamReductionType->hide();
	aEdit_CRating->hide();
	aEdit_SpellDC0->hide();
	aEdit_SpellDC1->hide();
	aEdit_SpellDC2->hide();
	aEdit_SpellDC3->hide();
	aEdit_SpellDC4->hide();
	aEdit_SpellDC5->hide();
	aEdit_SpellDC6->hide();
	aEdit_SpellDC7->hide();
	aEdit_SpellDC8->hide();
	aEdit_SpellSlotMax0->hide();
	aEdit_SpellSlotCur0->hide();
	aEdit_SpellSlotMax1->hide();
	aEdit_SpellSlotCur1->hide();
	aEdit_SpellSlotMax2->hide();
	aEdit_SpellSlotCur2->hide();
	aEdit_SpellSlotMax3->hide();
	aEdit_SpellSlotCur3->hide();
	aEdit_SpellSlotMax4->hide();
	aEdit_SpellSlotCur4->hide();
	aEdit_SpellSlotMax5->hide();
	aEdit_SpellSlotCur5->hide();
	aEdit_SpellSlotMax6->hide();
	aEdit_SpellSlotCur6->hide();
	aEdit_SpellSlotMax7->hide();
	aEdit_SpellSlotCur7->hide();
	aEdit_SpellSlotMax8->hide();
	aEdit_SpellSlotCur8->hide();
	aEdit_SpellSlotMax9->hide();
	aEdit_SpellSlotCur9->hide();
	aEdit_WeaponAttkBonus2->hide();
	aEdit_WeaponAttkBonus3->hide();
	aEdit_WeaponAttkBonus4->hide();
	aEdit_Class2->hide();
	aEdit_Level2->hide();
	aEdit_Class3->label("Realm");
	aEdit_Class3->menu(realm);
	aEdit_Level3->hide();
	aEdit_Class4->hide();
	aEdit_Level4->hide();
	
	
	a_SRDText->deactivate();
	a_SRDIndex->deactivate();
	a_SRDPreviousPage->deactivate();
	
	// aMisc_XPCalc->deactivate();
	a_OXPPartyLevel->deactivate();
	a_OXPCalcIncAll->deactivate();
	a_OXPValue->label("XP Mult");
	a_OXPValue->value("1.0");
	
	ant_Grp3->deactivate();
	ant_NPC->deactivate();
	a_SpellListGroup->deactivate();
	a_OTDiceRoller->label("Dice Roller");
	
	aQkAdd_InitBonus->label("M&&M Bonus");
	aQkAdd_WeaponFumble->activate();
	aQkAdd_WeaponCritAdjustment->activate();
	aQkAdd_WeaponAttackTable->activate();
	aQkAdd_WeaponDamage->label("Prim Crit"); aQkAdd_WeaponDamage->resize(325, 268, 40, 25);
	aQkAdd_WeaponCritical->label("2nd Crit"); aQkAdd_WeaponCritical->resize(325, 295, 40, 25);
	aQkAdd_ACNormal->label("DB: Norm");
	aQkAdd_ACTouch->label("Shield");
	aQkAdd_ACFlatFoot->label("Parry");
	aQkAdd_SaveFort->label("RR: Ess");
	aQkAdd_SaveReflex->label("Cha");
	aQkAdd_SaveWill->label("Ment");
	aQkAdd_SpellResistance->hide();
	aQkAdd_DamReductionHP->hide();
	aQkAdd_DamReductionWeapon->hide();
	aQkAdd_DamReductionType->hide();
	aQkAdd_SaveDisease->activate();
	aQkAdd_SavePoison->activate();
	
	qkEdit_DBNormal->label("DB: Norm");
	qkEdit_DBNormal->tooltip("AG Bonus + magic");
	qkEdit_ACTouch->label("Shield");
	qkEdit_ACFlatFoot->label("Parry");
	qkEdit_SaveFort->label("RR: Ess");
	qkEdit_SaveReflex->label("Cha");
	qkEdit_SaveWill->label("Ment");
	qkEdit_SavePoison->activate();
	qkEdit_SaveDisease->activate();
	qkEdit_W1AB1->label("OB");
	qkEdit_W1AB2->hide();
	qkEdit_W1AB3->hide();
	qkEdit_W1AB4->hide();
	qkEdit_W1Damage->label("Prim Crit"); qkEdit_W1Damage->resize(274, 157, 40, 25);
	qkEdit_W1Critical->label("2nd Crit"); qkEdit_W1Critical->resize(369, 157, 40, 25);
	
	qkEdit_W2AB1->label("OB");
	qkEdit_W2AB2->hide();
	qkEdit_W2AB3->hide();
	qkEdit_W2AB4->hide();
	qkEdit_W2Damage->label("Prim Crit"); qkEdit_W2Damage->resize(274, 215, 40, 25);
	qkEdit_W2Critical->label("2nd Crit"); qkEdit_W2Critical->resize(369, 215, 40, 25);
	
	aEL_CalculatorGroup->deactivate();
	a_EdtQkMonCREnvironment->deactivate();
	
	aMSC_flags->clear();
	aMSC_flags->add(" ");
	aMSC_flags->add("Roll a d100");
	aMSC_flags->add("Use prerolled d100");
	aMSC_SkillList->clear();
	aMSC_SkillList->add("Perception");
	aMSC_SkillList->add("Stalk/Hide");
	aMSC_SkillList->add("Read Runes");
	aMSC_SkillList->add("Use Item");
	aMSC_DCValue->hide();
	aMSC_DCValue->deactivate();
	aMSC_SkillDifficulty->activate();
	aMSC_SkillDifficulty->position(353,231);
	
	aEdit_StatsSTR0->label("Bonus: ST:");
	aEdit_StatsDEX0->label("AG:");
	aEdit_StatsDEX0->color(2);
	aEdit_StatsCON0->label("CO:");
	aEdit_StatsINT0->label("IG:");
	aEdit_StatsWIS0->label("IT:");
	aEdit_StatsCHA0->label("PR:");
	aEdit_StatsSTR0->tooltip("The Bonuses for each Stat");
	aEdit_StatsDEX0->tooltip("The Bonuses for each Stat");
	aEdit_StatsCON0->tooltip("The Bonuses for each Stat");
	aEdit_StatsINT0->tooltip("The Bonuses for each Stat");
	aEdit_StatsSTR1->hide();
	aEdit_StatsDEX1->hide();
	aEdit_StatsCON1->hide();
	aEdit_StatsINT1->hide();
	aEdit_StatsWIS1->hide();
	aEdit_StatsCHA1->hide();
	
	aEdit_SpellResistanceFire1->hide();
	aEdit_SpellResistanceFire2->hide();
	aEdit_SpellResistanceAcid1->hide();
	aEdit_SpellResistanceAcid2->hide();
	aEdit_SpellResistanceCold1->hide();
	aEdit_SpellResistanceCold2->hide();
	aEdit_SpellResistanceElec1->hide();
	aEdit_SpellResistanceElec2->hide();
	aEdit_SpellResistanceSonic1->hide();
	aEdit_SpellResistanceSonic2->hide();

		// todo - need to factor this into stuff = i_critAdjust
	aEdit_WeaponCritAdjustment->deactivate();
	aQkAdd_WeaponCritAdjustment->deactivate();

	t_QkSpelllists->deactivate();

	//for (int i=0; i < 7; i++) { printf("%d\n", getD100ResistanceRoll(getRND(16), getRND(16))); }
}

/******************************************************************************/
void setupPathfinder() {
aEdit_BABGrapple1->label("CMB:");
aEdit_BABGrapple1->tooltip("Combat Man. Bonus");
aEdit_BABGrapple3->label("CMD:");
aEdit_BABGrapple3->tooltip("Combat Man. Defence");
aEdit_BABGrapple2->deactivate();
aEdit_BABGrapple2->hide();
a_CTSpecialAttacks->add("Combat Maneuver");

	// skills have changed
aEdit_SkillSearch->label("Skills: Perc");

aEdit_SkillSOH->deactivate(); aEdit_SkillSOH->hide();
aEdit_SkillSpot->deactivate(); aEdit_SkillSpot->hide();
aEdit_SkillOLocks->deactivate(); aEdit_SkillOLocks->hide();

aEdit_SkillMoveSilently->resize(410,309, 25, 25);
aEdit_SkillMoveSilently->label("Stealth");

aEdit_SkillConcentration->resize(530, 309, 25, 25);

aEdit_SkillListen->deactivate(); aEdit_SkillListen->hide();
aEdit_SkillHide->deactivate(); aEdit_SkillHide->hide();

aMSC_SkillList->clear();
aMSC_SkillList->add("Perception");
aMSC_SkillList->add("Stealth");
aMSC_SkillList->add("Concentration");
}

/******************************************************************************/
void doDiceSystem(int type) {

//printf("dDS: %d\n", type);

	if (config.i_diceSystem == type) return;

	if (type == -2) {
		for (int i=0; i<MAX_D100TABLES; i++) {
			d100TableMem[i] = NULL;
			d100TableId[i][0] = '\0';
		}
		return;
	}

	if (config.i_diceSystem >= 0 && config.i_diceSystem != type) {
		if (doAreYouSure("Do you really want to do this ?\nIf so, then 'Save All' and restart the program") == -1) { return; }
	}

	config.i_diceSystem = type;

	switch (type) {
		case 0:		// d20
					aSys_initSystem->deactivate();
					aSys_initSystem->value(0);
					break;

		case 1:		// d100 MERP
					doD100LoadAllTables("./mrpdat/");
					aSys_initSystem->activate();
					d100Setup();
					break;

		case 2:		// d100 RMS
					doD100LoadAllTables("./rmsdat/");
					aSys_initSystem->activate();
					d100Setup();
					break;

		case 3:		// d20 v5
					aSys_initSystem->deactivate();
					aSys_initSystem->value(0);
//					a_CTSpecialAttacks->add("Advantage");
//					a_CTSpecialAttacks->add("Disadvantage");
					break;

		case 4:		// pathfinder
					setupPathfinder();
					break;

		case 20:
		case 21:
		case 22:		// Init system picked
					config.i_initSystem = aSys_initSystem->value();
					break;
	}
}

/******************************************************************************/
void doD100WindowSetup(int action) {
int i=0, j=0;
weapon_tab *wtbl;

//printf("dDWS: %d:%d\n", action, config.i_diceSystem);

	switch (action) {
		case 0:		// initial setup, before window is displayed
					d1_ActionType->clear();
					d1_ActionType->add("Melee Attack"); d1_ActionType->add("Spell Attack");
					d1_ActionType->add("Missile Attack"); d1_ActionType->add("Heal"); d1_ActionType->add("M & M");
					d1_ActionType->activate();

					d1_CombatModifiers[0]->check_none(); d1_CombatModifiers[1]->check_none();
					d1_CombatModifiers[2]->check_none(); d1_CombatModifiers[3]->check_none();

					sprintf(mybuf2, "%d", (players[config.i_actionInitID].i_noAttacks - players[config.i_actionInitID].i_doneAttacks)); d1_CombatAttacksLeft->value(mybuf2);

					d1_ActionTab->deactivate();
					d1_ActionMeleeTab->deactivate();
					d1_ActionSpellTab->deactivate();
					d1_ActionMissileTab->deactivate();
					d1_ActionMoveTab->deactivate();
					d1_ActionHealTab->deactivate();
					d1_ActionMessages->clear();
					d1_ActionMessages->add(""); d1_ActionMessages->add(""); d1_ActionMessages->add(""); d1_ActionMessages->add("");
					d1_ActionMessages->add(""); d1_ActionMessages->add(""); d1_ActionMessages->add(""); d1_ActionMessages->add("");
					d1_ActionMessages->add(""); d1_ActionMessages->add(""); d1_ActionMessages->add("");
					if (config.i_diceSystem == DICE_MERP) {	// MERP
						d1_CombatDefenderArmor->clear();
						d1_CombatDefenderArmor->add("None"); d1_CombatDefenderArmor->add("Soft Leather"); d1_CombatDefenderArmor->add("Rigid Leather");
						d1_CombatDefenderArmor->add("Chain"); d1_CombatDefenderArmor->add("Plate");
						d1_SpellDefenderArmor->clear();
						d1_SpellDefenderArmor->add("None"); d1_SpellDefenderArmor->add("Soft Leather"); d1_SpellDefenderArmor->add("Rigid Leather");
						d1_SpellDefenderArmor->add("Chain"); d1_SpellDefenderArmor->add("Plate");
						d1_MissileDefenderArmor->clear();
						d1_MissileDefenderArmor->add("None"); d1_MissileDefenderArmor->add("Soft Leather"); d1_MissileDefenderArmor->add("Rigid Leather");
						d1_MissileDefenderArmor->add("Chain"); d1_MissileDefenderArmor->add("Plate");
					} else if (config.i_diceSystem == DICE_RMS) {	// RMS
						d1_CombatDefenderArmor->clear();					// TODO
						d1_CombatDefenderArmor->add("AR0"); d1_CombatDefenderArmor->add("AR1");
						d1_CombatDefenderArmor->add("AR2"); d1_CombatDefenderArmor->add("AR3");
						d1_CombatDefenderArmor->add("AR4"); d1_CombatDefenderArmor->add("AR5");
					}
					d1_CombatWeaponUsed[1]->clear();
					if ((wtbl = (weapon_tab *)getD100Table("WE")) != NULL) {
						for (i=0; i<MAX_D100WEAPONS; i++) {
//printf("WP = %s\n", wtbl->wp_dsc);
							if (wtbl->wp_ob == 5) {			// search for spells
								d1_CombatWeaponUsed[1]->add(wtbl->wp_dsc);
							}
							wtbl++;
						}
					} else {
//printf("Unable to find std weapons/spells ... using defaults\n");
						d1_CombatWeaponUsed[1]->add("Base Spell");
						d1_CombatWeaponUsed[1]->add("Shock Bolt");
						d1_CombatWeaponUsed[1]->add("Water Bolt");
						d1_CombatWeaponUsed[1]->add("Ice Bolt");
						d1_CombatWeaponUsed[1]->add("Fire Bolt");
						d1_CombatWeaponUsed[1]->add("Lightning Bolt");
						d1_CombatWeaponUsed[1]->add("Cold Ball");
						d1_CombatWeaponUsed[1]->add("Fire Ball");
						d1_CombatWeaponUsed[1]->add("Special");
					}
					break;

		case 1: // reset all the screen fields
					for (i=0; i<3; i++) {
						d1_CombatModifiers[i]->check_none();
						d1_CombatResults[i][0]->value(""); d1_CombatResults[i][1]->value(""); d1_CombatResults[i][2]->value(""); d1_CombatResults[i][3]->value("");
						d1_CombatResults[i][4]->value(""); d1_CombatResults[i][5]->value(""); d1_CombatResults[i][6]->value(""); d1_CombatResults[i][7]->value("");
						d1_CombatCritRoll[i][0]->value(""); d1_CombatCritRoll[i][1]->value("");
						d1_CombatOB[i]->value("");
						d1_CombatAdj[i]->value("");
						d1_CombatAttkRoll[i]->value("");
						d1_CombatParry[i][0]->value(""); d1_CombatParry[i][1]->value("");
						d1_CombatWeaponDetails[i]->clear();
						d1_CombatAttkTable[i]->value("");
						d1_CombatCritTable[i][0]->value(""); d1_CombatCritTable[i][1]->value("");
						d1_CombatCrit[i][0]->value(0);
						d1_CombatCrit[i][1]->value(0);
					}
					i = 3;	// Heal screen
					d1_CombatModifiers[i]->check_none();
					d1_CombatOB[i]->value("");
					d1_CombatAdj[i]->value("");
					d1_CombatAttkRoll[i]->value("");

					i = getAdjustment(config.i_actionInitID, MOD_BAB); sprintf(mybuf2, "%d", i);
					d1_CombatMods[0][0]->value(mybuf2); d1_CombatMods[1][0]->value(mybuf2); d1_CombatMods[2][0]->value(mybuf2); d1_CombatMods[3][0]->value(mybuf2);
					i = getAdjustment(config.i_actionInitID, MOD_DAMAGE); sprintf(mybuf2, "%d", i);
					d1_CombatMods[0][2]->value(mybuf2); d1_CombatMods[1][2]->value(mybuf2); d1_CombatMods[2][2]->value(mybuf2); d1_CombatMods[3][2]->value(mybuf2);
					sprintf(mybuf2, "%d", players[config.i_actionInitID].i_penalty[PENALTY_ACTIVITY]);
					d1_CombatMods[0][3]->value(mybuf2); d1_CombatMods[1][3]->value(mybuf2); d1_CombatMods[2][3]->value(mybuf2);

					sprintf(mybuf2, "%d", players[config.i_actionInitID].i_initiative[0] + getAdjustment(config.i_actionInitID, MOD_MOVE)); 
					d1_CombatOB[4]->value(mybuf2);
						// mark that they are at 50% of health
					if (((players[config.i_actionInitID].i_hp[HP_CUR] * 100) / players[config.i_actionInitID].i_hp[HP_MAX]) < 50) {
						d1_CombatModifiers[0]->checked(6,1);
						d1_CombatModifiers[2]->checked(2,1);
					}
						// update the screen values etc
					doD100ActionModifiers(config.i_actionSelected, 0);

					break;

		case 2:	// show the defender details
					d1_DefenderList[0]->clear(); d1_DefenderList[1]->clear(); d1_DefenderList[2]->clear(); d1_DefenderList[3]->clear();
					d1_DefenderList[4]->clear();
					if (config.i_actionInitID < MAX_PLAYERS) {
						for (i=MAX_PLAYERS; i<MAX_MEMBERS; i++) {
							if (players[i].c_name[0] != '\0' && players[i].i_hp[HP_MAX] > 0 && players[i].flags.f_disabled == 0) {
								doD100SetDefenderListName(i);
								config.i_idList[ID_DEFD][j++] = i;
							}
						}
						for (i=0; i<MAX_PLAYERS; i++) {
							if (players[i].c_name[0] != '\0' && players[i].i_hp[HP_MAX] > 0 && players[i].flags.f_disabled == 0) {
								doD100SetDefenderListName(i);
								config.i_idList[ID_DEFD][j++] = i;
							}
						}
					} else {
						for (i=0; i<MAX_MEMBERS; i++) {
							if (players[i].c_name[0] != '\0' && players[i].i_hp[HP_MAX] > 0 && players[i].flags.f_disabled == 0) {
								doD100SetDefenderListName(i);
								config.i_idList[ID_DEFD][j++] = i;
							}
						}
					}
					j = players[config.i_actionInitID].i_doneAttacks-1;					// default the previous defender
					if (j >= 0) {
						j = players[config.i_actionInitID].i_whomAttacked[j][0];
						for (i=0; i<MAX_MEMBERS; i++) {
							if (config.i_idList[ID_DEFD][i] == j) {
//printf("Default Defd = %d\n", j);
								d1_DefenderList[0]->select(i+1, 1); d1_DefenderList[2]->select(i+1, 1);
								config.i_actionRecvID = j = players[config.i_actionInitID].i_whomAttacked[0][0];
								doD100SelectDefender(config.i_actionSelected, i+1);
								break;
							}
						}
					}
						// defd stunned so mark that
					if (players[config.i_actionRecvID].i_stun > 0) {
						d1_CombatModifiers[0]->checked(4,1);
					}
						// update the screen values etc
					doD100ActionModifiers(config.i_actionSelected, 0);

					d1_CombatAcceptAll[config.i_actionSelected]->activate();

					break;
	}
	if (action != 2) {
		d1_CombatAcceptAll[0]->deactivate(); d1_CombatAcceptAll[1]->deactivate();
		d1_CombatAcceptAll[2]->deactivate(); d1_CombatAcceptAll[3]->deactivate();
		d1_CombatAcceptAll[4]->deactivate();
	}

	for (i=0; i<5; i++) { for (j=0; j<8; j++) { d100ActionModifiersFlags[i][j] = 0; } }
}

/******************************************************************************/
void loadd100file(char *fname, char *fid) {
int i, j;
struct stat fs;

	for (i=0; i<MAX_D100TABLES; i++) {
		if (d100TableMem[i] == NULL) {
//printf("ld1f: %d %s %s\n", i, fname, fid);
			if ((j = open(fname, O_RDONLY)) != -1) {
				if (fstat(j, &fs) == 0) {
					if ((d100TableMem[i] = (char *)malloc(fs.st_size)) != NULL) {
//printf("ld1f: %d %s = %d\n", i, fname, fs.st_size);
						read(j, d100TableMem[i], fs.st_size);
						strcpy(&d100TableId[i][0], fid);
					}
				}
			}
			return;
		}
	}
}
/******************************************************************************/
void doD100LoadAllTables(char *path) {
int num_entries=0, i=0, j=0, k=0;
struct dirent **list;
struct stat fs;
char *cp, *cp1, tid[4], fname[200];

	for (i=0; i<MAX_D100TABLES; i++) {
		if (d100TableMem[i] != NULL) {
			free(d100TableMem[i]);
			d100TableId[i][0] = d100TableId[i][1] = d100TableId[i][2] = d100TableId[i][3] = '\0';
		} 
	}

#ifdef WINDOWS
	num_entries = fl_filename_list(path, &list, fl_casealphasort);
#else
	num_entries = scandir(path, &list, NULL, alphasort);
#endif
	if (num_entries < 3) { return; }
//printf("ddLAT: 2: %s : %d\n", path, num_entries);

	for (i=2; i<num_entries; i++) {
		cp = list[i]->d_name;
//printf("ddLAT: %d %s %s\n", i, path, list[i]->d_name);
		if (strncasecmp(cp, "tab_", 3) == 0) {
			tid[0] = toupper(cp[4]);
			tid[1] = toupper(cp[5]);
			tid[2] = tid[3] = '\0';
			if (cp[6] != '.') { tid[2] = toupper(cp[6]); }
			sprintf(fname, "%s%s", path, cp);
			if ((j = open(fname, O_RDONLY)) != -1) {
				if (fstat(j, &fs) == 0) {
					if ((d100TableMem[k] = (char *)malloc(fs.st_size)) != NULL) {
						read(j, d100TableMem[k], fs.st_size);
						strcpy(&d100TableId[k][0], tid);
//printf("ddLAT: %s : %s (%d:%d)\n", cp, &d100TableId[k][0], (k+1), fs.st_size);
						k++;
					}
				}
				close(j);
			}
		}
	}

	return;
}

/******************************************************************************/
char *getD100Table(char *tbl) {
int i;

		// ignore certain tables lookups
	if (strcasecmp(tbl, "PZ") == 0) { return NULL; }

	for (i=0; i<MAX_D100TABLES; i++) {
		if (strcasecmp(&d100TableId[i][0], tbl) == 0) {
//printf("gDT: %s -> %s\n", tbl, &d100TableId[i][0]);
			return d100TableMem[i];
		}
	}
	sprintf(mybuf1, "Unable to load data file %s", tbl);
	doSystemAlert(mybuf1);
	return NULL;
}

/******************************************************************************/
void doD100SetDefenderListName(int pid) {
char fmt[10];
int k;

	fmt[0] = mybuf2[0] = '\0';
	k = getHPs(pid);

//	if (players[pid].i_doneAttacks > 0) { strcpy(fmt, "@B88@."); }
	if (players[pid].i_stun > 0) { strcat(mybuf2, "S"); strcpy(fmt, "@B95@."); }
	if (k <= players[pid].i_unconciousAt) { strcat(mybuf2, "U"); strcpy(fmt, "@B95@."); }
	if (players[pid].i_inactive > 0) { strcat(mybuf2, "I"); strcpy(fmt, "@B95@."); }

	sprintf(mybuf1, "%s%d%% %s (%d *%s %d:%d)", fmt, getHPpercentage(pid), players[pid].c_name, k, mybuf2, players[pid].i_noAttacks, players[pid].i_doneAttacks);
	d1_DefenderList[0]->add(mybuf1); d1_DefenderList[1]->add(mybuf1);
	d1_DefenderList[2]->add(mybuf1); d1_DefenderList[3]->add(mybuf1);
	d1_DefenderList[4]->add(mybuf1);
}

/******************************************************************************/
void doD100SelectAction(int action) {
int i=0, j=0;

//printf("dDAM: %d\n", action);

	d1_ActionTab->activate();
	d1_ActionType->deactivate();
	d1_DefenderList[0]->clear(); d1_DefenderList[1]->clear();
	d1_DefenderList[2]->clear(); d1_DefenderList[3]->clear();
	d1_DefenderList[4]->clear();

	doD100WindowSetup(1);

	config.i_actionSelected = action-1;

	switch (action) {
		case 1:	d1_ActionMeleeTab->activate(); d1_ActionTab->value(d1_ActionMeleeTab);
					break;
		case 2: d1_ActionSpellTab->activate(); d1_ActionTab->value(d1_ActionSpellTab);
					break;
		case 3: d1_ActionMissileTab->activate(); d1_ActionTab->value(d1_ActionMissileTab);
					break;
		case 4: d1_ActionHealTab->activate(); d1_ActionTab->value(d1_ActionHealTab);
					break;
		case 5: d1_ActionMoveTab->activate(); d1_ActionTab->value(d1_ActionMoveTab);
					d1_CombatMMDifficulty->value(0);
					break;
	}
	
	if (config.i_actionInitID >= MAX_PLAYERS || config.flags.f_rollAllRolls != 0) {
		sprintf(mybuf2, "%d", getD100DiceRoll()); 
		d1_CombatAttkRoll[0]->value(mybuf2); d1_CombatAttkRoll[1]->value(mybuf2);
		d1_CombatAttkRoll[2]->value(mybuf2); d1_CombatAttkRoll[3]->value(mybuf2);
		sprintf(mybuf2, "%d", getRND(100)); 
		d1_CombatCritRoll[0][0]->value(mybuf2); d1_CombatCritRoll[1][0]->value(mybuf2);
		d1_CombatCritRoll[2][0]->value(mybuf2); 
		sprintf(mybuf2, "%d", getRND(100)); 
		d1_CombatCritRoll[0][1]->value(mybuf2); d1_CombatCritRoll[1][1]->value(mybuf2);
		d1_CombatCritRoll[2][1]->value(mybuf2); 
	}

		doD100WindowSetup(2);			// show the defender details
	
		j = players[config.i_actionInitID].i_doneAttacks;					// default the last defender attacked
		j = players[config.i_actionInitID].i_whomAttacked[0][0];
		for (i=0; i<MAX_MEMBERS; i++) {
			if (config.i_idList[ID_DEFD][i] == j) {
				d1_DefenderList[0]->select(i+1, 1); d1_DefenderList[2]->select(i+1, 1);
				config.i_actionRecvID = j = players[config.i_actionInitID].i_whomAttacked[0][0];
				doD100SelectDefender(config.i_actionSelected, i+1);
				break;
			}
		}
	
		d1_CombatWeaponUsed[0]->clear(); d1_CombatWeaponUsed[2]->clear();
		j=0;
	
		for (i=0; i<MAX_WEAPONS; i++) {
			if (players[config.i_actionInitID].w_weapons[i].c_description[0] != '\0') {
				d1_CombatWeaponUsed[0]->add(players[config.i_actionInitID].w_weapons[i].c_description);
				d1_CombatWeaponUsed[2]->add(players[config.i_actionInitID].w_weapons[i].c_description);
				config.i_idList[ID_WEAP][j++] = i;
			}
		}
		for (i=0; i<MAX_WEAPONS; i++) {
			if (players[config.i_actionInitID].i_whomAttacked[0][1] == config.i_idList[ID_WEAP][i]) {
				d1_CombatWeaponUsed[0]->select(i+1, 1); d1_CombatWeaponUsed[2]->select(i+1, 1);
				doD100SelectWeapon(action-1, i+1);
				break;
			}
		}
}

/******************************************************************************/
void doD100SelectDefender(int screen, int defd) {
int i, recv, weap;
int spellcharge[] = {-30, -15, 0, +10, +20};
int missileload[] = {0};

//printf("dDSD: %d:%d\n", screen, defd);

	config.i_actionRecvID = defd = config.i_idList[ID_DEFD][defd-1];

	if (defd < 0 || defd > MAX_MONSTERS) {
//printf("dDSD: Defender range error %d\n", defd);
		return;
	}

	i = players[defd].i_armorClass[AC_NORMAL] + getAdjustment(defd, MOD_AC); sprintf(mybuf2, "%d", i); 
	d1_CombatMods[0][1]->value(mybuf2); d1_CombatMods[1][1]->value(mybuf2); d1_CombatMods[2][1]->value(mybuf2);

	sprintf(mybuf2, "%s (%s)", players[config.i_actionInitID].c_name, players[config.i_actionInitID].c_items); 
	if (screen == 4) {	// move
		sprintf(mybuf2, "%s (%s Perc = %d Stalk/Hide = %d ReadRune = %d UseItem = %d)", players[config.i_actionInitID].c_name, players[config.i_actionInitID].c_items, players[config.i_actionInitID].i_skills[SKILL_PERC], players[config.i_actionInitID].i_skills[SKILL_STALK], players[config.i_actionInitID].i_skills[SKILL_READRUNE], players[config.i_actionInitID].i_skills[SKILL_USEITEM]);
	}
	d1_ActionMessages->text(1, mybuf2);

	d1_CombatMods[screen][2]->value("0");		// Damage Mod
	d1_CombatMods[screen][3]->value("0");		// APen Mod
	d1_ActionMessages->text(3, "");

	d1_CombatModifiers[0]->check_none(); d1_CombatModifiers[1]->check_none();
	d1_CombatModifiers[2]->check_none(); d1_CombatModifiers[3]->check_none();

		// mark that they are at 50% of health
	if (((players[config.i_actionInitID].i_hp[HP_CUR] * 100) / players[config.i_actionInitID].i_hp[HP_MAX]) < 50) {
		d1_CombatModifiers[0]->checked(6,1);
		d1_CombatModifiers[2]->checked(2,1);
	}
		// defd stunned so mark that
	if (players[defd].i_stun > 0) {
		d1_CombatModifiers[0]->checked(4,1);
	}
		// update the screen values etc
	doD100ActionModifiers(screen, 0);

	switch (screen) {
		case 0:		// melee screen
				// sprintf(mybuf2, "%d", players[defd].i_armorClass[AC_NORMAL] + i); d1_CombatMods[0][1]->value(mybuf2);
				d1_CombatDefenderArmor->value(players[defd].i_armorClassSplit[AC_SECTION_WORN]);

				if (players[defd].i_armorClassSplit[AC_SECTION_WORN] < 0) d1_CombatDefenderArmor->value(1);
				if (config.i_diceSystem == DICE_MERP) {
					if (players[defd].i_armorClassSplit[AC_SECTION_WORN] > 5) d1_CombatDefenderArmor->value(5);
				} else {
					if (players[defd].i_armorClassSplit[AC_SECTION_WORN] > 20) d1_CombatDefenderArmor->value(20);
				}
				sprintf(mybuf1, "%d", players[config.i_actionInitID].i_armorClass[AC_FLATFOOTED]); d1_CombatParry[screen][0]->value(mybuf1);
				sprintf(mybuf1, "%d", players[config.i_actionRecvID].i_armorClass[AC_FLATFOOTED]); d1_CombatParry[screen][1]->value(mybuf1);

				sprintf(mybuf2, "%d", players[defd].i_armorClass[AC_SECTION_PARRY]);
				sprintf(mybuf2, "Defender: %s . DB = %d Shield = %d (Helm %s, Leg %s, Arm %s)", players[defd].c_name, players[defd].i_armorClass[AC_NORMAL], players[defd].i_armorClass[AC_SHIELD], &armorType[players[defd].i_armorClassSplit[AC_SECTION_HELM]][0], &armorType[players[defd].i_armorClassSplit[AC_SECTION_LEG]][0], &armorType[players[defd].i_armorClassSplit[AC_SECTION_ARM]][0]); 
				d1_ActionMessages->text(2, mybuf2);
				if (players[defd].i_armorClass[AC_SHIELD] > 0) { 
					d1_ActionMessages->text(3, "@B95@.Please adjust attack rolls with the Shield amount as required");
				}
				break;

		case 1:		// spell screen
				d1_CombatMods[1][1]->value("0");
				sprintf(mybuf2, "%d", players[defd].i_abilityStats[0][1]); d1_CombatMods[1][1]->value(mybuf2);	// AG Bonus
				sprintf(mybuf2, "Defender: %s . DB = %d Shield = %d (Helm %s, Leg %s, Arm %s)", players[defd].c_name, players[defd].i_armorClass[AC_NORMAL], players[defd].i_armorClass[AC_SHIELD], &armorType[players[defd].i_armorClassSplit[AC_SECTION_HELM]][0], &armorType[players[defd].i_armorClassSplit[AC_SECTION_LEG]][0], &armorType[players[defd].i_armorClassSplit[AC_SECTION_ARM]][0]); 
				d1_ActionMessages->text(2, mybuf2);
				d1_SpellDefenderArmor->value(players[defd].i_armorClassSplit[AC_SECTION_WORN]);
				if (players[defd].i_armorClass[AC_SHIELD] > 0) { 
					d1_ActionMessages->text(3, "@B95@.Please adjust attack rolls with the Shield amount as required");
				}
				sprintf(mybuf1, "Rounds spent charging spell = %d", players[config.i_actionInitID].i_roundsUntil[ROUND_SPELL_CHG]);
				d1_ActionMessages->text(3, mybuf1);
				if (players[config.i_actionInitID].i_roundsUntil[ROUND_SPELL_CHG] > 4) {
					players[config.i_actionInitID].i_roundsUntil[ROUND_SPELL_CHG] = 4;
				}
				sprintf(mybuf1, "Spell Resistance Roll is: %d adjusted by Base Spell Attack Result plus RR: Ess %d. Chan %d", getD100ResistanceRoll(players[config.i_actionInitID].i_levels[0], players[config.i_actionRecvID].i_levels[0]) - getAdjustment(config.i_actionRecvID, MOD_SAVE), players[config.i_actionRecvID].i_savingThrows[SAVE_FORTITUDE], players[config.i_actionRecvID].i_savingThrows[SAVE_REFLEX]);
				if (players[config.i_actionInitID].i_classes[2] == 1) { strcat(mybuf1, " -> Essence Caster"); }
				if (players[config.i_actionInitID].i_classes[2] == 2) { strcat(mybuf1, " -> Channeling Caster"); }
				d1_ActionMessages->text(4, mybuf1);
				break;

		case 2:		// missile screen
				//sprintf(mybuf2, "%d", players[defd].i_armorClass[AC_NORMAL] + i); d1_CombatMods[0][1]->value(mybuf2);
				sprintf(mybuf2, "Defender: %s . DB = %d Shield = %d (Helm %s, Leg %s, Arm %s)", players[defd].c_name, players[defd].i_armorClass[AC_NORMAL], players[defd].i_armorClass[AC_SHIELD], &armorType[players[defd].i_armorClassSplit[AC_SECTION_HELM]][0], &armorType[players[defd].i_armorClassSplit[AC_SECTION_LEG]][0], &armorType[players[defd].i_armorClassSplit[AC_SECTION_ARM]][0]); 
				d1_ActionMessages->text(2, mybuf2);
				sprintf(mybuf1, "%d", players[config.i_actionInitID].i_armorClass[AC_FLATFOOTED]); d1_CombatParry[screen][0]->value(mybuf1);
				sprintf(mybuf1, "%d", players[config.i_actionRecvID].i_armorClass[AC_FLATFOOTED]); d1_CombatParry[screen][1]->value(mybuf1);
				if (players[defd].i_armorClass[AC_SHIELD] > 0) { 
					d1_ActionMessages->text(3, "@B95@.Please adjust attack rolls with the Shield amount as required");
				}
				d1_MissileDefenderArmor->value(players[defd].i_armorClassSplit[AC_SECTION_WORN]);
				sprintf(mybuf1, "Rounds spent loading missile weapon = %d. Adjust roll based on reload times", players[config.i_actionInitID].i_roundsUntil[ROUND_MISSILE_CHG]);
				d1_ActionMessages->text(4, mybuf1);
				break;

		case 3:		// heal screen
				break;

		case 4:		// move screen
				break;
	}

		// check if a weapon has already be selected and redo its things
	if (screen < 3) {
		if (d1_CombatWeaponUsed[screen]->value() > 0) {
//printf("dDSD: weapon already selected so readjusting for that\n");
			doD100SelectWeapon(screen, d1_CombatWeaponUsed[screen]->value());
		}
	}
}

/******************************************************************************/
void doD100SelectWeapon(int screen, int weapon) {
int i;
weapon_tab *wtbl;
int spellchg[] = {-30, -15, 0, +10, +20};		// adjustments for rnds spent charging spell

//printf("dDSW: %d:%d\n", screen, weapon);

	if (screen == 4) { 	// check OB vs Parry amount
		if (weapon == 0) {
//printf("Attk OB vs Parry : %d - %d\n", atoi(d1_CombatParry[0][0]->value()), d100WeaponUsed.i_attackBonus[0]);
			if (atoi(d1_CombatParry[0][0]->value()) > d100WeaponUsed.i_attackBonus[0]) {
				sprintf(mybuf1, "%d", d100WeaponUsed.i_attackBonus[0]);
				d1_CombatParry[0][0]->value(mybuf1);
			}
		} else {
//printf("Defd OB vs Parry : %d - %d\n", atoi(d1_CombatParry[0][1]->value()), players[config.i_actionRecvID].w_weapons[0].i_attackBonus[0]);
			i = players[config.i_actionRecvID].i_whomAttacked[0][1];
			if (i < 0 || i > MAX_ATTACKS) { i = 0; }
//printf("Using defd weapon %d\n", i);
			if (atoi(d1_CombatParry[0][1]->value()) > players[config.i_actionRecvID].w_weapons[i].i_attackBonus[0]) {
				sprintf(mybuf1, "%d", players[config.i_actionRecvID].w_weapons[i].i_attackBonus[0]);
				d1_CombatParry[0][1]->value(mybuf1);
			}
		}
		return;
	}

	d1_CombatWeaponDetails[0]->clear(); d1_CombatWeaponDetails[1]->clear(); d1_CombatWeaponDetails[2]->clear();
	config.i_actionWeaponSelected = weapon = config.i_idList[ID_WEAP][weapon-1];
	memset(&d100WeaponUsed.c_available, '\0', sizeof(ADMPweapon));

	switch (screen) {
		case 0:		// melee screen
		case 2:		// missile screen
				players[config.i_actionInitID].i_whomAttacked[0][1] = config.i_actionWeaponSelected;
				sprintf(mybuf1, "  Name: %s", players[config.i_actionInitID].w_weapons[weapon].c_description); d1_CombatWeaponDetails[screen]->add(mybuf1);
				sprintf(mybuf1, "  Table: %s", players[config.i_actionInitID].w_weapons[weapon].c_table); d1_CombatWeaponDetails[screen]->add(mybuf1);
				sprintf(mybuf1, "Fumble: %d", players[config.i_actionInitID].w_weapons[weapon].i_fumble); d1_CombatWeaponDetails[screen]->add(mybuf1);
				sprintf(mybuf1, "P Crit: %s", players[config.i_actionInitID].w_weapons[weapon].c_damage); d1_CombatWeaponDetails[screen]->add(mybuf1);
				sprintf(mybuf1, "2 Crit: %s", players[config.i_actionInitID].w_weapons[weapon].c_critical); d1_CombatWeaponDetails[screen]->add(mybuf1);
				sprintf(mybuf1, "Sp Msg: %s", players[config.i_actionInitID].w_weapons[weapon].c_message); d1_CombatWeaponDetails[screen]->add(mybuf1);

				sprintf(mybuf1, "%d", players[config.i_actionInitID].w_weapons[weapon].i_attackBonus[0]); d1_CombatOB[screen]->value(mybuf1); 

				memcpy(&d100WeaponUsed.c_available, &players[config.i_actionInitID].w_weapons[weapon].c_available, sizeof(ADMPweapon));
				d1_CombatAttkTable[screen]->value(d100WeaponUsed.c_table);
				d1_CombatCritTable[screen][0]->value(d100WeaponUsed.c_damage);
				d1_CombatCritTable[screen][1]->value(d100WeaponUsed.c_critical);
				doD100WeaponParse(screen, d100WeaponUsed.c_message);		// parse any special weapon settings ie. vs armor types etc etc
				if (strcasecmp(d100WeaponUsed.c_table, "PZ") == 0) {		// if poison Attack
					i = getD100ResistanceRoll(atoi(d1_CombatOB[screen]->value()), players[config.i_actionRecvID].i_levels[0]) - players[config.i_actionRecvID].i_savingThrows[SAVE_POISON] - getAdjustment(config.i_actionRecvID, MOD_SAVE);
					if (config.i_actionRecvID >= MAX_PLAYERS) {
						if (getRND(100) >= i) {
							sprintf(mybuf1, "@B63@.Poison Attack RR required = %d ... Success", i);
						} else {
							sprintf(mybuf1, "@B171@.Poison Attack RR required = %d ... Failure", i);
						}
					} else {
						sprintf(mybuf1, "Poison Attack RR required = %d", i);
					}
					d1_ActionMessages->text(6, mybuf1);
				} else {
					d1_ActionMessages->text(6, "");
				}
				break;

		case 1:		// spell screen
				if ((weapon = d1_CombatWeaponUsed[1]->value()) == 0) return;
				if ((wtbl = (weapon_tab *)getD100Table("WE")) != NULL) {
					for (i=0; i<MAX_D100WEAPONS; i++) {
						if (wtbl->wp_ob == 5 && strcasecmp(wtbl->wp_dsc, d1_CombatWeaponUsed[1]->text(weapon)) == 0) {			// search the spells
							sprintf(mybuf1, "  Name: %s", wtbl->wp_dsc); d1_CombatWeaponDetails[1]->add(mybuf1);
							sprintf(mybuf1, "  Table: %s", wtbl->wp_tbl); d1_CombatWeaponDetails[1]->add(mybuf1);
							sprintf(mybuf1, "Fumble: %d", wtbl->wp_fm); d1_CombatWeaponDetails[1]->add(mybuf1);
							sprintf(mybuf1, "P Crit: %s", wtbl->wp_pc); d1_CombatWeaponDetails[1]->add(mybuf1);
							sprintf(mybuf1, "2 Crit: %s", wtbl->wp_sc); d1_CombatWeaponDetails[1]->add(mybuf1);
							sprintf(mybuf1, "Sp Msg: %s", wtbl->wp_sm); d1_CombatWeaponDetails[1]->add(mybuf1);

							strcpy(d100WeaponUsed.c_description, wtbl->wp_dsc);
							d100WeaponUsed.i_fumble = wtbl->wp_fm;
							d100WeaponUsed.i_critAdjust = wtbl->wp_ca;
							strcpy(d100WeaponUsed.c_damage, wtbl->wp_pc);
							strcpy(d100WeaponUsed.c_critical, wtbl->wp_sc);
							strcpy(d100WeaponUsed.c_message, wtbl->wp_sm);
							strcpy(d100WeaponUsed.c_table, wtbl->wp_tbl);

							d1_CombatAttkTable[screen]->value(d100WeaponUsed.c_table);
							d1_CombatCritTable[screen][0]->value(d100WeaponUsed.c_damage);
							d1_CombatCritTable[screen][1]->value(d100WeaponUsed.c_critical);

							break;
						}
						wtbl++;
					}
				}
				d1_CombatModifiers[1]->clear();
//printf("dDSW: %d %s\n", screen, d100WeaponUsed.c_table);
				d1_CombatAdj[1]->value("");

				if (strcasecmp(d100WeaponUsed.c_table, "SA") == 0) {		// Ball spell
					sprintf(mybuf2, "%d", players[config.i_actionRecvID].i_abilityStats[0][1]); d1_CombatMods[1][1]->value(mybuf2);	// AG Bonus
					sprintf(mybuf1, "%d", players[config.i_actionInitID].i_baseSpell);
					   // Ball Spells
					d1_CombatModifiers[1]->add("Instantaneous");
					d1_CombatModifiers[1]->add("+20 Def: Centred");
					//d1_CombatModifiers[1]->add("Def: -AG Bonus");
					d1_CombatModifiers[1]->add("+35 0' - 10'");
					d1_CombatModifiers[1]->add("+0 11' - 50'");
					d1_CombatModifiers[1]->add("-20 51' - 100'");
					d1_CombatModifiers[1]->add("-40 101' - 200'");
					d1_CombatModifiers[1]->add("-55 201' - 300'");
					d1_CombatModifiers[1]->add("-15 Def Cover 25%");
					d1_CombatModifiers[1]->add("-30 Def Cover 50%");
				} else if (strstr(d100WeaponUsed.c_description, "Bolt") != NULL) {		// Bolt spell
					sprintf(mybuf2, "%d", players[config.i_actionRecvID].i_abilityStats[0][1]); d1_CombatMods[1][1]->value(mybuf2);	// AG Bonus
					sprintf(mybuf1, "%d", players[config.i_actionInitID].i_directedSpells);
   // Bolt Spells
					d1_CombatModifiers[1]->add("Instantaneous");
					//d1_CombatModifiers[1]->add("Def: -AG Bonus");
					d1_CombatModifiers[1]->add("+35 0' - 10'");
					d1_CombatModifiers[1]->add("+0 11' - 50'");
					d1_CombatModifiers[1]->add("-20 51' - 100'");
					d1_CombatModifiers[1]->add("-40 101' - 200'");
					d1_CombatModifiers[1]->add("-55 201' - 300'");
					d1_CombatModifiers[1]->add("-15 Def Cover 25%");
					d1_CombatModifiers[1]->add("-30 Def Cover 50%");
				} else {			// assume Base spell then
					sprintf(mybuf1, "%d", players[config.i_actionInitID].i_baseSpell);
					d1_CombatMods[1][1]->value("0");		// dont get AG bonus adjustment
					   // Base Spells
					d1_CombatModifiers[1]->add("Instantaneous");
					d1_CombatModifiers[1]->add("+10 Def: Unmoving");
					//d1_CombatModifiers[1]->add("Def: -AG Bonus");
					d1_CombatModifiers[1]->add("+30 Touching");
					d1_CombatModifiers[1]->add("+10 0' - 10'");
					d1_CombatModifiers[1]->add("+0 11' - 50'");
					d1_CombatModifiers[1]->add("-10 51' - 100'");
					d1_CombatModifiers[1]->add("-20 101' - 200'");
					d1_CombatModifiers[1]->add("-30 201' - 300'");
					d1_CombatModifiers[1]->add("-10 Def Cover 25%");
					d1_CombatModifiers[1]->add("-20 Def Cover 50%");
				}
				d1_CombatOB[screen]->value(mybuf1); 
				sprintf(mybuf1, "%d", spellchg[players[config.i_actionInitID].i_roundsUntil[ROUND_SPELL_CHG]]);
				d1_CombatMods[screen][0]->value(mybuf1);
				d1_CombatModifiers[1]->redraw();
				doD100WeaponParse(screen, d100WeaponUsed.c_message);		// parse any special weapon settings ie. vs armor types etc etc
				break;

		case 3:		// heal screen
				break;

	}

}

/******************************************************************************/
// Accept this Attack, All Attacks done
void doD100ActionOption(int screen, int option) {
int i=0,j;
float xpm=1.0;
int mmxp[9] = {0,5,10,50,100,150,200,300,500};

//printf("dDAO: args %d:%d\n", screen, option);

	doD100IgnoreAdjustment(config.i_actionRecvID);

	switch (option) {
		case 0:	//	accept this attack
					i = players[config.i_actionInitID].i_doneAttacks;
					players[config.i_actionInitID].i_whomAttacked[i][0] = config.i_actionRecvID;

					switch (screen) {
					 case 3:		// healing
						players[config.i_actionRecvID].i_hp[HP_CUR] += atoi(d1_CombatResults[screen][0]->value()) + atoi(d1_CombatMods[screen][2]->value());	//HP
						players[config.i_actionRecvID].i_penalty[PENALTY_ACTIVITY] -= atoi(d1_CombatResults[screen][1]->value());	//APen
						players[config.i_actionRecvID].i_bleeding -= atoi(d1_CombatResults[screen][2]->value());	//Bleed
						players[config.i_actionRecvID].i_stun -= atoi(d1_CombatResults[screen][3]->value());	//Stun
						players[config.i_actionRecvID].i_armorClass[AC_SECTION_PARRY] -= atoi(d1_CombatResults[screen][4]->value());	//Rnds Parry
						players[config.i_actionRecvID].i_armorClass[AC_NOPARRY] -= atoi(d1_CombatResults[screen][5]->value());	//Rnds NoParry
						players[config.i_actionRecvID].i_roundsUntil[ROUND_DEATH] -= atoi(d1_CombatResults[screen][6]->value());	//Death
						players[config.i_actionRecvID].i_inactive -= atoi(d1_CombatResults[screen][7]->value());	//Inact

						if (players[config.i_actionRecvID].i_hp[HP_CUR] > players[config.i_actionRecvID].i_hp[HP_MAX]) { players[config.i_actionRecvID].i_hp[HP_CUR] = players[config.i_actionRecvID].i_hp[HP_MAX]; }
						if (players[config.i_actionRecvID].i_penalty[PENALTY_ACTIVITY] < 0) { players[config.i_actionRecvID].i_penalty[PENALTY_ACTIVITY] = 0; }
						if (players[config.i_actionRecvID].i_bleeding < 0) { players[config.i_actionRecvID].i_bleeding = 0; }
						if (players[config.i_actionRecvID].i_stun < 0) { players[config.i_actionRecvID].i_stun = 0; }
						if (players[config.i_actionRecvID].i_armorClass[AC_SECTION_PARRY] < 0) { players[config.i_actionRecvID].i_armorClass[AC_SECTION_PARRY] = 0; }
						if (players[config.i_actionRecvID].i_armorClass[AC_NOPARRY] < 0) { players[config.i_actionRecvID].i_armorClass[AC_NOPARRY] = 0; }
						if (players[config.i_actionRecvID].i_roundsUntil[ROUND_DEATH] < 0) { players[config.i_actionRecvID].i_roundsUntil[ROUND_DEATH] = 0; }
						if (players[config.i_actionRecvID].i_inactive < 0) { players[config.i_actionRecvID].i_inactive = 0; }
						break;

					 case 4:		// move
						if (atoi(d1_CombatAttkRoll[screen]->value()) > 0) {
							players[config.i_actionInitID].i_tempXP += mmxp[d1_CombatMMDifficulty->value()];
//printf("dDAO: MM XP %d:%d\n", config.i_actionInitID, mmxp[d1_CombatMMDifficulty->value()]);
							sprintf(mybuf2, "Move - %s difficulty %s . XP = %d", players[config.i_actionInitID].c_name, d1_CombatMMDifficulty->text(), mmxp[d1_CombatMMDifficulty->value()]);
							writeLog(mybuf2);
						}
						break;

					 default:	// melee, missiles & spells
//						if (screen == 1) { 	// spell
							players[config.i_actionInitID].i_roundsUntil[ROUND_SPELL_CHG] = 0;
//						} else if (screen == 2) { 	// missile
							players[config.i_actionInitID].i_roundsUntil[ROUND_MISSILE_CHG] = 0;
//						}

						if (screen != 1) {		// not spells, update parry amounts
							players[config.i_actionInitID].i_armorClass[AC_FLATFOOTED] = atoi(d1_CombatParry[screen][0]->value());
							players[config.i_actionRecvID].i_armorClass[AC_FLATFOOTED] = atoi(d1_CombatParry[screen][1]->value());
						}

							// set the XP multiplier before adjusting the results of this attack
						if (players[config.i_actionRecvID].i_stun > 0) { xpm = (float )0.5; }
						if (players[config.i_actionRecvID].i_hp[HP_CUR] == 0 || players[config.i_actionRecvID].i_inactive > 0) { xpm = (float )0.1; }
						if (players[config.i_actionRecvID].i_hp[HP_CUR] < 0) { xpm = (float )0.0; }

//printf("dDAO: XP Mult = %.1f\n", xpm);

						players[config.i_actionRecvID].i_hp[HP_CUR] -= atoi(d1_CombatResults[screen][0]->value()) + atoi(d1_CombatMods[screen][2]->value());	//HP
						players[config.i_actionRecvID].i_penalty[PENALTY_ACTIVITY] += atoi(d1_CombatResults[screen][1]->value());	//APen
						players[config.i_actionRecvID].i_bleeding += atoi(d1_CombatResults[screen][2]->value());	//Bleed
						players[config.i_actionRecvID].i_stun += atoi(d1_CombatResults[screen][3]->value());	//Stun
						players[config.i_actionRecvID].i_armorClass[AC_SECTION_PARRY] += atoi(d1_CombatResults[screen][4]->value());	//Rnds Parry
						players[config.i_actionRecvID].i_armorClass[AC_NOPARRY] += atoi(d1_CombatResults[screen][5]->value());	//Rnds NoParry
						players[config.i_actionRecvID].i_roundsUntil[ROUND_DEATH] += atoi(d1_CombatResults[screen][6]->value());	//Death
						players[config.i_actionRecvID].i_inactive += atoi(d1_CombatResults[screen][7]->value());	//Inact

							// Kill XP
						if (players[config.i_actionRecvID].i_hp[HP_CUR] < 0) {
							if (players[config.i_actionRecvID].i_hp[HP_CUR] < -20) {
								sprintf(mybuf2, "%s is now splattered (truely DEAD!) !!", players[config.i_actionRecvID].c_name);
							} else {
								sprintf(mybuf2, "%s is now whupped bad !!", players[config.i_actionRecvID].c_name);
							}
							i = players[config.i_actionRecvID].i_levels[0] - players[config.i_actionInitID].i_levels[0];
							if (i < -10) { i = -10; }
							if (i > 10) { i = 10; }
							players[config.i_actionInitID].i_tempXP += (200 + (i * 50)) * xpm;
//printf("dDAO: Kill XP %d:%d = %.1f\n", config.i_actionInitID, i, ((200 + (i * 50)) * xpm));
							writeLog(mybuf2);
							doSystemAlert(mybuf2);
						}

						if (screen == 1 && atoi(d1_CombatAttkRoll[screen]->value()) > 0) {	// Spells
							players[config.i_actionInitID].i_tempXP += 100 * xpm;		// rounded off to 100xp
//printf("dDAO: Spell XP %s:%d\n", players[config.i_actionInitID].c_name, (int )(100 * xpm));
						}

//						if (screen != 1 && atoi(d1_CombatAttkRoll[screen]->value()) > 0) {	// Melee or Missile attack
							i = d1_CombatCrit[screen][0]->value();
	 						if (i > 0 && i < 6) {
									// defd gets 100*CL xp
								players[config.i_actionRecvID].i_tempXP += (int )((i * 100) * xpm);
									// attkr gets XP for CL delivered
								players[config.i_actionInitID].i_tempXP += (int )((players[config.i_actionRecvID].i_levels[0] * i * 5) * xpm);
//printf("dDA0: 1st crit val = %d\n", i);
//printf("dDAO: XP %s = %d (%d)\n", players[config.i_actionInitID].c_name, players[config.i_actionInitID].i_tempXP, i);
//printf("dDAO: XP %s = %d\n", players[config.i_actionRecvID].c_name, players[config.i_actionRecvID].i_tempXP);
							}
							i = d1_CombatCrit[screen][1]->value();
	 						if (i > 0 && i < 6) {
								players[config.i_actionRecvID].i_tempXP += (int )((i * 100) * xpm);
								players[config.i_actionInitID].i_tempXP += (int )((players[config.i_actionRecvID].i_levels[0] * i * 5) * xpm);
//printf("dDA0: 2nd crit val = %d\n", i);
//printf("dDAO: XP %s = %d (%d)\n", players[config.i_actionInitID].c_name, players[config.i_actionInitID].i_tempXP, i);
//printf("dDAO: XP %s = %d\n", players[config.i_actionRecvID].c_name, players[config.i_actionRecvID].i_tempXP);
							}
						}
//					}

					players[config.i_actionInitID].i_doneAttacks++;
					sprintf(mybuf2, "%d", (players[config.i_actionInitID].i_noAttacks - players[config.i_actionInitID].i_doneAttacks));
					d1_CombatAttacksLeft->value(mybuf2);

					d1_CombatAcceptAll[screen]->activate();

					sprintf(mybuf2, "%s %s -> %s (HP:%d APen:%d Bleed:%d Stun:%d RParry:%d RNoParry:%d Death:%d Inact:%d)", players[config.i_actionInitID].c_name, d100WeaponUsed.c_description, players[config.i_actionRecvID].c_name,
					atoi(d1_CombatResults[screen][0]->value()), atoi(d1_CombatResults[screen][1]->value()), atoi(d1_CombatResults[screen][2]->value()),
					atoi(d1_CombatResults[screen][3]->value()), atoi(d1_CombatResults[screen][4]->value()), atoi(d1_CombatResults[screen][5]->value()),
					atoi(d1_CombatResults[screen][6]->value()), atoi(d1_CombatResults[screen][7]->value()));
					writeLog(mybuf2);
					if (players[config.i_actionInitID].i_doneAttacks < 7) {
						sprintf(mybuf2, "%s (HP:%d APen:%d Bleed:%d Stun:%d RParry:%d RNoParry:%d Death:%d Inact:%d)", players[config.i_actionRecvID].c_name,
						atoi(d1_CombatResults[screen][0]->value()), atoi(d1_CombatResults[screen][1]->value()), atoi(d1_CombatResults[screen][2]->value()),
						atoi(d1_CombatResults[screen][3]->value()), atoi(d1_CombatResults[screen][4]->value()), atoi(d1_CombatResults[screen][5]->value()),
						atoi(d1_CombatResults[screen][6]->value()), atoi(d1_CombatResults[screen][7]->value()));
						d1_ActionMessages->text(7+players[config.i_actionInitID].i_doneAttacks, mybuf2);
					}
					doD100WindowSetup(1);
					doD100WindowSetup(2);
					break;

		case 1:	//	all attacks done
					if (players[config.i_actionInitID].i_noAttacks == players[config.i_actionInitID].i_doneAttacks) {
						players[config.i_actionInitID].i_doneAttacks++;
					}
					a_d100CombatWindow->hide();
					reloadNames(1);
					setCombatDisplay(0);
					break;

		case 3:	// d100 roll
					sprintf(mybuf2, "%d", getD100DiceRoll()); d1_CombatAttkRoll[screen]->value(mybuf2);
					if (screen < 3) {
						sprintf(mybuf2, "%d", getRND(100)); d1_CombatCritRoll[screen][0]->value(mybuf2);
						sprintf(mybuf2, "%d", getRND(100)); d1_CombatCritRoll[screen][1]->value(mybuf2);
					}
					break;

		case 5:	// defd armor
					break;
	}

	d1_CombatResults[screen][0]->value("");
	d1_CombatResults[screen][1]->value("");
	d1_CombatResults[screen][2]->value("");
	d1_CombatResults[screen][3]->value("");
	d1_CombatResults[screen][4]->value("");
	d1_CombatResults[screen][5]->value("");
	d1_CombatResults[screen][6]->value("");
	d1_CombatResults[screen][7]->value("");

}

/******************************************************************************/
void doD100CalcAttack(int screen) {
int roll=0, i=0, j=0, a=0;
attk_tab *tbl1;
attk_tab2 *tbl2;
move_tab *mtbl;
char atbl[4];
int diff[] = {+30, +20, +10, 0, -10, -20, -30, -50, -70};

//printf("dDCA: %d\n", screen);

	d1_CombatResults[screen][0]->value("");
	d1_CombatResults[screen][1]->value("");
	d1_CombatResults[screen][2]->value("");
	d1_CombatResults[screen][3]->value("");
	d1_CombatResults[screen][4]->value("");
	d1_CombatResults[screen][5]->value("");
	d1_CombatResults[screen][6]->value("");
	d1_CombatResults[screen][7]->value("");
//	for (i=0; i<2; i++) {
//		d1_CombatResults[i][0]->value(""); d1_CombatResults[i][1]->value(""); d1_CombatResults[i][2]->value(""); d1_CombatResults[i][3]->value("");
//		d1_CombatResults[i][4]->value(""); d1_CombatResults[i][5]->value(""); d1_CombatResults[i][6]->value(""); d1_CombatResults[i][7]->value("");
//		d1_CombatCrit[i][0]->value(0); d1_CombatCrit[i][1]->value(0);
//	}
//	d1_CombatResults[3][0]->value(""); d1_CombatResults[3][1]->value(""); d1_CombatResults[3][2]->value(""); d1_CombatResults[3][3]->value("");
//	d1_CombatResults[3][4]->value(""); d1_CombatResults[3][5]->value(""); d1_CombatResults[3][6]->value(""); d1_CombatResults[3][7]->value("");
//	d1_CombatResults[4][0]->value(""); d1_CombatResults[4][1]->value(""); d1_CombatResults[4][2]->value(""); d1_CombatResults[4][3]->value("");
//	d1_CombatResults[4][4]->value(""); d1_CombatResults[4][5]->value(""); d1_CombatResults[4][6]->value(""); d1_CombatResults[4][7]->value("");

	if ((i = atoi(d1_CombatAttkRoll[screen]->value())) < 0) {				// FUMBLE		TODO
		doD100FumbleResult(config.i_actionInitID, screen, i);
			// everything now applies to the attacker
		config.i_actionRecvID = config.i_actionInitID;
		return;
	}

	switch (screen) {
		case 0:		// melee screen
		case 1:		// spell screen
		case 2:		// missile screen
				strcpy(atbl, d1_CombatAttkTable[screen]->value());		// use the attk table as marked on the screen
				if (strlen(atbl) < 2) {
					doSystemAlert("Please enter an Attack Table to use !!!!");
					return;
				}
				roll = atoi(d1_CombatAttkRoll[screen]->value());
				if (roll <= d100WeaponUsed.i_fumble) {						// TODO
					doSystemAlert("Fumble !!!! Please enter the fumble roll as a NEGATIVE Attk Roll");
				}
				if (config.i_diceSystem == DICE_MERP) {
					if (strcasecmp(atbl, "SB") == 0) {		// if Base Spell Attack
						if (players[config.i_actionInitID].i_classes[2] == 2) {	// Channeling spells get adjusted
							a = d1_SpellDefenderArmor->value();
							if (a == 3 || a == 4) { roll -= 10; }		// Pl.Ch = roll -10
						}
					}
					if (strcasecmp(atbl, "PZ") == 0) {		// if poison Attack
						a = getD100ResistanceRoll(atoi(d1_CombatOB[screen]->value()), players[config.i_actionRecvID].i_levels[0]) - players[config.i_actionRecvID].i_savingThrows[SAVE_POISON] - getAdjustment(config.i_actionRecvID, MOD_SAVE);
//printf("PZ attack = %d\n", a);
						if (config.i_actionRecvID >= MAX_PLAYERS) {
							if (getRND(100) >= a) {
								sprintf(mybuf1, "@B63@.Poison Attack RR required = %d ... Success", a);
							} else {
								sprintf(mybuf1, "@B171@.Poison Attack RR required = %d ... Failure", a);
							}
						} else {
							sprintf(mybuf1, "Poison Attack RR required = %d", a);
						}
						d1_ActionMessages->text(6, mybuf1);
					} else {
						getD100AttackRoll(atbl, roll, 1);
					}

					if (d100AttkTbl != NULL) {
						tbl1 = (attk_tab *)d100AttkTbl;
					} else {
						roll = atoi(d1_CombatAttkRoll[screen]->value()) + atoi(d1_CombatOB[screen]->value()) - atoi(d1_CombatParry[screen][0]->value()) + atoi(d1_CombatMods[screen][0]->value()) + atoi(d1_CombatAdj[screen]->value()) - (atoi(d1_CombatParry[screen][1]->value()) + atoi(d1_CombatMods[screen][1]->value()) + atoi(d1_CombatMods[screen][3]->value()));
						getD100AttackRoll(atbl, roll, 0);
						if (d100AttkTbl != NULL) { tbl1 = (attk_tab *)d100AttkTbl; } else { return; }
					}
						// get the right armor used by defd
					if (screen == 0) { a = 4 - d1_CombatDefenderArmor->value(); }
					if (screen == 1) { a = 4 - d1_SpellDefenderArmor->value(); }
					if (screen == 2) { a = 4 - d1_MissileDefenderArmor->value(); }
					if (a < 0) { a = 0; } if (a > 4) { a = 4; }

					if (strcasecmp(atbl, "SB") == 0) {		// if Base Spell Attack just display message
						if (players[config.i_actionInitID].i_classes[2] == 2) {	// Channeling spells get adjusted
							if (a == 2 || a == 3) { a = 4; }		// SL.RL = No
						}
						sprintf(mybuf1, "@B223@.Base Spell Attack Result = %d (adjust RR roll by this amount)", tbl1->res[a][0]);
						if (config.i_actionRecvID >= MAX_PLAYERS) {
							i = getRND(100);
							j = getD100ResistanceRoll(players[config.i_actionInitID].i_levels[0], players[config.i_actionRecvID].i_levels[0]) - getAdjustment(config.i_actionRecvID, MOD_SAVE) - tbl1->res[a][0];
							if (i >= j) {
								sprintf(mybuf1, "@B223@.Base Spell Attack Result = %d    SUCCESS (%d/%d)", tbl1->res[a][0], i, j);
							} else {
								sprintf(mybuf1, "@B95@.Base Spell Attack Result = %d    FAILURE (%d/%d)", tbl1->res[a][0], i, j);
							}
						}
						d1_ActionMessages->text(6, mybuf1);
					} else {
							// check if the attack tables returns a funble result
						if (tbl1->res[a][0] == -1) {
							doSystemAlert("Fumble !!!! Enter the fumble as a NEGATIVE attack roll");
							if (config.i_actionInitID > MAX_PLAYERS) {
								sprintf(mybuf2, "%d", getRND(100) * -1); d1_CombatResults[screen][0]->value(mybuf2);
							}
							return;
						}
						sprintf(mybuf2, "%d", tbl1->res[a][0]); d1_CombatResults[screen][0]->value(mybuf2);
					}
//printf("dDCA: %d:%d = %d\n", tbl1->res[a][0], tbl1->res[a][1], a);
					d1_CombatCritRoll[screen][0]->deactivate(); d1_CombatCrit[screen][0]->deactivate(); d1_CombatCalc[screen][1]->deactivate();
					d1_CombatCritRoll[screen][1]->deactivate(); d1_CombatCrit[screen][1]->deactivate(); d1_CombatCalc[screen][2]->deactivate();
//					d1_CombatCritTable[screen][0]->deactivate(); d1_CombatCritTable[screen][1]->deactivate();
					if (tbl1->res[a][1] != 0) {	// a crit
						d1_CombatCritRoll[screen][0]->activate();
						d1_CombatCrit[screen][0]->activate();
						d1_CombatCalc[screen][1]->activate();
						if (tbl1->res[a][1] == 'T') {
							d1_CombatCrit[screen][0]->value(6);
						} else {
							d1_CombatCrit[screen][0]->value(tbl1->res[a][1] - 64);
						}
						d1_CombatCritRoll[screen][1]->deactivate();
						d1_CombatCrit[screen][1]->deactivate();
						d1_CombatCalc[screen][2]->deactivate();
//						d1_CombatCritTable[screen][0]->activate(); d1_CombatCritTable[screen][1]->deactivate();
					}
				} else {
					roll = atoi(d1_CombatAttkRoll[screen]->value()) + atoi(d1_CombatOB[screen]->value()) - atoi(d1_CombatParry[screen][0]->value()) + atoi(d1_CombatMods[screen][0]->value()) + atoi(d1_CombatAdj[screen]->value()) - (atoi(d1_CombatParry[screen][1]->value()) + atoi(d1_CombatMods[screen][1]->value()) + atoi(d1_CombatMods[screen][3]->value()));
					getD100AttackRoll(atbl, roll, 0);
					if (d100AttkTbl != NULL) {
						tbl2 = (attk_tab2 *)d100AttkTbl;
						a = d1_CombatDefenderArmor->value(); if (a < 0) { a = 0; } if (a > 19) { a = 19; }
						sprintf(mybuf2, "%d", tbl2->res[a][0]); d1_CombatResults[screen][0]->value(mybuf2);
//printf("dDCA: %d:%d = %d\n", tbl2->res[a][0], tbl2->res[a][1], a);
						d1_CombatCritRoll[screen][0]->deactivate(); d1_CombatCrit[screen][0]->deactivate(); d1_CombatCalc[screen][1]->deactivate();
						d1_CombatCritRoll[screen][1]->deactivate(); d1_CombatCrit[screen][1]->deactivate(); d1_CombatCalc[screen][2]->deactivate();
//						d1_CombatCritTable[screen][0]->deactivate(); d1_CombatCritTable[screen][1]->deactivate();
						if (tbl2->res[a][1] != 0) {	// a crit
							d1_CombatCritRoll[screen][0]->activate();
							d1_CombatCrit[screen][0]->activate();
							d1_CombatCalc[screen][1]->activate();
							if (tbl2->res[a][1] == 'T') {
								d1_CombatCrit[screen][0]->value(6);
							} else {
								d1_CombatCrit[screen][0]->value(tbl2->res[a][1] - 64);
							}
							d1_CombatCritRoll[screen][1]->deactivate();
							d1_CombatCrit[screen][1]->deactivate();
							d1_CombatCalc[screen][2]->deactivate();
//							d1_CombatCritTable[screen][0]->activate(); d1_CombatCritTable[screen][1]->deactivate();
						}
					}
				}
				break;

		case 3:		// heal screen
				break;

		case 4:		// m&m screen				TODO
				roll = atoi(d1_CombatAttkRoll[screen]->value()) + atoi(d1_CombatOB[screen]->value()) + getAdjustment(config.i_actionInitID, MOD_MOVE) + atoi(d1_CombatMods[screen][0]->value()) - atoi(d1_CombatMods[screen][3]->value());
				if (roll > 350) { roll = 350; }
				a = d1_CombatMMDifficulty->value();
				if (a < 0) { break; }
//printf("Move: %d:%d\n", roll, a);
				if ((mtbl = (move_tab *)getD100Table("MM")) != NULL) {
					for (i=0; i<23; i++) {
						if (mtbl->st <= roll && mtbl->ed >= roll) {
							if (mtbl->res[a] > 0) {
								sprintf(mybuf2, "Completed %d%% of their action", mtbl->res[a]);
								d1_ActionMessages->text(5, mybuf2);
								break;
							} else {
								sprintf(mybuf2, "@B63@.Fumble !!!");
								d1_CombatAttkRoll[screen]->value("-1");
								d1_ActionMessages->text(5, mybuf2);
								break;
							}
						}
						mtbl++;
					}
				}
//printf("Diff = %d : %d. Roll = %d\n", d1_CombatMMDifficulty->value(), diff[d1_CombatMMDifficulty->value()], roll);
				roll += diff[d1_CombatMMDifficulty->value()];
				if (roll < -24) { sprintf(mybuf2, "@B171@.Static M&M: %s - Blunder (%d)", players[config.i_actionInitID].c_name, roll); }
				else if (roll < 5) { sprintf(mybuf2, "@B171@.Static M&M: %s - Absolute Failure (%d)", players[config.i_actionInitID].c_name, roll); }
				else if (roll < 76) { sprintf(mybuf2, "@B171@.Static M&M: %s - Failure (%d)", players[config.i_actionInitID].c_name, roll); }
				else if (roll < 91) { sprintf(mybuf2, "@B63@.Static M&M: %s - Partial Success (%d)", players[config.i_actionInitID].c_name, roll); }
				else if (roll < 111) { sprintf(mybuf2, "@B63@.Static M&M: %s - Near Success (%d)", players[config.i_actionInitID].c_name, roll); }
				else if (roll < 176) { sprintf(mybuf2, "@B63@.Static M&M: %s - Success (%d)", players[config.i_actionInitID].c_name, roll); }
				else { sprintf(mybuf2, "@B63@.Static M&M: %s - Absolute Success (%d)", players[config.i_actionInitID].c_name, roll); }
				d1_ActionMessages->text(6, mybuf2);
				d1_CombatAcceptAll[screen]->activate();
				break;
	}
}

/******************************************************************************/
void doD100CalcCritical(int screen, int line) {
char crt[4];
crit_tab *ctbl1;
crit_tab2 *ctbl2;
int i=0, roll=0;
int crtadj[] = {0, -20, -10, 0, 10, 20, -50};

//printf("dDCC: %d:%d = %d\n", screen, line, d1_CombatCrit[screen][line]->value());

	switch (screen) {
		case 0:		// melee screen
		case 1:		// spell screen
		case 2:		// missile screen
				crt[0] = 'C'; crt[2]=crt[3]='\0';
//				if (line == 0) { crt[1] = d100WeaponUsed.c_damage[0]; } else { crt[1] = d100WeaponUsed.c_critical[0]; }
				strncpy(&crt[1], d1_CombatCritTable[screen][line]->value(), 2);			// get the crit as marked on the screen
				crt[3]=crt[2]; crt[2]='\0'; 

				i = d1_CombatCrit[screen][line]->value();
				if (config.i_diceSystem == DICE_MERP) {
					roll = atoi(d1_CombatCritRoll[screen][line]->value()) + crtadj[i];		// adjust the roll by the crit value
				} else {
					roll = atoi(d1_CombatCritRoll[screen][line]->value());
				}
				getD100CriticalRoll(crt, roll, i+64);
				if (d100CritTbl != NULL) {
					if (config.i_diceSystem == DICE_MERP) {
						ctbl1 = (crit_tab *)d100CritTbl;
						if (line == 0) { sprintf(mybuf2, "@B63@.1st Crit: %s", ctbl1->msg); } else { sprintf(mybuf2, "@B63@.2nd Crit: %s", ctbl1->msg); }
						d1_ActionMessages->text(4+(line*2), mybuf2);
						for (i=0; i<8; i++) {
							sprintf(mybuf2, "%d", ctbl1->res[i] + atoi(d1_CombatResults[screen][i]->value())); 
							d1_CombatResults[screen][i]->value(mybuf2);
						}
						doD100WeaponParse(screen, ctbl1->spec_mods);
						sprintf(mybuf1, "Crit Mod = %s", ctbl1->spec_mods); d1_ActionMessages->text(5+(line*2), mybuf1);
					} else {
						ctbl2 = (crit_tab2 *)d100CritTbl;
						if (line == 0) { sprintf(mybuf2, "@B63@.1st Crit: %s", ctbl2->msg); } else { sprintf(mybuf2, "@B63@.2nd Crit: %s", ctbl2->msg); }
						d1_ActionMessages->text(6+(line*2), mybuf2);
						for (i=0; i<8; i++) {
							sprintf(mybuf2, "%d", ctbl2->res[i] + atoi(d1_CombatResults[screen][i]->value())); 
							d1_CombatResults[screen][i]->value(mybuf2);
						}
						doD100WeaponParse(screen, ctbl2->mods);
						sprintf(mybuf1, "Crit Mod = %s", ctbl2->mods); d1_ActionMessages->text(7+(line*2), mybuf1);
					}
				}
				if (line == 0 && isdigit(crt[3]) != 0) {		// max crit value ?
//printf("Max crit = %c\n", d100WeaponUsed.c_damage[1]);
					i = d100WeaponUsed.c_damage[1] - 'a' + 1;
					if (d1_CombatCrit[screen][0]->value() > i) {
						d1_CombatCrit[screen][0]->value(i);
					}
				}
				if (line == 0 && d1_CombatCrit[screen][line]->value() > 2 && d1_CombatCrit[screen][line]->value() != 6) {	// check for secondary crit but not if its a T crit
					if (strlen(d1_CombatCritTable[screen][1]->value()) > 0) {
							// adjust any TC.GR attacks based on the size of the monster
						if (strcasecmp(d100WeaponUsed.c_table, "TC") == 0 || strcasecmp(d100WeaponUsed.c_table, "GR") == 0) {
							if (config.i_actionInitID >= MAX_PLAYERS) {
								if (d100WeaponUsed.i_size > 1 || players[config.i_actionInitID].i_size > 2) {
									line += 0;	// dummy statement
								} else {			// no secondary crit
									break;
								}
							}
						}
						
//printf("Max crit = %c\n", d100WeaponUsed.c_critical[1]);
						strncpy(&crt[0], d1_CombatCritTable[screen][line]->value(), 2);	// get the crit as marked on the screen
						d1_CombatCritRoll[screen][1]->activate();
						d1_CombatCrit[screen][1]->activate();
							// monster TC.GR attacks, second crit only 1 step down not 2
						if ((strcasecmp(d100WeaponUsed.c_table, "TC") == 0 || strcasecmp(d100WeaponUsed.c_table, "GR") == 0) && config.i_actionInitID >= MAX_PLAYERS) {
							d1_CombatCrit[screen][1]->value(d1_CombatCrit[screen][0]->value() - 1);
						} else {
							d1_CombatCrit[screen][1]->value(d1_CombatCrit[screen][0]->value() - 2);
						}
						d1_CombatCalc[screen][2]->activate();
//						d1_CombatCritTable[screen][1]->activate();
						if (isdigit(crt[1]) != 0) {				// max crit value ?
							i = crt[1] - 'a' + 1;
							if (d1_CombatCrit[screen][1]->value() > i) {
								d1_CombatCrit[screen][1]->value(i);
							}
						}
					}
				}
				break;

		case 3:		// heal screen
				break;
	}
}

/******************************************************************************/
void doD100ActionModifiers(int screen, int modifier) {
int i=0, j=0, mod=0;
char mtext[4];
int spellchg[] = {-30, -15, 0, +10, +20};

//printf("dDAM: %d:%d\n", screen, modifier);

	switch (screen) {
		case 0:		// melee screen
		case 1:		// spell screen
		case 2:		// missile screen
					if (screen == 1) {
						mod = spellchg[players[config.i_actionInitID].i_roundsUntil[ROUND_SPELL_CHG]];
					}
					for (i=1; i <= d1_CombatModifiers[screen]->nitems(); i++) {
						strncpy(mtext, d1_CombatModifiers[screen]->text(i), 3); mtext[3] = '\0';
						j = d1_CombatModifiers[screen]->checked(i);
//printf("dDAM: %d: %s = %d\n", screen, mtext, j);
						if (j == 1) {
							if (strcasecmp(mtext, "Ins") == 0) {				// Instant spell
								// players[config.i_actionInitID].i_roundsUntil[ROUND_SPELL_CHG] = 2;
//printf("dDAM: reversing Spell Chrg mod %d\n", mod);
								mod = 0; // spellchg[players[config.i_actionInitID].i_roundsUntil[ROUND_SPELL_CHG]];
							} else if (strcasecmp(mtext, "Def") == 0) {		// Def: -AG bonus	TODO
								mod += 0;
							} else {
								mod += atoi(mtext);
							}
						}
					}
					// if (screen == 1) { mod += spellchg[players[config.i_actionInitID].i_roundsUntil[ROUND_SPELL_CHG]]; }
					sprintf(mybuf1, "%d", mod); d1_CombatMods[screen][0]->value(mybuf1);
					break;

		default:
					break;
	}
}

/******************************************************************************/
void doD100SpellSearch(const char *spell) {
spell_tab *st;
int i=0, j=0, k=0;

//printf("dDSS: %s\n", spell);

	i = strlen(spell);
	if ((st = (spell_tab *)getD100Table("XS")) != NULL) {
		d1_SpellSearchFound->clear(); d1_SpellSearchDetails->clear();
		while (st->realm_id != -1) {
			if (strncasecmp(st->spell_name, spell, i) == 0) {
				d1_SpellSearchFound->add(st->spell_name);
				config.i_idList[ID_SPELL][j++] = k;
			}
			st++; k++;
		}
	}
}

/******************************************************************************/
void doD100SpellSearchAction(int action, int spell) {
spell_tab *st;
int i=0, j=0;

	i = strlen(d1_SpellSearchFound->text(spell));

//printf("dDSSA: %d:%d:%s\n", action, spell, d1_SpellSearchFound->text(spell));

	switch(action) {
		case 0:	// spell selected, display details
				if ((st = (spell_tab *)getD100Table("XS")) != NULL) {
					d1_SpellSearchDetails->clear();
					i = d1_SpellSearchFound->value() - 1;
					i = config.i_idList[ID_SPELL][i];
					sprintf(mybuf2, " Name: %s", st[i].spell_name); d1_SpellSearchDetails->add(mybuf2);
					sprintf(mybuf2, " Level: %d", st[i].spell_lvl); d1_SpellSearchDetails->add(mybuf2);
					if (st[i].realm_id == 0) {
						d1_SpellSearchDetails->add(" Realm: Essence");
					} else {
						d1_SpellSearchDetails->add(" Realm: Channel");
					}
					sprintf(mybuf2, "   AoE: %s", st[i].spell_aoe); d1_SpellSearchDetails->add(mybuf2);
					sprintf(mybuf2, "    Dur: %s", st[i].spell_duration); d1_SpellSearchDetails->add(mybuf2);
					sprintf(mybuf2, "Range: %s", st[i].spell_range); d1_SpellSearchDetails->add(mybuf2);
					sprintf(mybuf2, "  Desc: %s", st[i].spell_desc); d1_SpellSearchDetails->add(mybuf2);
				}
				break;
	}
}

/******************************************************************************/
void doD100IgnoreAdjustment(int cd) {

if (config.flags.f_debug == 1) printf("dIA: %d \n", cd);

	if (players[cd].flags.f_ignoreBleed != 0) {		// No Bleeding
		d1_CombatResults[0][2]->value("0"); d1_CombatResults[1][2]->value("0");
		d1_CombatResults[2][2]->value("0"); d1_CombatResults[3][2]->value("0");
	}
	if (players[cd].flags.f_ignoreStun != 0) {		// No Stun
		d1_CombatResults[0][3]->value("0"); d1_CombatResults[1][3]->value("0");
		d1_CombatResults[2][3]->value("0"); d1_CombatResults[3][3]->value("0");
	}
}

/******************************************************************************/
void doD100CriticalAdjustment(int tile, int line, int cd) {
int i, j;

/*
	i = players[cd].CritAdj;
	j = actionsMeleeCrit1Result[line]->value();
if (config.flags.f_debug == 1) printf("dCA: %d (%d:%d/%d)\n", cd, line, i, j);
	switch (i) {
		case 1:		// -1
		case 2:		// -2
			if (line == 0) {
				if (j >= i) {
					actionsMeleeCrit1Result[line]->value(j-i);
				}
				if (j == 6) {	// T crit
					actionsMeleeCrit1Result[line]->value(0);
				}
			}
			break;
		case 3:		// Large
			j = actionsMeleeCrit1Result[tile]->value();
			if (j < 2 || j > 6) {		// Ignore A, T crits
			}
			break;
		case 4:		// SuperLarge
			j = actionsMeleeCrit1Result[tile]->value();
			if (j < 4 || j > 6) {		// Ignore A-C, T crits
			}
			break;
	}
*/
}

/******************************************************************************/
void doD100FumbleResult(int ca, int screen, int val) {
crit_tab *ctbl1;
crit_tab2 *ctbl2;
char ft[3] = {"FW"};
int mmf[] = {-50, -35, -20, -10, 0, 5, 10, 15, 20};

//printf("dDFR: %d = %d:%d\n", ca, screen, val);

	val *= -1;

	switch (screen) {
		case 0:			// melee
				if (strcasecmp(d100WeaponUsed.c_table, "1C") == 0) { val -= 20; }
				else if (strcasecmp(d100WeaponUsed.c_table, "1E") == 0) { val -= 10; }
				else if (strstr(d100WeaponUsed.c_description, "Spear") != NULL) { val += 10; }
				else if (strstr(d100WeaponUsed.c_description, "Javelin") != NULL) { val += 10; }
				else if (strstr(d100WeaponUsed.c_description, "Lance") != NULL) { val += 10; }
				else if (strstr(d100WeaponUsed.c_description, "Halbard") != NULL) { val += 10; }
				ft[1] = 'W';
				break;
		case 1:			// spell
				if (strcasecmp(d100WeaponUsed.c_table, "SA") == 0) { val += 20; }
				if (strstr(d100WeaponUsed.c_description, "Bolt") != NULL) { val += 20; }
				ft[1] = 'S';
				break;
		case 2:			// missile
				if (strcasecmp(d100WeaponUsed.c_description, "Sling") == 0) { val -= 20; }
				if (strcasecmp(d100WeaponUsed.c_description, "Short Bow") == 0) { val -= 10; }
				if (strcasecmp(d100WeaponUsed.c_description, "Long Bow") == 0) { val += 10; }
				if (strcasecmp(d100WeaponUsed.c_description, "Crossbow") == 0) { val += 20; }
				ft[1] = 'I';
				break;
		case 3:			// heal
				ft[1] = 'Z';
				break;
		case 4:			// move
				val += mmf[d1_CombatMMDifficulty->value()];
				ft[1] = 'M';
				break;
	}

//printf("dDFR: %d = %d:%d\n", ca, screen, val);

if (config.flags.f_debug == 1) printf("dFR: %d (%d/%d) %s\n", ca, screen, val, ft);
	getD100CriticalRoll(ft, val, ' ');
	if (d100CritTbl != NULL) {
		if (config.i_diceSystem == DICE_MERP) {
			ctbl1 = (crit_tab *) d100CritTbl;
if (config.flags.f_debug == 1) printf("FC: %d (%d/%d: %s)\n", val, ctbl1->st, ctbl1->ed, ctbl1->msg);
			sprintf(mybuf2, "@B95@.%s", ctbl1->msg); d1_ActionMessages->text(3, mybuf2);
			sprintf(mybuf2, "%d", ctbl1->res[0]); d1_CombatResults[screen][0]->value(mybuf2); // Hits
			sprintf(mybuf2, "%d", ctbl1->res[1]); d1_CombatResults[screen][1]->value(mybuf2); // Act. Pen
			sprintf(mybuf2, "%d", ctbl1->res[2]); d1_CombatResults[screen][2]->value(mybuf2); // Bleed
			sprintf(mybuf2, "%d", ctbl1->res[3]); d1_CombatResults[screen][3]->value(mybuf2); // Stun
			sprintf(mybuf2, "%d", ctbl1->res[4]); d1_CombatResults[screen][4]->value(mybuf2); // Parry
			sprintf(mybuf2, "%d", ctbl1->res[5]); d1_CombatResults[screen][5]->value(mybuf2); // No Parry
			sprintf(mybuf2, "%d", ctbl1->res[6]); d1_CombatResults[screen][6]->value(mybuf2); // Death
			sprintf(mybuf2, "%d", ctbl1->res[7]); d1_CombatResults[screen][7]->value(mybuf2); // Inactive
			doD100WeaponParse(screen, ctbl1->spec_mods);
		} else {
			ctbl2 = (crit_tab2 *) d100CritTbl;
if (config.flags.f_debug == 1) printf("FC: %d (%d/%d: %s)\n", val, ctbl2->st, ctbl2->ed, ctbl2->msg);
			sprintf(mybuf2, "@B95@.%s", ctbl2->msg); d1_ActionMessages->text(3, mybuf2);
			sprintf(mybuf2, "%d", ctbl2->res[0]); d1_CombatResults[screen][0]->value(mybuf2); // Hits
			sprintf(mybuf2, "%d", ctbl2->res[1]); d1_CombatResults[screen][1]->value(mybuf2); // Act. Pen
			sprintf(mybuf2, "%d", ctbl2->res[2]); d1_CombatResults[screen][2]->value(mybuf2); // Bleed
			sprintf(mybuf2, "%d", ctbl2->res[3]); d1_CombatResults[screen][3]->value(mybuf2); // Stun
			sprintf(mybuf2, "%d", ctbl2->res[4]); d1_CombatResults[screen][4]->value(mybuf2); // Parry
			sprintf(mybuf2, "%d", ctbl2->res[5]); d1_CombatResults[screen][5]->value(mybuf2); // No Parry
			sprintf(mybuf2, "%d", ctbl2->res[6]); d1_CombatResults[screen][6]->value(mybuf2); // Death
			sprintf(mybuf2, "%d", ctbl2->res[7]); d1_CombatResults[screen][7]->value(mybuf2); // Inactive
			doD100WeaponParse(screen, ctbl2->mods);
		}
		doD100IgnoreAdjustment(ca);
		return;
	}
}

/******************************************************************************/
void getD100AttackRoll(char *tbl, int roll, int um) {
attk_tab *tbl1;
attk_tab2 *tbl2;

if (config.flags.f_debug == 1) printf("gAR: %s = %d/%d/%d\n", tbl, roll, um, config.i_diceSystem);
//printf("gAR: %s = %d/%d/%d\n", tbl, roll, um, config.i_diceSystem);

//	if (roll > 150 && MEKSconfig.use_150 == 1) {
//		sprintf(mybuf2, "+150 Roll. Add +%d to 1st Crit Roll (%d)", (((roll-150)/25)+1)*5, roll);
//		doSystemAlert(mybuf2);
//	}

	roll = (roll < 1)?1:roll;
	roll = (roll > 150)?150:roll;
	d100AttkTbl = getD100Table(tbl);

	if (d100AttkTbl != NULL) {
		if (config.i_diceSystem == DICE_MERP) {
				// need to adjust based on SIZE of weapon for certain attack types
			if (strcasecmp(tbl, "TC") == 0 || strcasecmp(tbl, "GR") == 0) {
				if (d100WeaponUsed.i_size > 2 || players[config.i_actionInitID].i_size > 3) { 			// Huge etc
					if (roll > 150) { roll = 150; }
				} else if (d100WeaponUsed.i_size == 2 || players[config.i_actionInitID].i_size == 3) { // Large
					if (roll > 135) { roll = 135; }
				} else if (d100WeaponUsed.i_size == 1 || players[config.i_actionInitID].i_size == 2) { // Medium
					if (roll > 120) { roll = 120; }
				} else if (d100WeaponUsed.i_size == 0 || players[config.i_actionInitID].i_size == 1) { // Small
					if (roll > 105) { roll = 105; }
				} else if (players[config.i_actionInitID].i_size == 0) { 		// Tiny
					if (roll > 85) { roll = 85; }
				}
// printf("Adjusting %s attack . roll = %d (%d)\n", d100AttkTbl, roll, d100WeaponUsed.i_size);
			}

			tbl1 = (attk_tab *)d100AttkTbl;
			for (int i=0; i<28; i++) {
				if (tbl1->st <= roll && tbl1->ed >= roll) {
					if (tbl1->um_flag == um) { 
if (config.flags.f_debug == 1) printf("gAR: %d:%d:%d:%d:%d\n", tbl1->res[0][0],tbl1->res[1][0],tbl1->res[2][0],tbl1->res[3][0],tbl1->res[4][0]);
						d100AttkTbl = (char *)tbl1;
						return;
					}
				}
				if (tbl1->ed >= 250) {
					d100AttkTbl = NULL;
					return;
				}
				tbl1++;
			}
		} else {
			tbl2 = (attk_tab2 *)d100AttkTbl;
			for (int i=0; i<136; i++) {
				if (tbl2->st <= roll && tbl2->ed >= roll) {
if (config.flags.f_debug == 1) printf("gAR: %d:%d:%d:%d:%d\n", tbl2->res[0][0],tbl2->res[1][0],tbl2->res[2][0],tbl2->res[3][0],tbl2->res[4][0]);
					d100AttkTbl = (char *)tbl2;
					return;
				}
				if (tbl2->st == 1) { break; }		// reached the end
				tbl2++;
			}
		}
	}

	d100AttkTbl = NULL;
	return;
}

/******************************************************************************/
void getD100CriticalRoll(char *tbl, int roll, char crit) {
crit_tab *tbl1;
crit_tab2 *tbl2;
char *tbl_crit;
int i, j;

if (config.flags.f_debug == 1) printf("gDCR: %s = %d:%c\n", tbl, roll, crit);
//printf("gDCR: %s = %d:%c\n", tbl, roll, crit);

	roll = (roll < 1)?1:roll;
	roll = (roll > 120)?120:roll;
	tbl_crit = getD100Table(tbl);
	d100CritTbl = NULL;

	if (tbl_crit != NULL) {
		if (config.i_diceSystem == DICE_MERP) {
			tbl1 = (crit_tab *)tbl_crit;
			for (i=0; i<19; i++) {
				if (tbl1->st <= roll && tbl1->ed >= roll) {
if (config.flags.f_debug == 1) printf("gDCR: %d:%d:%d:%d:%d\n", tbl1->res[0],tbl1->res[1],tbl1->res[2],tbl1->res[3],tbl1->res[4]);
					d100CritTbl = (char *)tbl1;
					return;
				}
				tbl1++;
			}
		} else if (config.i_diceSystem == DICE_RMS) {
			tbl2 = (crit_tab2 *)tbl_crit;
			for (i=0; i<95; i++) {
				if (tbl2->st <= roll && tbl2->ed >= roll && tbl2->crit == crit) {
if (config.flags.f_debug == 1) printf("gDCR: %d:%d:%d:%d:%d\n", tbl2->res[0],tbl2->res[1],tbl2->res[2],tbl2->res[3],tbl2->res[4]);
					d100CritTbl = (char *)tbl2;
					return;
				}
				if (tbl2->ed == 350 && tbl2->crit == 'E') { break; }		// reached the end
				tbl2++;
			}
		}
	}

	d100CritTbl = NULL;

	return;
}

/******************************************************************************/
int getD100RRValue(int atk_lvl, int def, int def_lvl, unsigned char type) {
int rr=0;

	if (def_lvl > 15)
	  rr = 15 - def_lvl;
	else if (def_lvl > 10)
	  rr = 15 - ((def_lvl - 10) * 2);
	else if (def_lvl > 5)
	  rr = 30 - ((def_lvl - 5) * 3);
	else if (def_lvl > 1)
	  rr = 50 - ((def_lvl - 1) * 5);
	else
	  rr = 50;
	
	if (atk_lvl > 15)
	  rr += 50 + (atk_lvl-15);
	else if (atk_lvl > 10)
	  rr += 35 + ((atk_lvl - 10) * 2);
	else if (atk_lvl > 5)
	  rr += 20 + ((atk_lvl - 5) * 3);
	else if (atk_lvl > 1)
	  rr += (atk_lvl - 1) * 5;

	if (atk_lvl == def_lvl)
	  rr = 50;

	switch (type)
	{
		case 1:
	   case 'E': rr -= players[def].i_savingThrows[SAVE_ESSENCE];
		     break;
		case 0:
	   case 'F':		/* Fear is a channeling RR */
	   case 'C': rr -= players[def].i_savingThrows[SAVE_CHANNEL];
		     break;
		case 2:
	   case 'M': rr -= players[def].i_savingThrows[SAVE_MENTAL];
		     break;
	   case 'P': rr -= players[def].i_savingThrows[SAVE_POISON];
		     break;
	   case 'D': rr -= players[def].i_savingThrows[SAVE_DISEASE];
		     break;
	}
	rr -= getAdjustment(def, MOD_SAVE);

if (config.flags.f_debug == 1) printf("gRRV: %d:%d:%c = %d\n", atk_lvl, def_lvl, type, rr);

	return(rr);
}

/******************************************************************************/
int getD100StatBonus(int val) {
	if (val > 101) return +35;
	else if (val > 100) return +30;
	else if (val > 99) return +25;
	else if (val > 97) return +20;
	else if (val > 94) return +15;
	else if (val > 89) return +10;
	else if (val > 74) return +5;
	else if (val > 24) return +0;
	else if (val > 9) return -5;
	else if (val > 4) return -10;
	else if (val > 2) return -15;
	else if (val == 2) return -20;

	return -25;
}

/******************************************************************************/
int getD100DiceRoll() {
int val=0, i;

   val = i = getRND(100);
   while (i > 95) {
      i = getRND(100);
      val += i;
   }
   return val;
}

/******************************************************************************/
int doIconKeyPressed(int action) {
int event = Fl::event();

printf("Event: A=%d E=%d B=%d S=%d X=%d Y=%d\n", action, event, Fl::event_button(), Fl::event_state(), Fl::event_x(), Fl::event_y());

	return 0;
}

/******************************************************************************/
void doAdvantageRoll(int val) {		// 0 = Ad, 1 = Dis
	int i, j;
   i = getRND(20);
   j = getRND(20);

	sprintf(mybuf2, "%d", j);

	if (val == 0) {
		if (i > j) { sprintf(mybuf2, "%d", i); }
	} else {
		if (i < j) { sprintf(mybuf2, "%d", i); }
	}

	a_CTMeleeRoll->value(mybuf2);
}

/******************************************************************************/
int doD100WeaponToken() {
	return 0;
}

/******************************************************************************/
void doD100WeaponParse(int screen, char *msg) {
char token[6], *ptr, *tptr, stoken[80], *elsetoken;
int i=0, j=0;
int whomEffects, condit = 0, condition[3] = {1,1,1};

	if (strlen(msg) < 1) {
			return;
	}
	strcpy(stoken, msg);

	ptr = &stoken[0];
	whomEffects = config.i_actionRecvID;

	d1_CombatAdj[0]->value("0"); d1_CombatAdj[1]->value("0"); d1_CombatAdj[2]->value("0");

printf("dDWP: %s\n", stoken);

	elsetoken = strstr(ptr, "EL");

	if (strstr(ptr, "CH OR PL") != NULL) {
		tptr = strstr(ptr, "EL");
			// they are wearing CH or PL
		if (players[whomEffects].i_armorClassSplit[AC_SECTION_WORN] == 3 || players[whomEffects].i_armorClassSplit[AC_SECTION_WORN] == 4) {
			if (tptr != NULL) { *tptr = '\0'; }
			tptr = strstr(ptr, "OB");
			j = atoi(&tptr[2]);
		} else {
			if (tptr != NULL) { tptr = strstr(tptr, "OB"); j = atoi(&tptr[2]); }
		}
		sprintf(mybuf1, "%d", j); d1_CombatAdj[0]->value(mybuf1); d1_CombatAdj[1]->value(mybuf1); d1_CombatAdj[2]->value(mybuf1);
printf("dDWP: OB token %s = %d\n", ptr, j);
		return;
	}

	if (strstr(ptr, "AK OB") != NULL) {
		tptr = strstr(ptr, "OB");
		j = atoi(&tptr[2]);
		sprintf(mybuf1, "%d", j); d1_CombatAdj[0]->value(mybuf1); d1_CombatAdj[1]->value(mybuf1); d1_CombatAdj[2]->value(mybuf1);
printf("dDWP: OB token %s = %d\n", ptr, j);
		return;
	}

	if (strstr(ptr, "IF HA") != NULL) {
		if (players[whomEffects].i_armorClassSplit[AC_SECTION_HELM] != 0) {
				// end at the EL and move to the adjustments
			if (elsetoken != NULL) { *elsetoken = '\0'; }
			ptr = &ptr[6];
		} else {
			if (elsetoken != NULL) {
				ptr = elsetoken; ptr++; ptr++; ptr++;
			} else {
				return;
			}
		}
	}
	if (strstr(ptr, "IN HA") != NULL) {
		if (players[whomEffects].i_armorClassSplit[AC_SECTION_HELM] == 0) {
				// no HELM, check for EL otherwise return
			if (elsetoken != NULL) {
				ptr = elsetoken; ptr++; ptr++; ptr++;
			} else {
				return;
			}
		} else {
				// have HELM end at the EL and move to the adjustments
			if (elsetoken != NULL) { *elsetoken = '\0'; }
			ptr = &ptr[6];
		}
	}
	if (strstr(ptr, "IN LA") != NULL) {
		if (players[whomEffects].i_armorClassSplit[AC_SECTION_LEG] == 0) {
				// no LA, check for EL otherwise return
			if (elsetoken != NULL) {
				ptr = elsetoken; ptr++; ptr++; ptr++;
			} else {
				return;
			}
		} else {
				// have LA end at the EL and move to the adjustments
			if (elsetoken != NULL) { *elsetoken = '\0'; }
			ptr = &ptr[6];
		}
	}
	if (strstr(ptr, "IN PL") != NULL) {
		if (players[whomEffects].i_armorClassSplit[AC_SECTION_WORN] != 4) {
				// no PL, check for EL otherwise return
			if (elsetoken != NULL) {
				ptr = elsetoken; ptr++; ptr++; ptr++;
			} else {
				return;
			}
		} else {
				// have PL end at the EL and move to the adjustments
			if (elsetoken != NULL) { *elsetoken = '\0'; }
			ptr = &ptr[6];
		}
	}
	if (strstr(ptr, "IN SD") != NULL) {
		if (players[whomEffects].i_armorClassSplit[AC_SECTION_SHIELD] == 0) {
				// no SHIELD, check for EL otherwise return
			if (elsetoken != NULL) {
				ptr = elsetoken; ptr++; ptr++; ptr++;
			} else {
				return;
			}
		} else {
				// have SHIELD end at the EL and move to the adjustments
			if (elsetoken != NULL) { *elsetoken = '\0'; }
			ptr = &ptr[6];
		}
	}
	if (strstr(ptr, "IN NO OR SL") != NULL) {
		if (players[whomEffects].i_armorClassSplit[AC_SECTION_WORN] != 0 || players[whomEffects].i_armorClassSplit[AC_SECTION_WORN] != 1) {
				// no NO/SL, check for EL otherwise return
			if (elsetoken != NULL) {
				ptr = elsetoken; ptr++; ptr++; ptr++;
			} else {
				return;
			}
		} else {
				// have NO/SL end at the EL and move to the adjustments
			if (elsetoken != NULL) { *elsetoken = '\0'; }
			ptr = &ptr[6];
		}
	}
	if (strstr(ptr, "PL OR CH") != NULL) {
		if (players[whomEffects].i_armorClassSplit[AC_SECTION_WORN] == 4 || players[whomEffects].i_armorClassSplit[AC_SECTION_WORN] == 3) {
				// wearing CH/PL, end at EL and move to adjustments
			if (elsetoken != NULL) { *elsetoken = '\0'; }
			ptr = &ptr[6];
		} else {
			if (elsetoken != NULL) {
				ptr = elsetoken; ptr++; ptr++; ptr++;
			} else {
				return;
			}
		}
	}

	while (1 == 1) {
		tptr = strstr(ptr, " ");
		if (tptr != NULL) { *tptr = '\0'; }
printf("dDWP: %s\n", ptr);
		if (strncasecmp(ptr, "NO", 2) == 0) {			// no armor
			if (players[whomEffects].i_armorClassSplit[AC_SECTION_WORN] == 0) {
printf("dDWP: %d has NO\n", whomEffects);
				condition[i++] = 1;
			}
		} else if (strncasecmp(ptr, "SL", 2) == 0) {			// soft leather armor
			if (players[whomEffects].i_armorClassSplit[AC_SECTION_WORN] == 1) {
printf("dDWP: %d has SL\n", whomEffects);
				condition[i++] = 1;
			}
		} else if (strncasecmp(ptr, "RL", 2) == 0) {			// rigid leather armor
			if (players[whomEffects].i_armorClassSplit[AC_SECTION_WORN] == 2) {
printf("dDWP: %d has RL\n", whomEffects);
				condition[i++] = 1;
			}
		} else if (strncasecmp(ptr, "CH", 2) == 0) {			// chain armor
			if (players[whomEffects].i_armorClassSplit[AC_SECTION_WORN] == 3) {
printf("dDWP: %d has CH\n", whomEffects);
				condition[i++] = 1;
			}
		} else if (strncasecmp(ptr, "PL", 2) == 0) {		// plate armor
			if (players[whomEffects].i_armorClassSplit[AC_SECTION_WORN] == 4) {
printf("dDWP: %d has PL\n", whomEffects);
				condition[i++] = 1;
			}
		} else if (strncasecmp(ptr, "OR", 2) == 0) {		// or
			ptr = tptr; ptr++; tptr = strstr(ptr, " "); if (tptr != NULL) { *tptr = '\0'; }
		} else if (strncasecmp(ptr, "EL", 2) == 0) {		// else
			if (condition[0] == 1 || condition[1] == 1) {
			} else {
			}
		} else if (strncasecmp(ptr, "AK", 2) == 0) {		// applies to attacker
			whomEffects = config.i_actionInitID;
		} else if (strncasecmp(ptr, "OB", 2) == 0) {		// OB adjustment
			j = atoi(&ptr[2]);
			sprintf(mybuf1, "%d", j); d1_CombatAdj[0]->value(mybuf1); d1_CombatAdj[1]->value(mybuf1); d1_CombatAdj[2]->value(mybuf1);
printf("dDWP: OB token %s = %d\n", ptr, j);
		} else if (strncasecmp(ptr, "IN", 2) == 0) {		// if no
			tptr = strstr(ptr, " "); if (tptr != NULL) { *tptr = '\0'; }
// check the next token to see if the condition is true or not
			if (strncasecmp(ptr, "HA", 2) == 0) {
				if (players[whomEffects].i_armorClassSplit[AC_SECTION_HELM] == 0) {		// 0 = None, 1 = Lthr, 2 = Metal
					condition[i++] = 1;
				}
			} else if (strncasecmp(ptr, "LA", 2) == 0) {		// leg armor
				if (players[whomEffects].i_armorClassSplit[AC_SECTION_LEG] == 0) {		// 0 = None, 1 = Lthr, 2 = Metal
					condition[i++] = 1;
				}
			} else if (strncasecmp(ptr, "SD", 2) == 0) {		// shield
				if (players[whomEffects].i_armorClassSplit[AC_SECTION_SHIELD] == 0) {	// 0 = None
					condition[i++] = 1;
				}
			} else if (strncasecmp(ptr, "NO", 2) == 0) {		// no armor
				if (players[whomEffects].i_armorClassSplit[AC_SECTION_WORN] != 0) {
					condition[i++] = 1;
				}
			} else if (strncasecmp(ptr, "SL", 2) == 0) {		// soft leather armor
				if (players[whomEffects].i_armorClassSplit[AC_SECTION_WORN] != 1) {
					condition[i++] = 1;
				}
			} else if (strncasecmp(ptr, "RL", 2) == 0) {		// rigid leather armor
				if (players[whomEffects].i_armorClassSplit[AC_SECTION_WORN] != 2) {
					condition[i++] = 1;
				}
			} else if (strncasecmp(ptr, "CH", 2) == 0) {		// chain armor
				if (players[whomEffects].i_armorClassSplit[AC_SECTION_WORN] != 3) {
					condition[i++] = 1;
				}
			} else if (strncasecmp(ptr, "PL", 2) == 0) {		// plate armor
				if (players[whomEffects].i_armorClassSplit[AC_SECTION_WORN] != 4) {
					condition[i++] = 1;
				}
			}
		} else if (strncasecmp(ptr, "HA", 2) == 0) {
		} else if (strncasecmp(ptr, "LA", 2) == 0) {		// leg armor
		} else if (strncasecmp(ptr, "BL", 2) == 0) {		// bleeding
			j = atoi(&ptr[2]) + atoi(d1_CombatResults[screen][2]->value()); 
			sprintf(mybuf1, "%d", j); d1_CombatResults[screen][2]->value(mybuf1);
		} else if (strncasecmp(ptr, "HT", 2) == 0) {		// HP damage could be HT+8 or HT+8:2
			j = atoi(&ptr[2]) + atoi(d1_CombatResults[screen][0]->value()); 
			sprintf(mybuf1, "%d", j); d1_CombatResults[screen][0]->value(mybuf1); 
		} else if (strncasecmp(ptr, "DD", 2) == 0) {		// death in
			j = atoi(&ptr[2]) + atoi(d1_CombatResults[screen][6]->value()); 
			sprintf(mybuf1, "%d", j); d1_CombatResults[screen][6]->value(mybuf1); 
		} else if (strncasecmp(ptr, "SD", 2) == 0) {		// shield
		} else if (strncasecmp(ptr, "ST", 2) == 0) {		// stun
			j = atoi(&ptr[2]) + atoi(d1_CombatResults[screen][3]->value());
			sprintf(mybuf1, "%d", j); d1_CombatResults[screen][3]->value(mybuf1); 
		} else if (strncasecmp(ptr, "AP", 2) == 0) {		// activity penalty could be AP+30 or AP+30:2
			if ((tptr = strstr(ptr, ":")) != NULL) {
				*tptr = '\0';
			}
			j = atoi(&ptr[2]) + atoi(d1_CombatResults[screen][1]->value()); 
			sprintf(mybuf1, "%d", j); d1_CombatResults[screen][1]->value(mybuf1);
		} else if (strncasecmp(ptr, "IA", 2) == 0) {		// inactivity
			j = atoi(&ptr[2]) + atoi(d1_CombatResults[screen][7]->value());
			sprintf(mybuf1, "%d", j); d1_CombatResults[screen][7]->value(mybuf1); 
		} else {
printf("dDWP: Unknown token %s\n", ptr);
		}
		ptr = tptr; ptr++;
		if (tptr == NULL) { break; }
	}
	return;
}

/************************************
d1_CombatAdj[scrn] // OB adjustment

d1_CombatResults[scrn][0] // HP
d1_CombatResults[scrn][1] // APen
d1_CombatResults[scrn][2] // Bleed
d1_CombatResults[scrn][3] // Stun
d1_CombatResults[scrn][4] // Parry
d1_CombatResults[scrn][5] // NoParry
d1_CombatResults[scrn][6] // Death
d1_CombatResults[scrn][7] // Inact

d1_CombatMods[scrn][0] // OB
d1_CombatMods[scrn][1] // DB
d1_CombatMods[scrn][2] // Damage
d1_CombatMods[scrn][3] // APen
************************************/

int rrVal[16][16] = {
{1,55,60,65,70,75,78,81,84,87,90,92,94,96,98,100},
{1,50,55,60,65,70,73,76,79,82,85,87,89,91,93,95},
{1,45,50,55,60,65,68,71,74,77,80,82,84,86,88,90},
{1,40,45,50,55,60,63,66,69,72,75,77,79,81,83,85},
{1,35,40,45,50,55,58,61,64,67,70,72,74,76,78,80},
{1,30,35,40,45,50,53,56,59,62,65,67,69,71,73,75},
{1,27,32,37,42,47,50,53,56,59,62,64,66,68,70,72},
{1,24,29,34,39,44,47,50,53,56,59,61,63,65,67,69},
{1,21,26,31,36,41,44,47,50,53,56,58,60,62,64,66},
{1,18,23,28,33,38,41,44,47,50,53,55,57,59,61,63},
{1,15,20,25,30,35,38,41,44,47,50,52,54,56,58,60},
{1,13,18,23,28,33,36,39,42,45,48,50,52,54,56,58},
{1,11,16,21,26,31,34,37,40,43,46,48,50,52,54,56},
{1,9,14,19,24,29,32,35,38,41,44,46,48,50,52,54},
{1,7,12,17,22,27,30,33,36,39,42,44,46,48,50,52},
{1,5,10,15,20,25,28,31,34,37,40,42,44,46,48,50}};

/******************************************************************************/
int getD100ResistanceRoll(int alvl, int dlvl) {
	if (alvl > 15) { alvl = 15; }
	if (dlvl > 15) { dlvl = 15; }
//printf("gDRR: %d %d\n", alvl, dlvl);
	return rrVal[dlvl][alvl];
}

/******************************************************************************/
int getStatBonus(int b) {
	if (b > 101) { return 35; } else
	if (b == 101) { return 30; } else
	if (b == 100) { return 25; } else
	if (b > 97) { return 20; } else
	if (b > 94) { return 15; } else
	if (b > 89) { return 10; } else
	if (b > 74) { return 5; } else
	if (b > 24) { return 0; } else
	if (b > 9) { return -5; } else
	if (b > 4) { return -10; } else
	if (b > 2) { return -15; } else
	if (b == 2) { return -20; } else { return -25; }
}

/******************************************************************************/

