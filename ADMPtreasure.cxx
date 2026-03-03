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
// ********************************************************************************
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#ifndef VISUALC
#include <strings.h>
#endif
#include <ctype.h>

#include <FL/Fl.H>
#include <FL/Fl_Input.H>
#include <FL/Fl_Output.H>
#include <FL/Fl_Choice.H>
#include <FL/Fl_Check_Button.H>
#include <FL/Fl_Browser.H>
#include <FL/Fl_Text_Editor.H>
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
#include <FL/Fl_Progress.H>

#include "ADMPdata.h"
#include "ADMPexternals.h"

// ********************************************************************************
extern ADMPsystem config;
extern ADMPplayer  players[MAX_MEMBERS+2], qkmonsters[MAX_QKMONSTERS+2];

extern Fl_Text_Buffer *treasure_buffer[2];

// ********************************************************************************
unsigned char rndTreasureTbl[20][4] = {
	{1,34,35,36},
	{2,40,41,42},
	{3,43,44,45},
	{4,46,47,48},
	{5,49,50,51},
	{6,52,53,54},
	{7,55,56,57},
	{8,58,59,60},
	{9,61,62,63},
	{10,4,5,6},
	{11,7,8,9},
	{12,10,11,12},
	{13,13,14,15},
	{14,16,17,18},
	{15,19,20,21},
	{16,22,23,24},
	{17,25,26,27},
	{18,28,29,30},
	{19,31,32,33},
	{20,37,38,39}};

// ********************************************************************************
//typedef struct treasureTblData {
//	unsigned char table_id, start_roll, end_roll;
//	char *data;
//} treasureTblData;

treasureTblData rndTreasureTblData[] = {
{34,1,14, "Nothing"},
{255,1,1, "none"}};

// ********************************************************************************
extern int getRND(int );
extern int parseDice(char *);

// ********************************************************************************
int findTreasureLine(int tbl, int roll) {
	int i;

//printf("fTL: %d %d\n", tbl, roll);
	i = -1;
	while (rndTreasureTblData[++i].table_id != 255) {
//if (config.flags.f_debug != 0) { printf("gRT: %d:%d\n", tbl, rndTreasureTblData[i].table_id); }
		if (rndTreasureTblData[i].table_id == tbl) {
// printf("fTL: %d %d %s\n", tbl, roll, rndTreasureTblData[i].data);
			if (roll >= rndTreasureTblData[i].start_roll && roll <= rndTreasureTblData[i].end_roll) {
				return(i);
			}
			if (rndTreasureTblData[i].start_roll > roll) {
				return(i-1);
			}
		}
	}
	return (-1);
}

