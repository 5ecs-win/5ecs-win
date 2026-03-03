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
 * #####################################################################
 **********************************************************************/

typedef unsigned char uchar;
typedef unsigned short int myuint;

/**********************************************************************/
typedef struct gridDataPoint {
	uchar i_color; 			// current background color (32)
   myuint i_id:10; 			// the ID of the object/player/monster (1024)
	uchar i_type:3;			// 0=none/wall, 2=player, 3=monster, 1=object, 4=background (7)
	uchar f_viewed:1;			// viewed or not
	uchar f_shadow:1;			// object/map/player shadow
	uchar f_hidden:1;			// is it hidden
} gridDataPoint;

typedef struct gridPoint {
	gridDataPoint lvl0;
	gridDataPoint lvl1;
	gridDataPoint lvl2;
	gridDataPoint lvl3;
} gridPoint;

typedef struct losPoint {
	uchar i_color;        // current background color - 16 slots
   uchar i_type:4;     // is it an object like a trap/note. 0=none/wall, 2=player, 3=monster, 1=object
   uchar f_viewed:1;      // has it been viewed
   myuint i_id;      		  // the ID of the object/player/monster (256)
} losPoint;