// ********************************************************************************
void parseTreasureData(int line, int lvl, Fl_Text_Display *br) {
	char *token[15], data[100], strng[200], spaces[] = {"                   "}, buf[100];
	int tbl, dice=1, i, prevtoken=0, tkn=1;

	strcpy(data, rndTreasureTblData[line].data);
	token[0] = strtok(data, "|");
	while ((token[tkn] = strtok(NULL, "|")) != NULL && tkn < 15) {
		tkn++;
	}
	token[tkn] = NULL;
	tkn = 0;
	buf[0] = '\0';

	do {
//printf("Token = %s\n", token[tkn]);
		token[14] = strchr(token[tkn], 'd');
		if (strcmp(token[tkn], "cp") == 0 || strcmp(token[tkn], "sp") == 0 || strcmp(token[tkn], "gp") == 0 || strcmp(token[tkn], "pp") == 0) {
			tkn++;		// a dice string
			if ((token[13] = strstr(token[tkn], "x")) != NULL) {
				*token[13] = '\0';
				dice = parseDice(token[tkn]) * atoi(token[13]+1);
			} else {
				dice = parseDice(token[tkn]);
			}
			spaces[lvl] = '\0';
			sprintf(buf, "%s%d %s", spaces, dice, token[tkn-1]);
			br->buffer()->append(buf); br->buffer()->append("\n");
			spaces[lvl] = ' ';
			dice = 1;
			buf[0] = '\0';
			prevtoken=1;
		} else if (strncmp(token[tkn], "t#", 2) == 0) {		// found a table pointer token
			tbl = atoi(&token[tkn][2]);
//printf("Table Token = %s %d:%d %s\n", token[0], tbl, dice, token[4]);
			if (tbl > 0 && tbl < 175) {
				if (prevtoken != 3) {
					spaces[lvl] = '\0';
					sprintf(strng, "%s%s", spaces, buf);
					if (strstr(buf, "arcane") == NULL && strstr(buf, "divine") == NULL && strlen(buf) > 1) {
						br->buffer()->append(strng); br->buffer()->append("\n");
					}
					spaces[lvl] = ' ';
				}
				for (int j = 0; j<dice; j++) {
					if ((i = findTreasureLine(tbl, getRND(100))) != -1) {
						parseTreasureData(i, lvl+2, br);
					}
				}
			}
//printf("1: %s\n", buf);
			buf[0] = '\0';
			prevtoken=2;
		} else if (token[14] != NULL && isdigit(*(token[14]-1)) && isdigit(*(token[14]+1))) {	// found a dice string
//printf("Dice Token = %s", token[0]);
			dice = 1;
			if (tbl < 64 || tbl > 71) {		// handle Gems and Art-work differently
				if ((token[14] = strstr(token[tkn], "x")) != NULL) {
					*token[14] = '\0';
					dice = parseDice(token[tkn]);
					sprintf(buf, "%d x%s", dice, ++token[14]);
				} else {
					strcat(buf, token[tkn]);
				}
				strcat(buf, "gp ");
			} else {
				if ((token[14] = strstr(token[tkn], "x")) != NULL) {
					*token[14] = '\0';
					dice = parseDice(token[tkn]) * atoi(token[14]+1);
				} else {
					dice = parseDice(token[tkn]);
				}
			}
//printf(" (%d) %s\n", dice, buf);
			prevtoken=3;
		} else {
			sprintf(strng, "%s ", token[tkn]);
			strcat(buf, strng);
			prevtoken=4;
		}
//		token[4] = token[0];		// make a backup just incase
	} while (token[++tkn] != NULL);
//printf("Token = %s Lvl = %d\n", token[0], lvl);

	if (strlen(buf) > 1) {		// print the final description string
		spaces[lvl] = '\0';
		sprintf(strng, "%s%s", spaces, buf);
		if (strstr(buf, "arcane") == NULL && strstr(buf, "divine") == NULL && strlen(buf) > 1) {
			br->buffer()->append(strng); br->buffer()->append("\n");
		}
//printf("2: %s\n", buf);
	}
}

// ********************************************************************************
void generateRndTreasure() {
	int i, rnd;
	int el, goods, money, items;

	el = (int )aRT_ELLevel->value() - 1;
	goods = 100; //(int )aRT_Goods->value();
	money = 100; //(int )aRT_Money->value();
	items = 100; //(int )aRT_Items->value();
//if (config.flags.f_debug != 0) { printf("gRT: %d:%d:%d:%d\n", el, money, goods, items); }

	treasure_buffer[0]->select(0, treasure_buffer[0]->length());
	treasure_buffer[0]->remove_selection();


rnd = getRND(100);
printf("\nMoney: %d\n", rnd);
	if ((i = findTreasureLine(rndTreasureTbl[el][1], rnd)) != -1) {
		aRT_Treasure->buffer()->append("   Money:\n");
		parseTreasureData(i, 0, aRT_Treasure);
		aRT_Treasure->buffer()->append("\n");
	} else {
		printf("Unable to find Money Line\n");
	}

rnd = getRND(100);
printf("\nGoods: %d\n", rnd);
	if ((i = findTreasureLine(rndTreasureTbl[el][2], rnd)) != -1) {
		aRT_Treasure->buffer()->append("   Goods:\n");
		parseTreasureData(i, 0, aRT_Treasure);
		aRT_Treasure->buffer()->append("\n"); 
	} else {
		printf("Unable to find Goods Line\n");
	}

rnd = getRND(100);
printf("\nItems: %d\n", rnd);
//	if ((i = findTreasureLine(162,100)) != -1) {
	if ((i = findTreasureLine(rndTreasureTbl[el][3], rnd)) != -1) {
		aRT_Treasure->buffer()->append("   Items:\n");
		parseTreasureData(i, 0, aRT_Treasure);
		aRT_Treasure->buffer()->append("\n");
	} else {
		printf("Unable to find Items Line\n");
	}
}
