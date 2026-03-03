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

#include <stdlib.h>
#include <string.h>

#include <stdio.h>
#include <FL/Fl.H>
#include <FL/fl_draw.H>
#include <FL/Fl_Anim_GIF_Image.H>

#include "5eCSdefines.h"
#include "gridTile.h"

void gridTile::draw() {
	int sx=0, sy=0, wid=0, hei=0, gx=0, gy=0, mx=0, my=0, i=0, j=0, nx=0, ny=0, pos=0, drawme=0, osize=0, ix=0, iy=0;
	int p_type, p_id, p_color, p_shadow, p_hidden, p_viewed, p_pviewed, p_pcolor, p_phidden, p_pshadow, p_ptype, p_pid;
	time_t currentTime;

	int xpos=0, ypos=0, xinc=0, yinc=0, ninit=0;

	if (doAnimation == 1) { doAnimations(); doAnimation = 0; return; }

	char text[20];
	Fl_Image *resizedIcon=NULL, *background=NULL, *currentIcon=NULL;
	
	Fl_Anim_GIF_Image *gifIcon=NULL;

	if (gridTopX < 0) { gridTopX = 0; }
	if (gridTopY < 0) { gridTopY = 0; }

//printf("in gridTile::draw (%d: GW:%d GH:%d TX:%d TY:%d)\n", gridType,gridWidth,gridHeight,gridTopX,gridTopY);

	sx = x(); sy = y();
	if (gridType == 1) { sx = 30; sy = 31; }
	wid = w(); hei = h();
	nx = wid/gridSize; ny = hei/gridSize;
//printf("in gridTile::draw (%d: %d/%d %d/%d)\n", gridType, sx, sy, wid, hei);

	fl_color(colorMap[0]); fl_rectf(sx,sy,wid, hei);

//printf("in gridTile::draw visible = %d\n", visible());

	if (playerData != NULL) { for (i=0; i < MAX_MEMBERS; i++) { playerData[i].flags.f_displayed = 0; } }

	for (i=0; i < MAX_OBJECTS; i++) { 
		objectData[i].i_drawn = 0; // mark all as undrawn
		if (objectData[i].i_type == GRID_BACKGROUND) {
			pos = objectData[i].i_gridX + (objectData[i].i_gridY * gridWidth); // sometimes BI looses their marker
			if (gridPoints[pos].lvl0.f_shadow != 0) {
				gridPoints[pos].lvl0.f_shadow = 0;
printf("in GT: resetting BI %d:%s shadow\n", i, objectData[i].c_iconFile);
			}
		}
	}

		// check for any back ground images
	hasBackGroundImage = 0;
	for (gy=0; gy<ny; gy++) {
		if ((gy + gridTopY) > gridHeight) { break; }
		for (gx=0; gx<nx && gx < gridWidth; gx++) {
			if ((gx + gridTopX) > gridWidth) { break; }

			pos = (gx + gridTopX) + ((gy + gridTopY) * gridWidth);
			p_id = gridPoints[pos].lvl0.i_id;
			p_pid = gridPoints[pos].lvl1.i_id;
			p_type = gridPoints[pos].lvl0.i_type;
			p_viewed = gridPoints[pos].lvl0.f_viewed;
			p_color = gridPoints[pos].lvl0.i_color;
			p_shadow = gridPoints[pos].lvl0.f_shadow;
			p_pviewed = gridPoints[pos].lvl1.f_viewed;
			p_pshadow = gridPoints[pos].lvl1.f_shadow;
			p_phidden = gridPoints[pos].lvl1.f_hidden;
			p_ptype = gridPoints[pos].lvl1.i_type;

			background = NULL;

			//if (gx == 0 && gy == 0) { printf("bgi: T %d:%d I %d:%d\n", p_type, p_ptype, p_id, p_pid); }

			if (p_type == GRID_BACKGROUND && p_shadow == 0 || (p_type == GRID_BACKGROUND && p_shadow == 1 && objectData[p_id].i_drawn == 0) || (gy == 0 && p_ptype == GRID_BACKGROUND && objectData[p_pid].i_drawn == 0)) {
				if (gy == 0 && p_ptype == GRID_BACKGROUND) { p_id = p_pid; }
				if (objectData != NULL && p_id >= 0 && p_id < MAX_OBJECTS) {
					if (objectIcons[p_id] != NULL && objectData[p_id].i_drawn == 0) {

						if (objectData[p_id].i_width == 0 || objectData[p_id].i_height == 0) {
							printf("Error - Object size error %d = %d:%d:%d (%d:%d)\n", p_id, objectData[p_id].i_type, objectData[p_id].i_width, objectData[p_id].i_height, gx, gy);
							mx = objectIcons[p_id]->w() / 5; my = objectIcons[p_id]->h() / 5;
						} else {
							mx = objectIcons[p_id]->w() / objectData[p_id].i_width;
							my = objectIcons[p_id]->h() / objectData[p_id].i_height;
						}

							// what part of the image to display to
						i = (gridTopX + gx - objectData[p_id].i_gridX); if (i < 0) { i = 0; }
						j = (gridTopY + gy - objectData[p_id].i_gridY); if (j < 0) { j = 0; }

						ix = objectData[p_id].i_width - i;
						iy = objectData[p_id].i_height - j;

							// various boundary checks
						if (ix < 0) { ix = 0; } if (ix > nx) { ix = nx; } if ((ix + gx) > nx) { ix = nx - gx; }
						if (ix > objectData[p_id].i_width) { ix = objectData[p_id].i_width; }

						if (iy < 0) { iy = 0; } if (iy > ny) { iy = ny; } if ((iy + gy) > ny) { iy = ny - gy; }
						if (iy > objectData[p_id].i_height) { iy = objectData[p_id].i_height; }

//printf("// gt: %d BGI: gTX = %d gTY = %d i = %d j = %d ix = %d iy = %d gx = %d gy = %d nx = %d ny = %d icon = %s\n", p_id, gridTopX, gridTopY, i, j, ix, iy, gx, gy, nx, ny, objectData[p_id].c_iconFile);

						if (gridType == 1 && objectIcons[MAX_OBJECTS + p_id] != NULL) {
							if (objectData[p_id].i_animated == 1) {
								gifIcon = (Fl_Anim_GIF_Image *)objectIcons[MAX_OBJECTS + p_id]; resizedIcon = gifIcon->image();
								background = resizedIcon->copy_rect(ix*mx, iy*my, i*mx, j*my);
							} else {
								background = objectIcons[MAX_OBJECTS + p_id]->copy_rect(ix*mx, iy*my, i*mx, j*my);
							}
						} else {
							if (objectIcons[p_id] != NULL && objectData[p_id].i_width != 0 && objectData[p_id].i_height != 0) {
								if (objectData[p_id].i_animated == 1) {
									gifIcon = (Fl_Anim_GIF_Image *)objectIcons[p_id]; resizedIcon = gifIcon->image();
									background = resizedIcon->copy_rect(ix*mx, iy*my, i*mx, j*my);
								} else if (objectIcons[p_id] != NULL) {
									background = objectIcons[p_id]->copy_rect(ix*mx, iy*my, i*mx, j*my);
								}
							}
						}
						if (background != NULL) { 
							resizedIcon = background->copy(ix*gridSize, iy*gridSize); delete background; 
						} else { 
							if (gridType == 1 && objectIcons[MAX_OBJECTS + p_id] != NULL) {
								resizedIcon = objectIcons[MAX_OBJECTS + p_id]->copy(ix*gridSize, iy*gridSize); printf("BGI: 1 - Error .... %d %s\n", p_id, objectData[p_id].c_iconFile); 
							} else if (objectIcons[p_id] != NULL && objectData[p_id].i_width != 0 && objectData[p_id].i_height != 0) {
								resizedIcon = objectIcons[p_id]->copy(ix*gridSize, iy*gridSize); 
// printf("BGI: 0 - Error .... %d %s %d/%d %d/%d\n", p_id, objectData[p_id].c_iconFile, gx+gridTopX, gy+gridTopY, objectData[p_id].i_width, objectData[p_id].i_height); 
							}
						}

						mx = sx + (gx * gridSize); my = sy + (gy * gridSize);

						ix = (0 + ix) * gridSize; iy = (0 + iy) * gridSize;

						if ((mx + ix) > wid) { if (gridType == 0) { ix = wid - 15; } else { ix = wid - 10; } }
						if ((my + iy) > hei) { if (gridType == 0) { iy = hei - 15; } else { iy = hei - 10; } }

//printf("// gt: %d BGI: ix = %d iy = %d mx = %d my = %d wid = %d hei = %d\n\n", p_id, ix, iy, mx, my, wid, hei);

						if (resizedIcon != NULL && (ix != 0 || iy != 0)) { resizedIcon->draw(mx, my, ix, iy); delete resizedIcon; } // else { printf("BGI: 2 - resizedIcon NULL\n"); }

						if (gridType == 0 && (gridTopX + gx) == objectData[p_id].i_gridX && (gridTopY + gy) == objectData[p_id].i_gridY) {		// only draw object marker on the DM screen
							fl_font(FL_TIMES | FL_BOLD, (int )(gridSize/1.3));
//							fl_color(FL_BLACK);		// draw the object ID on screen
							fl_color(labelColor);		// draw the object ID on screen
							fl_draw("+", (int )(mx+(gridSize/3.3)), (int )(my+(gridSize/1.5)));
						}

						hasBackGroundImage = 1;
						objectData[p_id].i_drawn = 1;
					}
				}
			}
// todo
//				 && (playerData[p_id].flags.lvl0.f_viewed == 1 || playerData[p_id].flags.f_invisible == 1)) {
// && playerData[p_id].flags.f_disabled == 0 
			if (gridType == 1 && hasBackGroundImage == 1 && p_viewed == 0) {	// if its the players screen blank out
				if (p_ptype == GRID_BACKGROUND && p_type == GRID_MONSTER && p_pviewed == 1) {
					p_viewed += 0;
				} else {
					mx = sx + (gx * gridSize); my = sy + (gy * gridSize);
					fl_rectf(mx, my, gridSize, gridSize, colorMap[0]);
				}
			}
		}
	}

		// only draw the grid points we have to
for (int loop=0; loop < 2; loop++) {
	if (loop == 1) { // put in the grid lines
		fl_color(colorMap[1]);
		ix = 0;
		for (int i=0; i<wid; i+=gridSize) { fl_line(sx+i, sy, sx+i, sy+hei); if ((ix % 10) == 0 && gridType >= 0) { fl_line(sx+i+1, sy, sx+i+1, sy+hei); } ix++; }
		ix = 0;
		for (int i=0; i<hei; i+=gridSize) { fl_line(sx, sy+i, sx+wid, sy+i); if ((ix % 10) == 0 && gridType >= 0) { fl_line(sx, sy+i+1, sx+wid, sy+i+1); } ix++; }
	}

		// loop thro the map points and draw stuff
	for (gy=0; gy<ny; gy++) {
		if ((gy + gridTopY) > gridHeight) { break; }
		for (gx=0; gx<nx && gx < gridWidth; gx++) {
			if ((gx + gridTopX) > gridWidth) { break; }
			pos = (gx + gridTopX) + ((gy + gridTopY) * gridWidth);

			p_type = gridPoints[pos].lvl0.i_type;
			p_id = gridPoints[pos].lvl0.i_id;
			p_color = gridPoints[pos].lvl0.i_color;
			p_pcolor = gridPoints[pos].lvl1.i_color;
			p_shadow = gridPoints[pos].lvl0.f_shadow;
			p_hidden = gridPoints[pos].lvl0.f_hidden;
			p_viewed = gridPoints[pos].lvl0.f_viewed;
			p_pviewed = gridPoints[pos].lvl1.f_viewed;
			p_pshadow = gridPoints[pos].lvl1.f_shadow;
			p_phidden = gridPoints[pos].lvl1.f_hidden;
			p_ptype = gridPoints[pos].lvl1.i_type;

			if (p_type == GRID_BACKGROUND) { p_type = 0; }		// dont draw back ground images etc

			if (p_type != 0 && loop == 1) {
//printf("GP %d/%d = %d\n", (gx + gridTopX), (gy + gridTopY), i);
					// if it's the external grid, check to see if it's been viewed
				drawme = 0;
				osize = 1;
				if (gridType == 0) { drawme = 1; }
				else {
//printf("%d:%d %d:%d:%d:%d:%d:%d:%d:%d\n", gx, gy, gridPoints[pos].lvl0.i_color, gridPoints[pos].lvl1.i_color, gridPoints[pos].lvl0.f_viewed, gridPoints[pos].lvl0.f_hidden, gridPoints[pos].lvl0.i_type, gridPoints[pos].i_mapLayer, gridPoints[pos].lvl1.i_id, gridPoints[pos].lvl0.i_id);
					if (p_type == GRID_PLAYER) { drawme = 1; }
					else if (p_hidden == 0 && p_viewed == 1) { drawme = 1; }
					else if (p_hidden != 0) {
						i = gridPoints[pos].lvl1.i_color;
						mx = sx + (gx * gridSize);
						my = sy + (gy * gridSize);
						if (i > 7 && i < 24 && texture[i-8] != NULL) {
							resizedIcon = texture[i-8]->copy(gridSize, gridSize);
							resizedIcon->draw(mx,my,gridSize,gridSize);
							delete resizedIcon;
							// smooth_line(gx, gy);
						} else {
							if (p_type == 0) {		// dont draw hidden things
								fl_color(colorMap[i]); fl_rectf(mx+1,my+1,gridSize-1,gridSize-1);
								// smooth_line(gx, gy);
							}
						}
					}
					if (p_type == GRID_MONSTER && playerData[p_id].flags.f_wasViewed == 1 && playerData[p_id].flags.f_invisible == 0) { drawme = 1; }
						// dont draw hidden objects
					if (p_type == GRID_OBJECT && objectData[p_id].f_hidden == 1) { drawme = 0; }
				}

				if (drawme == 1) {
					mx = sx + (gx * gridSize);
					my = sy + (gy * gridSize);
					if (p_type == GRID_OBJECT) { 
						if (objectData != NULL && p_id >= 0 && p_id < MAX_OBJECTS && objectData[p_id].i_drawn == 0 && objectData[p_id].i_width > 0 && objectData[p_id].i_height > 0) {
							if (objectIcons[p_id] != NULL) {
								objectData[p_id].i_drawn = 1;
									// what part of the object icon to show
								if (objectData[p_id].i_width == 0 || objectData[p_id].i_height == 0) {
									printf("Error - Object size error 2 %d = %d:%d:%d\n", p_id, objectData[p_id].i_type, objectData[p_id].i_width, objectData[p_id].i_height);
									mx = objectIcons[p_id]->w() / 5;
									my = objectIcons[p_id]->h() / 5;
								} else {
									mx = objectIcons[p_id]->w() / (objectData[p_id].i_width/5);
									my = objectIcons[p_id]->h() / (objectData[p_id].i_height/5);
								}
								i = (gridTopX + gx - objectData[p_id].i_gridX); if (i < 0) { i = 0; }
								j = (gridTopY + gy - objectData[p_id].i_gridY); if (j < 0) { j = 0; }
								ix = (objectData[p_id].i_width / 5) - i;
								iy = (objectData[p_id].i_height / 5) - j;
//printf("Draw object: %d %d:%d %d:%d %d:%d %d\n", p_id, ix, iy, objectData[p_id].i_width, objectData[p_id].i_height, i, j, gridSize);
									// various boundary checks 
								if (ix < 0) { ix = 0; } if (ix > nx) { ix = nx; } if ((ix + gx) > nx) { ix = nx - gx; }
								if (ix > (objectData[p_id].i_width / 5)) { ix = objectData[p_id].i_width / 5; }
								if (ix == 0) { ix = objectData[p_id].i_width / 5; }
 
								if (iy < 0) { iy = 0; } if (iy > ny) { iy = ny; } if ((iy + gy) > ny) { iy = ny - gy; }
								if (iy > (objectData[p_id].i_height / 5)) { iy = objectData[p_id].i_height / 5; }
								if (iy == 0) { iy = objectData[p_id].i_height / 5; }

//printf("%d:%s = %d:%d = %d:%d\n", p_id, objectData[p_id].c_iconFile, objectIcons[p_id]->w(), objectIcons[p_id]->h(), mx, my);
								if (mx < 2048 && my < 2048) {
									if (objectData[p_id].i_animated == 1) {
										gifIcon = (Fl_Anim_GIF_Image *)objectIcons[p_id]; 
										resizedIcon = gifIcon->image();
										background = resizedIcon->copy_rect(ix*mx, iy*my, i*mx, j*my);
									} else {
										background = objectIcons[p_id]->copy_rect(ix*mx, iy*my, i*mx, j*my);
									}
								} else {
printf("Image corruption: %d:%s = %d:%d = %d:%d\n", p_id, objectData[p_id].c_iconFile, objectIcons[p_id]->w(), objectIcons[p_id]->h(), mx, my);
									background = NULL;
								}
								//if (ix < nx && iy < ny) { if (background != NULL) { delete background; } background = NULL; }
								if (background != NULL) {
									resizedIcon = background->copy(ix*gridSize, iy*gridSize); delete background;
								} else {
									resizedIcon = objectIcons[p_id]->copy(ix*gridSize, iy*gridSize);
								}
								mx = sx + (gx * gridSize); my = sy + (gy * gridSize);
								if (resizedIcon == NULL) {
									printf("gt Error: 1: %d = %s\n", p_id, objectData[p_id].c_iconFile);
								} else {
									resizedIcon->draw(mx+1, my+1, (ix*gridSize)-1, (iy*gridSize)-1);
									delete resizedIcon;
								}
//printf("Draw object: %d %d:%d %d:%d %d:%d %d\n", p_id, mx, my, objectData[p_id].i_width, objectData[p_id].i_height, ix, iy, gridSize);
								if (gridType == 0 && i == 0 && j ==0) {		// only draw object marker on the DM screen
									fl_font(FL_TIMES | FL_BOLD, (int )(gridSize/1.3));
//									fl_color(FL_BLACK);		// draw the object ID on screen
									fl_color(labelColor);		// draw the object ID on screen
									fl_draw("+", (int )(mx+(gridSize/3.3)), (int )(my+(gridSize/1.5)));
								}
							} else {
								if (gridType == 0) {		// only draw object on the DM screen
									fl_color(colorMap[2]); 
									fl_rectf(mx,my,gridSize,gridSize);
								}
							}
						}
					} else {
						// only draw real objects and not their shadows
						if (p_shadow == 0 || (p_shadow == 1 && ((p_type == GRID_PLAYER || p_type == GRID_MONSTER) && playerData[p_id].flags.f_displayed == 0 && ((playerData[p_id].flags.f_wasViewed == 1 && playerData[p_id].flags.f_invisible == 0) || gridType == 0)))) {
							if (playerData[p_id].i_space > 5) { osize = playerData[p_id].i_space / 5; } else { osize = 1; }
							ix = (gridTopX + gx - playerData[p_id].i_mapX); if (ix < 0) { ix = 0; }
							iy = (gridTopY + gy - playerData[p_id].i_mapY); if (iy < 0) { iy = 0; }
//printf("Os = %d TX = %d gx = %d mX = %d ix = %d\n", osize, gridTopX, gx, playerData[p_id].i_mapX, ix);
							if (p_type == GRID_PLAYER) { fl_color(colorMap[3]); 
							} else if (p_type == GRID_MONSTER) { fl_color(colorMap[4]); 
							}
//printf("%d = %d:%d:%d\n", pos, p_id, playerData[p_id].flags.lvl0.f_viewed, gridType);
							playerData[p_id].flags.f_displayed = 1;
							fl_rectf(mx+1,my+1,(gridSize*(osize-ix))-1,(gridSize*(osize-iy))-1);
							if (p_id > MAX_MEMBERS) { return; }
							currentIcon = playerIcons[p_id];
							if (p_type == GRID_MONSTER && playerData[p_id].flags.f_disabled == 1) {
								if (inactiveIcons[p_id] != NULL) { currentIcon = inactiveIcons[p_id]; }
									// on the player screen hide things
								if (gridType == 1) {
									fl_color(colorMap[0]); fl_rectf(mx+1,my+1,(gridSize*(osize-ix))-1,(gridSize*(osize-iy))-1);
								}
							}
							if (currentIcon != NULL && currentIcon->w() > 0 && currentIcon->h() > 0) {
								ix = iy = 0;
								i = (gridTopX + gx - playerData[p_id].i_mapX); if (i < 0) { i = 0; }
								j = (gridTopY + gy - playerData[p_id].i_mapY); if (j < 0) { j = 0; }
								if (currentIcon->w() > currentIcon->h()) {
									iy = (gridSize * (osize-j) * currentIcon->h()) / currentIcon->w();
									if (iy == 0) {
										printf("Image Error: %d = %d/%d\n", p_id, currentIcon->h(), currentIcon->w());
										iy = gridSize * (osize-j);
									}
// TODO : not sure why this causes a crash ....
									//if (resizedIcon != NULL) { delete resizedIcon; }
									resizedIcon = currentIcon->copy(gridSize*(osize-i), iy);
									iy = ((gridSize * (osize-j)) - iy) / 2;
								} else {
									ix = (gridSize * (osize-i) * currentIcon->w()) / currentIcon->h();
// TODO : not sure why this causes a crash ....
									//if (resizedIcon != NULL) { delete resizedIcon; }
									resizedIcon = currentIcon->copy(ix, gridSize*(osize-j));
									ix = ((gridSize * (osize-i)) - ix) / 2;
								}
//if (p_type == GRID_MONSTER) {
//	resizedIcon = rotate_image((Fl_Shared_Image *)resizedIcon, 90);
//}
								if (resizedIcon != NULL) { 
									resizedIcon->draw(mx+ix,my+iy,gridSize*(osize-i),gridSize*(osize-j)); 
									delete resizedIcon;
								}
								if (p_type == GRID_MONSTER && ((playerData[p_id].flags.f_wasViewed == 1 && playerData[p_id].flags.f_disabled == 0) || gridType == 0)) {
								//if (p_type == GRID_MONSTER && (playerData[p_id].flags.f_wasViewed == 1 || gridType == 0)) {
									fl_color(labelColor);		// draw the monster ID on screen
									if (playerData[p_id].i_space > 5) {
										fl_font(FL_TIMES | FL_BOLD, (int )(gridSize/1.3));
									} else {
										fl_font(FL_TIMES | FL_BOLD, (int )(gridSize/1.6));
									}
									if (playerData[p_id].i_noInGroup > 0) {
										sprintf(text, "%d", playerData[p_id].i_noInGroup);
										fl_draw(text, (int )(mx+(gridSize*osize)-fl_width(text)), (int )(my+(gridSize*osize)-(fl_size()/4)));
									}
									text[0] = playerData[p_id].c_name[0]; text[1] = '\0';
									fl_draw(text, mx+2, (int )(my+0+(fl_height()/1.76)));
									if (playerData[p_id].flags.f_massUnit == 1 && playerData[p_id].flags.f_massStatus != 0) {
										if (playerData[p_id].flags.f_massStatus == 1) { strcpy(text, "Br"); }
										if (playerData[p_id].flags.f_massStatus == 2) { strcpy(text, "Ha"); }
										fl_font(FL_TIMES | FL_BOLD, (int )(gridSize/4)); fl_draw(text, mx+(gridSize/1.3), (int )(my+2+(fl_height()/1.5)));
									}
								}
							} else if (playerData != NULL && playerData[p_id].i_hp[HP_MAX] > 0 && playerData[p_id].c_name[0] != '\0') {
								ix = iy = 0;
								i = (gridTopX + gx - playerData[p_id].i_mapX); if (i < 0) { i = 0; }
								j = (gridTopY + gy - playerData[p_id].i_mapY); if (j < 0) { j = 0; }
								fl_rectf(mx+1,my+1,(gridSize*(osize-i))-1,(gridSize*(osize-j))-1);
								text[0] = playerData[p_id].c_name[0]; text[1] = '\0';
								fl_color(FL_BLACK);
								if (playerData[p_id].i_space > 5) {
									fl_font(FL_TIMES | FL_BOLD, (int )(gridSize/1.3));
								} else {
									fl_font(FL_TIMES | FL_BOLD, (int )(gridSize/1.6));
								}
								if (playerData[p_id].i_noInGroup > 0) {
									fl_draw(text, mx, (int )(my+(fl_size()/1.3)));
									sprintf(text, "%d", playerData[p_id].i_noInGroup);
									fl_draw(text, (int )(mx+(gridSize*osize)-fl_width(text)), (int )(my+(gridSize*osize)-(fl_size()/4)));
								} else {
									fl_draw(text, (int )(mx+(gridSize/3.3)), (int )(my+(gridSize/1.5)));
								}
							}
							if (p_type == GRID_MONSTER || p_type == GRID_PLAYER) {
								ix = playerData[p_id].i_hp[HP_CUR] + playerData[p_id].i_hp[HP_ADJ] + playerData[p_id].i_hp[HP_TMP];
								if ((ix < 1 && (config->i_diceSystem == DICE_D20V5 || config->i_diceSystem == DICE_D20V55)) || (ix < 0 && config->i_diceSystem != DICE_D20V5)) {
									fl_color(FL_RED);
									fl_line(mx, my, mx+(gridSize*(osize-i)), my+(gridSize*(osize-j)));
									fl_line(mx+1, my, mx+(gridSize*(osize-i)), my+(gridSize*(osize-j))-1);
									fl_line(mx+(gridSize*(osize-i)), my, mx, my+(gridSize*(osize-j)));
									fl_line(mx+(gridSize*(osize-i))-1, my, mx, my+(gridSize*(osize-j))-1);
								}
								if ((showHealthStatus == 1 && playerData[p_id].flags.f_disabled == 0) || gridType == 0) {		// show the health bar on screen
									if (gridType == 0) { // || (gridType == 1 && p_type == GRID_PLAYER)) {
//printf("sHB = %d %d\n", gridType, p_id);
										fl_color(labelColor);
										if (gridType == 0) {		// show the exact percentage on the DM screen
											// sprintf(text, "%d", (((playerData[p_id].i_hp[HP_CUR] * 100) / playerData[p_id].i_hp[HP_MAX]) * 1));
											sprintf(text, "%d", playerData[p_id].i_health);
											fl_font(FL_TIMES | FL_BOLD, (int )(gridSize/4));
										} else {						// show an aproximate status on the player screen
											// sprintf(text, "%d", (((playerData[p_id].i_hp[HP_CUR] * 10) / playerData[p_id].i_hp[HP_MAX]) * 10));
											sprintf(text, "%d", ((playerData[p_id].i_health / 10) * 10));
											fl_font(FL_TIMES | FL_BOLD, (int )(gridSize/2));
										}
										fl_draw(text, mx+1, my+(gridSize*(osize-j)));
										//fl_draw(text, mx+(gridSize/1.8), my+(gridSize/3));
									} else if (gridType == 1 && (p_type == GRID_MONSTER || p_type == GRID_PLAYER)) {
										fl_font(FL_TIMES | FL_BOLD, (int )(gridSize/2.5));
										fl_color(labelColor);
										//if (playerData[p_id].i_health > 99)      { sprintf(text, "%d", playerData[p_id].i_health); fl_draw(text, mx+1, my+(gridSize*osize)); }
										if (playerData[p_id].i_health > 100)      { fl_draw("100+", mx+1, my+(gridSize*(osize-j))); }
										else if (playerData[p_id].i_health == 100)      { fl_draw("100", mx+1, my+(gridSize*(osize-j))); }
										else if (playerData[p_id].i_health > 79) { fl_draw("80", mx+1, my+(gridSize*(osize-j))); }
										else if (playerData[p_id].i_health > 59) { fl_draw("60", mx+1, my+(gridSize*(osize-j))); }
										else if (playerData[p_id].i_health > 39) { fl_draw("40", mx+1, my+(gridSize*(osize-j))); }
										else if (playerData[p_id].i_health > 19) { fl_draw("20", mx+1, my+(gridSize*(osize-j))); }
										else { fl_draw("**", mx+1, my+(gridSize*(osize-j))); }
									}
								}
							}
	//printf("out draw: %d:%d:%s:%s\n", i, osize, playerData[i].c_iconFile, playerIcons[i]);
						}
					}
				}
			} else if (p_color != 0 && loop == 0) {
					// if it's the external grid, check to see if it's been viewed
				if (gridType == 0 || (gridType == 1 && p_hidden == 0 && (p_viewed == 1 || (p_type != 0 && p_pviewed == 1)))) {
					mx = sx + (gx * gridSize);
					my = sy + (gy * gridSize);
if (p_color < 0 || p_color > 31) { printf("gridTile: p_color = %d\n", p_color); }
if (p_pcolor < 0 || p_pcolor > 31) { printf("gridTile: p_pcolor = %d\n", p_pcolor); }
					if (p_color < 24) {		// check DM invisible colors
						if (p_color > 7 && texture[p_color-8] != NULL) {
							resizedIcon = texture[p_color-8]->copy(gridSize, gridSize);
							if (resizedIcon != NULL) {
								resizedIcon->draw(mx,my,gridSize,gridSize);
								delete resizedIcon;
							}
							// smooth_line(gx, gy);
						} else {
							fl_color(colorMap[p_color]); fl_rectf(mx,my,gridSize,gridSize);
							// smooth_line(gx, gy);
						}
					} else {
						if (gridType == 0) { 
							i = p_color; fl_color(colorMap[i]); 
							if (i > 29) {
								fl_rect(mx+1,my+1,gridSize-1,gridSize-1); 
								//fl_rect(mx+2,my+2,gridSize-2,gridSize-2); 
							} else {
								fl_rectf(mx,my,gridSize,gridSize); 
							}
						} else { 
							i = p_pcolor;
							if (i < 24) { 
								fl_color(colorMap[i]); fl_rectf(mx,my,gridSize,gridSize);
								// smooth_line(gx, gy);
							}
						}
					}
				}
			} else if (gridType == 1 && loop == 0 && p_hidden == 0 && p_type != 0 && p_pviewed == 1 && p_viewed == 0 && p_color < 24) {
				mx = sx + (gx * gridSize); my = sy + (gy * gridSize);
				if (p_color > 7 && texture[p_color-8] != NULL) {
					resizedIcon = texture[p_color-8]->copy(gridSize, gridSize);
					if (resizedIcon != NULL) {
						resizedIcon->draw(mx,my,gridSize,gridSize);
						delete resizedIcon;
					}
					// smooth_line(gx, gy);
				} else {
// todo
//{ && (playerData[p_id].flags.f_invisible == 0 && playerData[p_id].flags.f_disabled == 0)) {
					if ((p_ptype == GRID_BACKGROUND && p_type == GRID_MONSTER && p_viewed == 1) 
					 || (p_ptype == GRID_BACKGROUND && p_type == GRID_MONSTER && playerData[p_id].flags.f_wasViewed == 0)) {
						p_color += 0;
					} else {
						fl_color(colorMap[p_pcolor]); fl_rectf(mx,my,gridSize,gridSize);
						// smooth_line(gx, gy);
					}
				}
			}
		}
	}
	//if (resizedIcon != NULL) { delete resizedIcon; }
}
		// display init sequence on the player screen
	if (showInitList != 0 && gridType == 1 && config != NULL ) { 

		switch (initListSetting) {
			case 0:     // top
				xpos = 40; ypos = 40; yinc = 0; xinc = 41;
				if (hei > 700) { xinc = 71; }
				break;
			case 1:     // bottom
				xpos = 40; ypos = h() - 20; yinc = 0; xinc = 41;
				if (hei > 700) { xinc = 71; }
				break;
			case 2:     // left
				xpos = 40; ypos = 40; yinc = 41; xinc = 0;
				if (hei > 700) { yinc = 71; }
				break;
			case 3:     // right
				xpos = w() - 20; ypos = 40; yinc = 41; xinc = 0;
				if (hei > 700) { yinc = 71; }
				break;
			case 4:		// centre top
				for (i=0; i<MAX_MEMBERS && config->i_idList[ID_INIT][i] != -1; i++) { ; }
				xpos = (w() / 2) - ((i * 40) / 2); ypos = 40; yinc = 0; xinc = 71;
				if (hei > 700) { xinc = 71; }
				if (xpos < 40) { xpos = 40; }
				break;
		}
//printf("Xinc = %d  Yinc = %d\n", xinc, yinc);
		osize = 40;
		if (xinc > 0) { osize = xinc - 1; }
		if (yinc > 0) { osize = yinc - 1; }

		fl_color(FL_BLACK); fl_font(FL_TIMES | FL_BOLD, osize);
		for (i=0; i<MAX_MEMBERS; i++) {
			p_id = config->i_idList[ID_INIT][i];
			if (config->i_idList[ID_INIT][i] == -1) { break; }
				// dont show hidden/invis monsters
			if (p_id >= MAX_PLAYERS && (playerData[p_id].flags.f_invisible == 1 || playerData[p_id].flags.f_disabled == 1)) { continue; }
			if (p_id < MAX_PLAYERS && playerData[p_id].flags.f_disabled == 1) { continue; }

			fl_color(colorMap[0]); fl_rectf(xpos, ypos, osize, osize);
			text[0] = playerData[p_id].c_name[0]; text[1] = '\0';

			if (playerData[p_id].i_doneAttacks > 0) { fl_color(FL_RED); } else { fl_color(FL_GREEN); }
			fl_rect(xpos, ypos, osize, osize); fl_rect(xpos+1, ypos+1, osize-2, osize-2);
				// if it's a monster or without an icon just put the ID
			if (p_id >= MAX_PLAYERS || (p_id < MAX_PLAYERS && playerIcons[p_id] == NULL)) {
				fl_draw(text, xpos+6, ypos+osize-6);
			} else {
				resizedIcon = playerIcons[p_id]->copy(osize-4, osize-4);		// show the players icon
				resizedIcon->draw(xpos+2, ypos+2, osize-4, osize-4); delete resizedIcon;
			}
			xpos += xinc; ypos += yinc;
			if (xpos >= wid || ypos >= hei) { break; }		// dont go past the end of the screen
		}
	}
/*
	// look for any players or monsters not shown for any reason
	if (playerData != NULL) {
		for (i=0; i < MAX_MEMBERS; i++) {
			drawme = 0;
			if (gridType == 0 && playerData[i].flags.f_displayed == 0 && playerData[i].c_name[0] != '\0' && playerData[i].i_hp[0] > 0 && playerData[i].i_mapX != -1) { drawme = 1; }
			if (gridType == 1 && playerData[i].flags.f_displayed == 0 && playerData[i].c_name[0] != '\0' && playerData[i].i_hp[0] > 0 && playerData[i].i_mapX != -1 && playerData[i].flags.f_invisible == 0 && playerData[i].flags.f_disabled == 0) { 
				drawme = 1; 
				if (i >= MAX_PLAYERS && playerData[i].flags.f_wasViewed == 0) { drawme = 0; }
			}

			if (drawme == 1) {
//printf("1 Player %d : %s not shown (%d/%d)\n", i, playerData[i].c_name, xpos, ypos);
				if (playerData[i].i_mapX >= gridTopX && playerData[i].i_mapX < (gridTopX + nx)
				 && playerData[i].i_mapY >= gridTopY && playerData[i].i_mapY < (gridTopY + ny)) {
					ix = iy = 0;
					osize = gridSize * (playerData[i].i_space / 5);
					xpos = (playerData[i].i_mapX - gridTopX) * gridSize;  xpos += sx;
					ypos = (playerData[i].i_mapY - gridTopY) * gridSize;  ypos += sy;
//printf("Player %d : %s not shown (%d/%d)\n", i, playerData[i].c_name, xpos, ypos);
					if (i < MAX_PLAYERS) { fl_color(colorMap[3]); } else { fl_color(colorMap[4]); }
					fl_rectf(xpos+1, ypos+1, osize-1, osize-1);
					if (playerIcons[i] == NULL) {
						text[0] = playerData[i].c_name[0]; text[1] = '\0';
						fl_font(FL_TIMES | FL_BOLD, (int )(gridSize/3)); fl_color(labelColor);
						fl_draw(text, xpos+6, ypos+(gridSize/3));
					} else {
						resizedIcon = playerIcons[i]->copy(osize, osize);
						resizedIcon->draw(xpos+1, ypos+1, osize-1, osize-1); delete resizedIcon;
						fl_color(FL_BLACK); fl_draw("X", xpos+6, ypos+(gridSize/3));
					}
				} else {
					osize = (playerData[i].i_space / 5); if (osize == 1) { osize = 0; }
					if ((playerData[i].i_mapX + osize) > gridTopX && (playerData[i].i_mapX + osize) < (gridTopX + nx)
				 	&& (playerData[i].i_mapY + osize) > gridTopY && (playerData[i].i_mapY + osize) < (gridTopY + ny)) {
						gx = (playerData[i].i_mapX - gridTopX);
						gy = (playerData[i].i_mapY - gridTopY);
						ix = iy = osize = playerData[i].i_space / 5;
						if (gx < 0 && gy < 0) { 
							ix += gx; iy += gy;
						} else if (gx < 0) { 
							ix += gx;
						} else if (gy < 0) { 
							iy += gy;
						}
						xpos = (playerData[i].i_mapX - gridTopX + (osize - ix)) * gridSize;  xpos += sx;
						ypos = (playerData[i].i_mapY - gridTopY + (osize - iy)) * gridSize;  ypos += sy;
//printf("Player %d : %s not shown - partial display (%d/%d) %d:%d %d:%d\n", i, playerData[i].c_name, ix, iy, (gridTopX - playerData[i].i_mapX), (gridTopY - playerData[i].i_mapY), xpos, ypos);
						if (i < MAX_PLAYERS) { fl_color(colorMap[3]); } else { fl_color(colorMap[4]); }
						fl_rectf(xpos+1, ypos+1, (ix * gridSize) - 1, (iy * gridSize) - 1);
						if (playerIcons[i] != NULL) {
                     mx = playerIcons[i]->w() / osize;
                     my = playerIcons[i]->h() / osize;
							background = playerIcons[i]->copy_rect(ix * mx, iy * my, (osize - ix) * mx, (osize - iy) * my);
							if (background != NULL) {
//printf("PNS: %s   %d:%d %d %d %d\n", playerData[i].c_name, ix, iy, osize, mx, my);
								resizedIcon = background->copy(ix*gridSize, iy*gridSize);
								if (resizedIcon != NULL) {
									resizedIcon->draw(xpos+1, ypos+1, (ix*gridSize)-1, (iy*gridSize)-1); delete resizedIcon;
								}
								delete background;
							} else {
								resizedIcon = playerIcons[i]->copy(ix*gridSize, iy*gridSize);
								if (resizedIcon != NULL) {
									resizedIcon->draw(xpos+1, ypos+1, (ix*gridSize)-1, (iy*gridSize)-1); delete resizedIcon;
								}
							}
						}
						if (i >= MAX_PLAYERS) {
							text[0] = playerData[i].c_name[0]; text[1] = '\0';
							fl_font(FL_TIMES | FL_BOLD, (int )(gridSize/1.5)); fl_color(labelColor);
							fl_draw(text, xpos+6, ypos+(gridSize/2));
						}
					}
				}
			}
		}
	}
*/
	if (timerMinutes > 0 && timerStart != 0) {
		currentTime = time(NULL);
//printf("timer = %d/ %ld / %ld\n", timerMinutes, timerStart, currentTime);
		i = difftime(currentTime, timerStart) / 60;
		fl_color(labelColor); fl_font(FL_TIMES | FL_BOLD, 30);
		sprintf(text, "Timer: %d / %d", i, timerMinutes);
		if (initListSetting != 0) { xpos = 0; ypos = 40; }
		if (gridType == 0) { fl_draw(text, 240, 120); } else { fl_draw(text, xpos+40, 70); }
	}
}

//*****************************************************************************************
void gridTile::doAnimations() {
	int sx=0, sy=0, wid=0, hei=0, gx=0, gy=0, mx=0, my=0, i=0, j=0, nx=0, ny=0, pos=0, drawme=0, osize=0, ix=0, iy=0;
	int p_type, p_id, p_color, p_shadow, p_hidden, p_viewed, p_pviewed, p_pcolor, p_phidden, p_pshadow, p_ptype, p_pid;

	char text[8];
	Fl_Image *resizedIcon=NULL;
	Fl_Image *background=NULL;
	Fl_Anim_GIF_Image *gifIcon=NULL;

	if (visible_r() == 0) { return; }
	printf("in gridTile::doAnimation - visible = %d\n", visible_r());

	if (gridTopX < 0) { gridTopX = 0; }
	if (gridTopY < 0) { gridTopY = 0; }

//printf("in gridTile::doAnimation (%d: GW:%d GH:%d TX:%d TY:%d)\n", gridType,gridWidth,gridHeight,gridTopX,gridTopY);

	sx = x(); sy = y();
	if (gridType == 1) { sx = 30; sy = 31; }
	wid = w(); hei = h();
	nx = wid/gridSize; ny = hei/gridSize;

		// loop thro the map points and draw stuff
	for (gy=0; gy<ny; gy++) {
		if ((gy + gridTopY) > gridHeight) { break; }
		for (gx=0; gx<nx && gx < gridWidth; gx++) {
			if ((gx + gridTopX) > gridWidth) { break; }
			pos = (gx + gridTopX) + ((gy + gridTopY) * gridWidth);

			p_type = gridPoints[pos].lvl0.i_type;
			p_id = gridPoints[pos].lvl0.i_id;
			p_color = gridPoints[pos].lvl0.i_color;
			p_pcolor = gridPoints[pos].lvl1.i_color;
			p_shadow = gridPoints[pos].lvl0.f_shadow;
			p_hidden = gridPoints[pos].lvl0.f_hidden;
			p_viewed = gridPoints[pos].lvl0.f_viewed;
			p_pviewed = gridPoints[pos].lvl1.f_viewed;
			p_pshadow = gridPoints[pos].lvl1.f_shadow;
			p_phidden = gridPoints[pos].lvl1.f_hidden;
			p_ptype = gridPoints[pos].lvl1.i_type;

			if ((p_type == GRID_MONSTER || p_type == GRID_PLAYER) && p_shadow == 0) {
				if (playerData[p_id].i_iconType == 2) {
					mx = sx + (gx * gridSize);
					my = sy + (gy * gridSize);
					if (playerData[p_id].i_space > 5) { osize = playerData[p_id].i_space / 5; } else { osize = 1; }
					if (playerIcons[p_id] != NULL && playerIcons[p_id]->w() > 0 &&  playerIcons[p_id]->h() > 0) {
						ix = iy = 0;
						if (playerIcons[p_id]->w() > playerIcons[p_id]->h()) {
							iy = (gridSize * osize * playerIcons[p_id]->h()) / playerIcons[p_id]->w();
							resizedIcon = playerIcons[p_id]->copy(gridSize*osize, iy);
							iy = ((gridSize * osize) - iy) / 2;
						} else {
							ix = (gridSize * osize * playerIcons[p_id]->w()) / playerIcons[p_id]->h();
							resizedIcon = playerIcons[p_id]->copy(ix, gridSize*osize);
							ix = ((gridSize * osize) - ix) / 2;
						}
						if (resizedIcon != NULL) { 
							resizedIcon->draw(mx+ix,my+iy,gridSize*osize,gridSize*osize); 
							delete resizedIcon;
							fl_color(FL_MAGENTA); fl_line(mx, my, mx+(gridSize*osize), my+(gridSize*osize));
						}
//printf("doAnimated: %d = %d %s at %d:%d / %d:%d\n", gridType, p_id, playerData[p_id].c_iconFile, mx, my, ix, iy);
					}
				}
			}
		}
	}
}

//*****************************************************************************************
int gridTile::handle(int event) {
	int gx, gy, gpos, i;
	char buf[160], buf1[40];

	if (event == 0) { return 1; }

	gx = gridTopX + ((Fl::event_x() - x()) / gridSize);
	gy = gridTopY + ((Fl::event_y() - y()) / gridSize);

	if (gridType == 1) { 				// handle events on the external grid map
		if (event == FL_MOUSEWHEEL) { 
			if (Fl::event_dy() > 0) { setGridSize(-1); } else { setGridSize(+1); } //centreMap(prevCentreX, prevCentreY); }
			if (prevEvent != FL_MOUSEWHEEL) { centreMap(gx,gy); } else { centreMap(prevCentreX, prevCentreY); }
			prevEvent = FL_MOUSEWHEEL;
			return 0;
		}
		if (event == FL_DRAG) { prevEvent = FL_DRAG; }
		if (event == FL_RELEASE && prevEvent == FL_DRAG) {
			centreMap(prevCentreX+(clickedX-gx), prevCentreY+(clickedY-gy));
			clickedX = clickedY = -1;
			prevEvent = FL_RELEASE;
		}
		if (event == FL_PUSH && Fl::event_button() == FL_LEFT_MOUSE && Fl::event_clicks() == 0) {
				clickedX = gx; clickedY = gy;
		}
			// dbl click - centre map there
		if (Fl::event_clicks() != 0) { centreMap(gx,gy); Fl::event_clicks(0); parent->draw(); }
		return 1;
	}

//printf("Event: E=%d B=%d S=%d X=%d Y=%d T=%d\n", event, Fl::event_button(), Fl::event_state(), Fl::event_x(), Fl::event_y(), gridType);

	gpos = gx + (gy * gridWidth);

	if (gpos < 0) { return 1; }

		// dbl click - centre map there
	if (Fl::event_clicks() != 0) { centreMap(gx,gy); Fl::event_clicks(0); parent->draw(); return 1; }

	if (event == FL_DRAG) {
//printf("DRAG Event: E=%d B=%d S=%d X=%d Y=%d %d/%d M=%d\n", event, Fl::event_button(), Fl::event_state(), Fl::event_x(), Fl::event_y(), gx,gy, gridMode);
		switch (gridMode) {
			case MODE_COMBAT:
					//fl_rect(Fl::event_x(),Fl::event_y(),gridSize,gridSize,FL_BLACK);
					break;
			case MODE_FREESTYLE:
					if (prevX != gx || prevY != gy) { setGridColor(gx, gy, currColor); prevX = gx; prevY = gy; }
					break;
			case MODE_LINES:
					break;
			case MODE_SHAPES:
					drawShape(gx, gy);
					break;
			case ACTION_10CORRIDOR:
					if (clickedX != gx || clickedY != gy) {
//printf("ACTION_10CORRIDOR: %d:%d %d:%d\n", clickedX, clickedY, gx, gy);
						setGridColor(gx, gy, currColor);
						if (clickedX == gx) { setGridColor(gx+3, gy, currColor); }
						else if (clickedY == gy) { setGridColor(gx, gy-3, currColor); }
						clickedX = gx; clickedY = gy;
					}
					break;
			case ACTION_20CORRIDOR:
					if (clickedX != gx || clickedY != gy) {
						if (clickedX == gx) { setGridColor(gx, gy, currColor); setGridColor(gx+5, gy, currColor); }
						else if (clickedY == gy) { setGridColor(gx, gy, currColor); setGridColor(gx, gy-5, currColor); }
						clickedX = gx; clickedY = gy;
					}
					break;
			case ACTION_CLEARMAP:
					if (prevX != gx || prevY != gy) { setGridColor(gx, gy, 99); prevX = gx; prevY = gy; }
					break;
		}
		prevEvent = FL_DRAG;
	} else if (event == FL_RELEASE) {
//printf("RELS Event: E=%d B=%d S=%d X=%d Y=%d %d/%d\n", event, Fl::event_button(), Fl::event_state(), Fl::event_x(), Fl::event_y(), gx,gy);
		if (prevEvent == FL_DRAG && gridMode == MODE_COMBAT) {
			if (getGridType(clickedX, clickedY) == GRID_BACKGROUND && isTopLHS(clickedX, clickedY) == 0) {
//printf("m0: %d/%d = %d/%d = %d/%d = %d\n", prevCentreX, prevCentreY, gx, gy, clickedX, clickedY, getGridType(clickedX, clickedY));
				centreMap(prevCentreX+(clickedX-gx), prevCentreY+(clickedY-gy));
				clickedX = clickedY = -1;
				prevEvent = FL_RELEASE;
			} else {
//printf("m1: %d/%d = %d/%d = %d/%d = %d\n", prevCentreX, prevCentreY, gx, gy, clickedX, clickedY, getGridType(clickedX, clickedY));
				moveGridPoint(clickedX, clickedY, gx, gy);
				clickedX = clickedY = -1;
				prevEvent = FL_RELEASE;
			}
		} else if (prevEvent == FL_PUSH && gridMode == MODE_LINES) {
			clickedX = gx; clickedY = gy;
			return 1;
		} else if (prevEvent == FL_PUSH && gridMode == MODE_COMBAT) {
			clickedX = gx; clickedY = gy;
			return 1;
		} else {
			clickedX = clickedY = -1;
			prevEvent = FL_RELEASE;
		}
	} else if (event == FL_MOUSEWHEEL) {
		if (Fl::event_dy() > 0) { setGridSize(-1); } else { setGridSize(+1); }
		if (prevEvent != FL_MOUSEWHEEL) { centreMap(gx,gy); } else { centreMap(prevCentreX, prevCentreY); }
		parent->draw();
		prevEvent = FL_MOUSEWHEEL;
	} else if (event == FL_PUSH) {
//printf("PUSH Event: E=%d B=%d S=%d X=%d Y=%d %d/%d. Mode = %d\n", event, Fl::event_button(), Fl::event_state(), Fl::event_x(), Fl::event_y(), gx,gy, gridMode);
		if (gridOutputText != NULL) {
			sprintf(buf, "Pressed at %d:%d", gx, gy);
			gridOutputText->text(4, buf);

			sprintf(buf, "C%d:%d:V%d:%d:H%d:%d:T%d:%d:I%d:%d:S%d:%d", gridPoints[gpos].lvl0.i_color, gridPoints[gpos].lvl1.i_color, gridPoints[gpos].lvl0.f_viewed, gridPoints[gpos].lvl1.f_viewed, gridPoints[gpos].lvl0.f_hidden, gridPoints[gpos].lvl1.f_hidden, gridPoints[gpos].lvl0.i_type, gridPoints[gpos].lvl1.i_type, gridPoints[gpos].lvl0.i_id, gridPoints[gpos].lvl1.i_id, gridPoints[gpos].lvl0.f_shadow, gridPoints[gpos].lvl1.f_shadow);

			gridOutputText->text(5, buf);

			if (clickedX != -1 && clickedY != -1) {
				if (clickedX == gx) { i = abs(clickedY - gy) * 5; }
				else {
					if (clickedY == gy) { i = abs(clickedX - gx) * 5; }
					else { i = (abs(clickedY - gy) * abs(clickedY - gy)) + (abs(clickedX - gx) * abs(clickedX - gx)); i = (int )sqrt(i)*5; }
				}
//printf("D = %d/%d %d/%d  = %d/%d = %d\n", clickedX, clickedY, gx, gy, abs(clickedX - gx), abs(clickedY - gy), i);
				sprintf(buf, "Distance = %d", i);
				gridOutputText->text(3, buf);
			} else {
				gridOutputText->text(3, "");
			}
		}
//printf("At location: %d/%d (%d)\n", gx, gy, gridPoints[gpos].lvl0.i_type);

			// save a backup copy to undo just incase
		if (gridMode != MODE_COMBAT && gridMode != MODE_COPYOBJECT) { saveMapToTemp(); }

		switch (gridMode) {
			case MODE_COMBAT:
//					clickedX = gx; clickedY = gy;
//					if (Fl::event_button() == 3 && eventHandler != NULL) {	// RMB
//						(*eventHandler)();
//					}
						// if it's a player/monster/object set the start X/Y as the things map x/y and a left mouse button click
					if ((gridPoints[gpos].lvl0.i_type == GRID_PLAYER || gridPoints[gpos].lvl0.i_type == GRID_MONSTER) && Fl::event_button() == FL_LEFT_MOUSE) {
						xAdjust = gx - playerData[gridPoints[gpos].lvl0.i_id].i_mapX;
						yAdjust = gy - playerData[gridPoints[gpos].lvl0.i_id].i_mapY;
						clickedX = playerData[gridPoints[gpos].lvl0.i_id].i_mapX;
						clickedY = playerData[gridPoints[gpos].lvl0.i_id].i_mapY;
						return 1;
					}
					if ((gridPoints[gpos].lvl0.i_type == GRID_OBJECT) && Fl::event_button() == FL_LEFT_MOUSE) {
						xAdjust = gx - objectData[gridPoints[gpos].lvl0.i_id].i_gridX;
						yAdjust = gy - objectData[gridPoints[gpos].lvl0.i_id].i_gridY;
						clickedX = objectData[gridPoints[gpos].lvl0.i_id].i_gridX;
						clickedY = objectData[gridPoints[gpos].lvl0.i_id].i_gridY;
//printf("obj: %d %d/%d %d/%d\n", gridPoints[gpos].lvl0.i_id, clickedX, clickedY, xAdjust, yAdjust);
						return 1;
					}
					if ((gridPoints[gpos].lvl0.i_type == GRID_BACKGROUND) && Fl::event_button() == FL_LEFT_MOUSE && Fl::event_clicks() == 0) {
						clickedX = gx;
						clickedY = gy;
//printf("bg: %d/%d = %d\n", clickedX, clickedY, getGridType(clickedX, clickedY));
						return 1;
					}
					break;

			case MODE_FREESTYLE:
					if (Fl::event_button() == FL_LEFT_MOUSE) { setGridColor(gx, gy, currColor); prevX = gx; prevY = gy; }
					break;

			case MODE_LINES:
					if (prevEvent == FL_PUSH && Fl::event_button() == FL_LEFT_MOUSE) {
						drawLine(clickedX, clickedY, gx, gy);
					}
					break;

			case MODE_SHAPES:
					if (Fl::event_button() == FL_LEFT_MOUSE) {
						drawShape(gx, gy);
					}
					break;

			case MODE_COPYOBJECT:
//printf("in CopyObj: %d/%d %d/%d\n", copyObjX, copyObjY, gx, gy);
					if (copyObjX == -1 || copyObjY == -1) {
						copyObjX = gx; copyObjY = gy;
					} else {
						copyObject(copyObjX, copyObjY, gx, gy);
					}
					break;

			case ACTION_CLEARMAP:
					if (Fl::event_button() == FL_LEFT_MOUSE) { setGridColor(gx, gy, 99); prevX = gx; prevY = gy; }
					break;
		}
		prevEvent = FL_PUSH;
		clickedX = gx; clickedY = gy;
		if (Fl::event_button() == FL_RIGHT_MOUSE && eventMapHandler != NULL) {	// RMB - do popup menu
			(*eventMapHandler)();
		}
	} else if (event == FL_KEYDOWN) {
		i = Fl::event_key();
//printf("Event: E=%d KB=%d:%s\n", event, i, Fl::event_text());
		if (i == 65362) {		// UP
			centreMap(prevCentreX+0, prevCentreY-1); parent->draw();
		} else if (i == 65364) {	// DOWN
			centreMap(prevCentreX+0, prevCentreY+1); parent->draw();
		} else if (i == 65361) { 	// LEFT
			centreMap(prevCentreX-1, prevCentreY+0); parent->draw();
		} else if (i == 65363) { 	// RIGHT
			centreMap(prevCentreX+1, prevCentreY+0); parent->draw();
		}
	} else {
		if ((i = gridPoints[gpos].lvl0.i_type) != 0 && gridOutputText != NULL) {
			gpos = gridPoints[gpos].lvl0.i_id;
			buf[0] = '\0';
			if (i == GRID_OBJECT && i < MAX_OBJECTS) { 
				if (objectData != NULL) {
					if (objectData[gpos].f_hidden == 1) {
						sprintf(buf, "%d %s Hidden", gpos, objectData[gpos].c_description);
					} else {
						sprintf(buf, "%d %s", gpos, objectData[gpos].c_description);
					}
				}
				gridOutputText->text(2, "");
				gridOutputText->text(3, "");
			} else if (gpos < MAX_MEMBERS && (i == GRID_PLAYER || i == GRID_MONSTER)) { 
				if (playerData != NULL && playerData[gpos].i_hp[HP_MAX] > 0 && playerData[gpos].c_name[0] != '\0') {
					if ((playerData[gpos].i_hp[HP_CUR] + playerData[i].i_hp[HP_ADJ]) < 0) {
						//sprintf(buf, "%d%% Attks:%d/%d Flag:", ((playerData[gpos].i_hp[HP_CUR] + playerData[i].i_hp[HP_ADJ]) * 10), playerData[gpos].i_doneAttacks, playerData[gpos].i_noAttacks);
						sprintf(buf, "%d%% Attks:%d/%d Flag:", playerData[gpos].i_health, playerData[gpos].i_doneAttacks, playerData[gpos].i_noAttacks);
						if (playerData[gpos].flags.f_invisible == 1) { strcat(buf, "H"); }
						if (playerData[gpos].flags.f_disabled == 1) { strcat(buf, "D"); }
						if (playerData[gpos].i_penalty[PENALTY_EXHAUSTION] > 0) { strcat(buf, "E"); }
						if (playerData[gpos].flags.f_massUnit == 1 && playerData[gpos].flags.f_massStatus == 1) { strcat(buf, "Br"); }
						if (playerData[gpos].flags.f_massUnit == 1 && playerData[gpos].flags.f_massStatus == 2) { strcat(buf, "Ha"); }
					} else {
						//sprintf(buf, "%d%% (%d) Attks:%d/%d Flag:", ((playerData[gpos].i_hp[HP_CUR] + playerData[i].i_hp[HP_ADJ]) * 100) / playerData[gpos].i_hp[HP_MAX], (playerData[gpos].i_hp[HP_CUR] + playerData[i].i_hp[HP_ADJ]), playerData[gpos].i_doneAttacks, playerData[gpos].i_noAttacks);
						sprintf(buf, "%d%% (%d) Attks:%d/%d Flag:", playerData[gpos].i_health, (playerData[gpos].i_hp[HP_CUR] + playerData[i].i_hp[HP_ADJ]), playerData[gpos].i_doneAttacks, playerData[gpos].i_noAttacks);
						if (playerData[gpos].flags.f_invisible == 1) { strcat(buf, "H"); }
						if (playerData[gpos].flags.f_disabled == 1) { strcat(buf, "D"); }
						if (playerData[gpos].i_penalty[PENALTY_EXHAUSTION] > 0) { strcat(buf, "E"); }
						if (playerData[gpos].flags.f_massUnit == 1 && playerData[gpos].flags.f_massStatus == 1) { strcat(buf, "Br"); }
						if (playerData[gpos].flags.f_massUnit == 1 && playerData[gpos].flags.f_massStatus == 2) { strcat(buf, "Ha"); }
					}
					gridOutputText->text(2, buf);
					if (playerData[gpos].i_noInGroup > 0) {
						sprintf(buf, "#In Group: %d", playerData[gpos].i_noInGroup); gridOutputText->text(4, buf);
					}
					sprintf(buf, "Spd:%d AC:%d %s", playerData[gpos].i_speed, playerData[gpos].i_armorClass[AC_NORMAL], playerData[gpos].c_name);
					if (playerData[gpos].i_spellPoints[MAX] > 0) {
						sprintf(buf1, " SPt: %d/%d", playerData[gpos].i_spellPoints[TMP], playerData[gpos].i_spellPoints[MAX]);
						strcat(buf, buf1);
					}
					if (groupData != NULL && playerData[gpos].i_inGroup != -1) {
						gridOutputText->text(3, groupData[playerData[gpos].i_inGroup].c_description);
					} else {
						gridOutputText->text(3, "");
					}
				}
			}
			gridOutputText->text(1, buf);
			if (buf[0] == '\0') { gridOutputText->text(2, ""); }
		} else {
			gridOutputText->text(1, "");
			gridOutputText->text(2, "");
			gridOutputText->text(3, "");
		}
//printf("Event: E=%d B=%d S=%d X=%d Y=%d\n", event, Fl::event_button(), Fl::event_state(), Fl::event_x(), Fl::event_y());
	}
	return 1;
}

//*****************************************************************************************
gridTile::gridTile(int X, int Y, int W, int H) : Fl_Tile(X,Y,W,H) {
	int i;

	colorMap[0] = FL_WHITE;		// backgroup color
	colorMap[1] = (Fl_Color)16;		// grid line color
	colorMap[2] = FL_RED;		// object color
	colorMap[3] = FL_YELLOW;	// player color
	colorMap[4] = (Fl_Color)61;		// monster color

	colorMap[5] = (Fl_Color)93;	
	colorMap[6] = (Fl_Color)3;	
	colorMap[7] = (Fl_Color)1;	
	colorMap[8] = (Fl_Color)63;	
	colorMap[9] = (Fl_Color)130;	
	colorMap[10] = (Fl_Color)7;	
	colorMap[11] = (Fl_Color)9;	
	colorMap[12] = (Fl_Color)19;	

	colorMap[13] = (Fl_Color)92;	
	colorMap[14] = (Fl_Color)2;	
	colorMap[15] = (Fl_Color)1;	
	colorMap[16] = (Fl_Color)61;	
	colorMap[17] = (Fl_Color)140;	
	colorMap[18] = (Fl_Color)5;	
	colorMap[19] = (Fl_Color)6;	
	colorMap[20] = (Fl_Color)16;	
	colorMap[21] = (Fl_Color)24;	
	colorMap[22] = (Fl_Color)59;	
	colorMap[23] = (Fl_Color)219;	

	colorMap[24] = (Fl_Color)92;	
	colorMap[25] = (Fl_Color)2;	
	colorMap[26] = (Fl_Color)1;	
	colorMap[27] = (Fl_Color)61;	
	colorMap[28] = (Fl_Color)14;	
	colorMap[29] = (Fl_Color)5;	
	colorMap[30] = (Fl_Color)6;	
	colorMap[31] = (Fl_Color)16;	

	gridSize = gridWidth = gridHeight = gridSizePtr = 0;
	gridTopX = gridTopY = gridMode = gridLayer = 0;
	clickedX = clickedY = prevEvent = gridType = gridVisibility = 0;
	deltaX = deltaY = currColor = currShape = 0;
	shapeWidth = shapeHeight = shapeFill = 0;
	prevX = prevY = undoMapCnt = 0;
	prevCentreX = prevCentreY = 0;
	copyObjX = copyObjY = 0;

	losAlgorithm = 0;

	gridSizes[0]=-1;
	gridSizes[1]=5;
	for (i=2; i<35; i++) {
		//gridSizes[i] = 3 + (2.9 * (i-1));
		gridSizes[i] = i * 5.5;
	}
	gridSizes[i]=-1;
	gridPoints = NULL;

	gridSize = GRIDSIZE;
	gridSizePtr=6;

	gridTopX = gridTopY = 0;

	gridMode = ACTION_COMBAT;
	clickedX = clickedY = -1;

	gridOutputText = NULL;

	externalTile = NULL;

	eventMapHandler = NULL;
	eventTileHandler = NULL;

	gridType = deltaX = deltaY = 0;
	prevCentreX = prevCentreY = -1;

	gridVisibility = 13;		// 60'

	currColor = 1;

	shapeWidth = shapeHeight = 20; shapeFill = 0;

	f_fogOfWar = undoMapCnt = 0;

	playerData = NULL; objectData = NULL;
	for (i=0; i<MAX_MEMBERS; i++) { playerIcons[i] = objectIcons[i] = inactiveIcons[i] = NULL; }
	for (i=0; i<16; i++) { texture[i] = NULL; }

//	losGridSize = 21; 
//	if ((losGrid = (losPoint *)malloc(losGridSize*losGridSize*sizeof(losPoint))) == NULL) {
//		printf("Unable to make losGrid .. bye\n");
//		exit(0);
//	}
//	memset(losGrid, '\0', (losGridSize*losGridSize*sizeof(losPoint)));

	vbar = hbar = NULL;

	setGridSize(MAPSIZE,MAPSIZE);		// make the memory array

	timerMinutes = timerStart = 0;
}

//*****************************************************************************************
int gridTile::getGridSize() {
	return gridSize;
}

//*****************************************************************************************
int gridTile::setGridSize(int sz) {
	gridSizePtr += sz;
	if (gridSizes[gridSizePtr] == -1) { gridSizePtr -= sz; return 0; }
	gridSize = gridSizes[gridSizePtr];
//printf("gridTile::setGridSize = %d:%d\n", gridSizePtr, gridSizes[gridSizePtr]);
	repaint();
	return 0;
}

//*****************************************************************************************
int gridTile::setGridSize(int sx, int sy) {
//printf("gridTile::setGridSize %d = %d:%d\n", gridType, sx, sy);
	gridWidth = sx; gridHeight = sy;

	if (gridType == 1) { return 1; }
	if (gridPoints != NULL) { free(gridPoints); }

	gridPoints = (gridPoint *)malloc(sy*sx*sizeof(gridPoint));

//printf("Map Mem Sz = %d / %d\n", (sy*sx*sizeof(gridPoint)), (sy*sx*sizeof(gridNewPoint)));

	memset(gridPoints, '\0', (sy*sx*sizeof(gridPoint)));

	if (externalTile != NULL) { externalTile->setGridArray(gridPoints); externalTile->setGridSize(sx, sy); }

//	if (vbar != NULL) { vbar->maximum(sx); vbar->linesize(sx/13); }
//	if (hbar != NULL) { hbar->maximum(sy); hbar->linesize(sy/13); }

	return 0;
}

//*****************************************************************************************
int gridTile::setGridColor(int sx, int sy, int color) {
	int pos;

	pos = sx+(sy*gridWidth);

//printf("gridTile::setGridColor %d %d = %d/%d\n", sx, sy, color, gridPoints[pos].lvl1.i_color );
	if (gridType == 1) { return 1; }

	if (sx < 0 || sy < 0) { return 0; }
	if (sx > gridWidth) { sx = gridWidth; }
	if (sy > gridHeight) { sy = gridHeight; }
	
	if (color == 99) {
		gridPoints[pos].lvl0.i_id = gridPoints[pos].lvl0.i_type = gridPoints[pos].lvl0.i_color = gridPoints[pos].lvl0.f_viewed = gridPoints[pos].lvl0.f_hidden = gridPoints[pos].lvl0.f_shadow = 0;
		gridPoints[pos].lvl1.i_id = gridPoints[pos].lvl1.i_type = gridPoints[pos].lvl1.i_color = gridPoints[pos].lvl1.f_viewed = gridPoints[pos].lvl1.f_hidden = gridPoints[pos].lvl1.f_shadow = 0;
		gridPoints[pos].lvl2.i_id = gridPoints[pos].lvl2.i_type = gridPoints[pos].lvl2.i_color = gridPoints[pos].lvl2.f_viewed = gridPoints[pos].lvl2.f_hidden = gridPoints[pos].lvl2.f_shadow = 0;
		gridPoints[pos].lvl3.i_id = gridPoints[pos].lvl3.i_type = gridPoints[pos].lvl3.i_color = gridPoints[pos].lvl3.f_viewed = gridPoints[pos].lvl3.f_hidden = gridPoints[pos].lvl3.f_shadow = 0;
	} else {
		gridPoints[pos].lvl1.i_color = gridPoints[pos].lvl0.i_color;
		gridPoints[pos].lvl0.i_color = color;
		//if (gridPoints[pos].lvl0.i_type != 0) { gridPoints[pos].lvl1.i_color = color; }
	}

	repaint();
	return 0;
}

//*****************************************************************************************
int gridTile::setGridType(int sx, int sy, int type, int id) {
	int pos;

	if (gridType == 1) { return 1; }

	if (sx < 0 || sy < 0) { return 0; }
	if (sx > gridWidth) { sx = gridWidth; }
	if (sy > gridHeight) { sy = gridHeight; }

//printf("sGT C%d:%d V%d:%d H%d:%d T%d:%d I%d:%d S%d:%d\n", gridPoints[pos].lvl0.i_color, gridPoints[pos].lvl1.i_color, gridPoints[pos].lvl0.f_viewed, gridPoints[pos].lvl1.f_viewed, gridPoints[pos].lvl0.f_hidden, gridPoints[pos].lvl1.f_hidden, gridPoints[pos].lvl0.i_type, gridPoints[pos].lvl1.i_type, gridPoints[pos].lvl0.i_id, gridPoints[pos].lvl1.i_id, gridPoints[pos].lvl0.f_shadow, gridPoints[pos].lvl1.f_shadow);

	pos = sx+(sy*gridWidth);
	//pushGP(sx, sy);		// NGP

	gridPoints[pos].lvl0.i_type = type;
	gridPoints[pos].lvl0.i_id = id;

	if (gridType == 0 && type == GRID_PLAYER) {
		setLineOfSight(sx, sy, gridVisibility, id);
	}

	if (externalTile != NULL) { externalTile->redraw(); }

//	if (type != 0) { gridPoints[pos].lvl1.i_color = gridPoints[pos].lvl0.i_color; }

	if (playerData != NULL && (type == GRID_PLAYER || type == GRID_MONSTER)) {
/*
		if (playerData[id].i_mapX != -1 || playerData[id].i_mapY != -1) {
			pos = playerData[id].i_mapX + (playerData[id].i_mapY * gridWidth);
			type = gridPoints[pos].lvl0.i_type;
			if ((type == GRID_PLAYER || type == GRID_MONSTER) && gridPoints[pos].lvl0.i_id == id) {
				gridPoints[pos].lvl0.i_type = gridPoints[pos].lvl0.i_id = gridPoints[pos].lvl1.i_id = 0;
			}
		}
*/
		playerData[id].i_mapX = sx; playerData[id].i_mapY = sy;
		if (playerData[id].i_space > 5) { setShadow(sx, sy, id, type, (playerData[id].i_space/5), (playerData[id].i_space/5), 1); }
	// todo
//		gridPoints[pos].lvl1.f_viewed = 1;
	}
	if (objectData != NULL && type == GRID_OBJECT) {
		setShadow(sx, sy, id, GRID_OBJECT, objectData[id].i_width/5, objectData[id].i_height/5, 1);
	}

//	if (gridType == 1 && externalTile != NULL) { externalTile->setGridPoint(pos, &gridPoints[pos]); }

//printf("sGT C%d:%d V%d:%d H%d:%d T%d:%d I%d:%d S%d:%d\n", gridPoints[pos].lvl0.i_color, gridPoints[pos].lvl1.i_color, gridPoints[pos].lvl0.f_viewed, gridPoints[pos].lvl1.f_viewed, gridPoints[pos].lvl0.f_hidden, gridPoints[pos].lvl1.f_hidden, gridPoints[pos].lvl0.i_type, gridPoints[pos].lvl1.i_type, gridPoints[pos].lvl0.i_id, gridPoints[pos].lvl1.i_id, gridPoints[pos].lvl0.f_shadow, gridPoints[pos].lvl1.f_shadow);

	return 0;
}

//*****************************************************************************************
int gridTile::setColorMap(int x, Fl_Color color) {
	if (x < 0 || x > MAX_COLORS) { printf("gridTile::setColorMap: error (%d)\n", x); return 0; }
	colorMap[x] = color;
	if (externalTile != NULL) { externalTile->setColorMap(x, color); }
	return 0;
}

//*****************************************************************************************
Fl_Color gridTile::getColorMap(int x) {
	if (x < 0 || x > MAX_COLORS) { printf("gridTile::getColorMap: error (%d)\n", x); return colorMap[0]; }
	return colorMap[x];
}

//*****************************************************************************************
int gridTile::setGridTop(int x, int y) {
	int nx, ny;

//printf("gridTile::setGridTop %d:%d\n", x, y);
	nx = (w() / gridSize);
	ny = (h() / gridSize);

	if (x < 0) { x = 0; }
	if (y < 0) { y = 0; }

	if ((x + nx) > gridWidth) { x =  gridWidth - nx; }
	if ((y + ny) > gridHeight) { y = gridHeight - ny; }

	gridTopX = x; gridTopY = y;

	repaint();
	return 0;
}

//*****************************************************************************************
int gridTile::getGridTopX() {
	return gridTopX;
}

//*****************************************************************************************
int gridTile::getGridTopY() {
	return gridTopY;
}

//*****************************************************************************************
void gridTile::moveGridPoint(int ox, int oy, int nx, int ny) {
	int opos, npos, sz=1, id=-1, ty=-1;
	int w, h, i;

	if (gridType == 1) { return; }

	if (ox == nx && oy == ny) { return; }
	if (ox < 0 || oy < 0) { return; }
	if (nx < 0 || ny < 0) { return; }
	if (ox >= gridWidth) { return; }
	if (oy >= gridHeight) { return; }
	if (nx >= gridWidth) { nx = gridWidth-2; }
	if (ny >= gridHeight) { ny = gridHeight-2; }

	opos = ox+(oy*gridWidth); npos = nx+(ny*gridWidth);
	id = gridPoints[opos].lvl0.i_id;
	ty = gridPoints[opos].lvl0.i_type;

//printf("gridTile::moveGridPoint %d/%d => %d/%d (%d/%d)\n", ox,oy, nx,ny, id, ty);

		// dont allow them to drag a shadow
	if (ty != 0 && gridPoints[opos].lvl0.f_shadow == 1) {
		return;
	}

	if (ty == GRID_OBJECT) {
		nx -= xAdjust; ny -= yAdjust; 
		if (nx < 0) { nx = 0; }
		if (ny < 0) { ny = 0; }
		npos = nx+(ny*gridWidth);
		w = objectData[id].i_width/5; h = objectData[id].i_height/5;
		//setShadow(px, py, id, ty, w, h, 0);
		popGP(ox, oy, w, h, id, ty);
		pushGP(nx, ny, w, h);
		setShadow(nx, ny, id, ty, w, h, 1);
		reorgGP(nx, ny, w, h);
		objectData[id].i_gridX = nx; objectData[id].i_gridY = ny;
		setLOSAll();
		repaint();
		return;
	}

	if (ty == GRID_BACKGROUND) {
		w = objectData[id].i_width; h = objectData[id].i_height;
		//setShadow(px, py, id, ty, w, h, 0);
		popGP(ox, oy, w, h, id, ty);
		pushGP(nx, ny, w, h);
		setShadow(nx, ny, id, ty, w, h, 1);
		objectData[id].i_gridX = nx; objectData[id].i_gridY = ny;
		reorgGP(nx, ny, w, h);
/*
		for (int i=0; i<MAX_OBJECTS; i++) {				// auto remap object JIC
			if (objectData[i].i_type == GRID_OBJECT) {
				setShadow(objectData[i].i_gridX, objectData[i].i_gridY, i, GRID_OBJECT, objectData[i].i_width/5, objectData[i].i_height/5, 1);
			}
		}
*/
		repaint();
		return;
	}

	if (ty == GRID_PLAYER || ty == GRID_MONSTER) {
		if (playerData != NULL) {
			sz = playerData[id].i_space / 5;
			if (sz > 1) { 
				nx -= xAdjust; ny -= yAdjust; 
				if (nx < 0) { nx = 0; }
				if (ny < 0) { ny = 0; }
				npos = nx+(ny*gridWidth);
//printf("mGP: %d/%d %d/%d\n", xAdjust, yAdjust, nx, ny);
				pushGP(nx, ny, sz, sz);
				gridPoints[npos].lvl0.i_type = gridPoints[opos].lvl0.i_type;
				gridPoints[npos].lvl0.i_id = gridPoints[opos].lvl0.i_id;
				gridPoints[npos].lvl0.i_color = gridPoints[opos].lvl0.i_color;
				gridPoints[npos].lvl0.f_viewed = gridPoints[opos].lvl0.f_viewed;
				gridPoints[npos].lvl0.f_hidden = gridPoints[opos].lvl0.f_hidden;
				popGP(ox, oy, sz, sz, id, ty);
				setShadow(nx, ny, id, ty, sz, sz, 1);
				setGridPointViewed(nx, ny, sz, sz, gridPoints[npos].lvl0.f_viewed);
				if (autoCenterPlayerWindow == 1 && gridType == 0 && id == 0) {
					if (externalTile != NULL) { externalTile->centreMap(nx,ny); }
				}
				reorgGP(nx, ny, sz, sz);
			} else {
				pushGP(nx, ny);
				gridPoints[npos].lvl0.i_type = gridPoints[opos].lvl0.i_type;
				gridPoints[npos].lvl0.i_id = gridPoints[opos].lvl0.i_id;
				gridPoints[npos].lvl0.i_color = gridPoints[opos].lvl0.i_color;
				gridPoints[npos].lvl0.f_viewed = gridPoints[opos].lvl0.f_viewed;
				gridPoints[npos].lvl0.f_hidden = gridPoints[opos].lvl0.f_hidden;
				popGP(ox, oy);
			}
			playerData[id].i_mapX = nx; playerData[id].i_mapY = ny;
			gridPoints[npos].lvl0.f_shadow = 0;
			gridPoints[npos].lvl0.f_hidden = playerData[id].flags.f_invisible;
			setLOSAll();
			if (autoCenterPlayerWindow == 1 && gridType == 0 && id == 0) {
				if (externalTile != NULL) { externalTile->centreMap(nx,ny); }
			}
			repaint();
			return;
		}
	}

	if ((gridPoints[npos].lvl0.i_id == 0 && gridPoints[npos].lvl0.i_type == 0) || gridPoints[npos].lvl0.f_shadow == 1) {
		pushGP(nx, ny); // save what is there	NGP

		if (gridPoints[npos].lvl0.i_type == GRID_BACKGROUND) { gridPoints[npos].lvl1.i_id = gridPoints[npos].lvl0.i_id; }

		if (gridPoints[npos].lvl0.f_shadow == 1) { gridPoints[npos].lvl0.f_shadow = 0; }

		gridPoints[npos].lvl0.i_color = gridPoints[opos].lvl0.i_color;
		gridPoints[npos].lvl0.f_viewed = gridPoints[opos].lvl0.f_viewed;
		gridPoints[npos].lvl0.f_hidden = gridPoints[opos].lvl0.f_hidden;
		gridPoints[npos].lvl0.i_type = gridPoints[opos].lvl0.i_type;
		gridPoints[npos].lvl0.i_id = gridPoints[opos].lvl0.i_id;

		popGP(ox, oy); // restore what was there NGP
	}

	if (gridType == 0 && f_fogOfWar != 0) { doFogOfWar(); }

	if (gridType == 0 && gridPoints[npos].lvl0.i_type == GRID_PLAYER) {
		if (autoCenterPlayerWindow == 1 && gridType == 0 && id == 0) { if (externalTile != NULL) { externalTile->centreMap(nx,ny); } }

		if (gridType == 0 && f_fogOfWar == 0) { setLineOfSight(nx, ny, gridVisibility, gridPoints[npos].lvl0.i_id); }
	}

	repaint();
}

//*****************************************************************************************
void gridTile::setGridVisibility(int v) {
	switch (v) {
		case 0: gridVisibility = 1; break;
		case 1: gridVisibility = 5; break;
		case 2: gridVisibility = 7; break;
		case 3: gridVisibility = 13; break;
		case 4: gridVisibility = 19; break;
		case 5: gridVisibility = 25; break;
		case 6: gridVisibility = 41; break;
	}
}

//*****************************************************************************************
void gridTile::saveGridMap(char *n) {
	FILE *sm;
	int i=0, x, y;

	if ((sm = fopen(n, "w+")) != NULL) {
		fprintf(sm, "160\n"); 													// data version
		fprintf(sm, "1 %d %d\n", gridWidth, gridHeight);				// grid dimensions
		fprintf(sm, "2 ");
		for (i=0; i<MAX_COLORS; i++) { fprintf(sm, "%d ", colorMap[i]); }	// color map
		fprintf(sm, "\n");
			// dump object data
//		x = 0;
//		for (i=0; i<MAX_OBJECTS; i++) {
//			if (objectData[i].c_description[0] != '\0' || objectData[i].c_iconFile[0] != '\0') { x++; }
//		}
//
//		fprintf(sm, "%d\n", x);
		for (i=0; i<MAX_OBJECTS; i++) {
			y = strlen(objectData[i].c_description);
			if (objectData[i].c_description[y] == '\n') { objectData[i].c_description[y] = '\0'; }
			if (objectData[i].c_description[y+1] == '\n') { objectData[i].c_description[y+1] = '\0'; }
			if (objectData[i].c_description[y-1] == '\n') { objectData[i].c_description[y-1] = '\0'; }
			if (objectData[i].c_description[y-2] == '\n') { objectData[i].c_description[y-2] = '\0'; }
			y = strlen(objectData[i].c_iconFile);
			if (objectData[i].c_iconFile[y] == '\n') { objectData[i].c_iconFile[y] = '\0'; }
			if (objectData[i].c_iconFile[y+1] == '\n') { objectData[i].c_iconFile[y+1] = '\0'; }
			if (objectData[i].c_iconFile[y-1] == '\n') { objectData[i].c_iconFile[y-1] = '\0'; }
			if (objectData[i].c_iconFile[y-2] == '\n') { objectData[i].c_iconFile[y-2] = '\0'; }
			if (objectData[i].c_description[0] != '\0' || objectData[i].c_iconFile[0] != '\0') { 
				objectData[i].i_id = i;		// sometimes it gets reset to 0
				fprintf(sm, "3 %d|%s |%s |%d|%d|%d|%d|%d|%d|%s |%d|%d|\n", objectData[i].i_id, objectData[i].c_description, objectData[i].c_iconFile, objectData[i].i_width, objectData[i].i_height, objectData[i].i_type, objectData[i].i_gridX, objectData[i].i_gridY, objectData[i].i_gridSize, objectData[i].c_playericonFile, objectData[i].f_hidden, objectData[i].i_mirror); 
//printf("O = %d|%d|%s\n", i, objectData[i].lvl0.i_id, objectData[i].c_description, objectData[i].c_playericonFile);
			}
		}
			// save group name data
//		i = MAX_GROUPS; fprintf(sm, "%d\n", i);
		for (i=0; i<MAX_GROUPS; i++) { 
			if (strlen(groupData[i].c_description) > 0) { fprintf(sm, "4 %s\n", groupData[i].c_description); }
		}

			// TODO - screen size
		fprintf(sm, "5 %d %d %d 0 0 0 0\n", gridTopX, gridTopY, gridSizePtr); //, vbar->value(), hbar->value());

		for (y=0; y<gridHeight; y++) {
			i = y * gridWidth;
			for (x=0; x<gridWidth; x++) {
				if (gridPoints[i].lvl0.i_color !=0 || gridPoints[i].lvl1.i_color != 0 || gridPoints[i].lvl0.i_type != 0 || (hasBackGroundImage == 1 && gridPoints[i].lvl0.f_viewed == 1)) {
fprintf(sm, "9 %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n", x, y, gridPoints[i].lvl0.i_color, gridPoints[i].lvl0.i_id, gridPoints[i].lvl0.i_type, gridPoints[i].lvl0.f_viewed, gridPoints[i].lvl0.f_shadow, gridPoints[i].lvl0.f_hidden, gridPoints[i].lvl1.i_color, gridPoints[i].lvl1.i_id,
gridPoints[i].lvl1.i_type, gridPoints[i].lvl1.f_viewed, gridPoints[i].lvl1.f_shadow, gridPoints[i].lvl1.f_hidden, gridPoints[i].lvl2.i_color, gridPoints[i].lvl2.i_id, gridPoints[i].lvl2.i_type, gridPoints[i].lvl2.f_viewed,
gridPoints[i].lvl2.f_shadow, gridPoints[i].lvl2.f_hidden, gridPoints[i].lvl3.i_color, gridPoints[i].lvl3.i_id, gridPoints[i].lvl3.i_type, gridPoints[i].lvl3.f_viewed, gridPoints[i].lvl3.f_shadow, gridPoints[i].lvl3.f_hidden);
				}
				i++;
			}
		}
		fclose(sm);
	}
}

//*****************************************************************************************
void gridTile::loadGridMap(char *n) {
	FILE *sm;
	unsigned int i=0, x, y, version, j;
	int k;
	unsigned int lvl0_i_color=0, lvl0_i_id=0, lvl0_i_type=0, lvl0_f_viewed=0, lvl0_f_shadow=0, lvl0_f_hidden=0, lvl1_i_color=0, lvl1_i_id=0,
	 lvl1_i_type=0, lvl1_f_viewed=0, lvl1_f_shadow=0, lvl1_f_hidden=0, lvl2_i_color=0, lvl2_i_id=0, lvl2_i_type=0, lvl2_f_viewed=0,
	 lvl2_f_shadow=0, lvl2_f_hidden=0, lvl3_i_color=0, lvl3_i_id=0, lvl3_i_type=0, lvl3_f_viewed=0, lvl3_f_shadow=0, lvl3_f_hidden=0, i_mapLayer=0;
	unsigned int i_lastX, i_lastY, i_lastZoom;
	char buf[200], *cp, *cp2;
	int sliderX, sliderY;
	int grpIndx=0, objIndx=0;

	if ((sm = fopen(n, "r")) != NULL) {
		if (fgets(buf, 100, sm) == NULL) { return; }
		version = atoi(buf);

		if (version > 130) {
			while (fgets(buf, 190, sm) != NULL) {
				if ((cp = strstr(buf, "\r")) != NULL) {
					*cp = '\0'; // printf("\\r found ....\n");
				}
				if ((cp = strstr(buf, "\n")) != NULL) {
					*cp = '\0'; // printf("\\n found ....\n");
				}
				switch (buf[0]) {
					case '1':	// map dimensions
								k=sscanf(&buf[2], "%d %d", &gridWidth, &gridHeight);
//printf("gridTile::loadGridMap WH = %s %d/%d %d\n", n, gridWidth, gridHeight, version);
								setGridSize(gridWidth, gridHeight);
								memset(gridPoints, '\0', (gridWidth*gridHeight*sizeof(gridPoint)));
								break;
					case '2':	// color map
								cp = strtok(&buf[2], " "); colorMap[0] = (Fl_Color )atoi(cp);
								if (externalTile != NULL) { externalTile->setColorMap(0, colorMap[0]); }
								if (version < 150) {
									for (i=1; i<24; i++) {
										cp = strtok(NULL, " ");
										if (cp != NULL) {
											colorMap[i] = (Fl_Color )atoi(cp);
											if (externalTile != NULL) { externalTile->setColorMap(i, colorMap[i]); }
										}
									}
								} else {
									for (i=1; i<MAX_COLORS; i++) {
										cp = strtok(NULL, " ");
										if (cp != NULL) {
											colorMap[i] = (Fl_Color )atoi(cp);
											if (externalTile != NULL) { externalTile->setColorMap(i, colorMap[i]); }
										}
									}
								}
								for (i=1; i<MAX_COLORS; i++) {
									if (colorMap[i] < 0) { printf("color %d = %d\n", i, colorMap[i]); colorMap[i] = 1; }
								}
								break;
					case '3':	// object data
								if (objectData != NULL) { 
									cp = strtok(&buf[2], "|");
									if ((j = atoi(cp)) < MAX_OBJECTS) {
//printf("gridTile::loadGridMap = %d %d/%s\n", i, j, buf);
										objectData[j].i_id = j;
										if ((cp = strtok(NULL, "|")) != NULL) {
											strncpy(objectData[j].c_description, cp, MAX_OBJECTDESC-1); objectData[j].c_description[MAX_OBJECTDESC] = '\0';
//											if ((cp2 = rindex(objectData[j].c_description, ' ')) != NULL) {
											if ((cp2 = strrchr(objectData[j].c_description, ' ')) != NULL) {
												*cp2 = '\0';
											}
										}
										if ((cp = strtok(NULL, "|")) != NULL) {
											strncpy(objectData[j].c_iconFile, cp, 159); objectData[j].c_iconFile[159] = '\0';
											if ((cp2 = strrchr(objectData[j].c_iconFile, ' ')) != NULL) {
												*cp2 = '\0';
											}
										}
										if ((cp = strtok(NULL, "|")) != NULL) { objectData[j].i_width = atoi(cp); }
										if ((cp = strtok(NULL, "|")) != NULL) { objectData[j].i_height = atoi(cp); }
										if ((cp = strtok(NULL, "|")) != NULL) { objectData[j].i_type = atoi(cp); }
										if ((cp = strtok(NULL, "|")) != NULL) { objectData[j].i_gridX = atoi(cp); }
										if ((cp = strtok(NULL, "|")) != NULL) { objectData[j].i_gridY = atoi(cp); }
										if ((cp = strtok(NULL, "|")) != NULL) { objectData[j].i_gridSize = atoi(cp); }
										if ((cp = strtok(NULL, "|")) != NULL) {
											strncpy(objectData[j].c_playericonFile, cp, 159); objectData[j].c_playericonFile[159] = '\0';
											if ((cp2 = strrchr(objectData[j].c_playericonFile, ' ')) != NULL) {
												*cp2 = '\0';
											}
//printf("gridTile::loadGridMap = %d:%s:%s:\n", j, objectData[j].c_description, objectData[j].c_playericonFile);
										}
										if ((cp = strtok(NULL, "|")) != NULL) { objectData[j].f_hidden = atoi(cp); }
										objectData[j].i_mirror = 0;
										if ((cp = strtok(NULL, "|")) != NULL) { objectData[j].i_mirror = atoi(cp); }
										if (objectData[j].i_type == GRID_BACKGROUND) { hasBackGroundImage = 1; }
//printf("gridTile::loadGridMap = %d:%s:%s:\n", j, objectData[j].c_description, objectData[j].c_iconFile);
									}
								}
								break;
					case '4':	// group data
								if (groupData == NULL) { printf("groupData = NULL\n"); break; }
								i = grpIndx; grpIndx++;
								strncpy(groupData[i].c_description, &buf[2], 29); 
								x = strlen(groupData[i].c_description);
								if (x > 2) {
									if (groupData[i].c_description[x] == '\n') { groupData[i].c_description[x] = '\0'; }
									if (groupData[i].c_description[x-1] == '\n') { groupData[i].c_description[x-1] = '\0'; }
									if (groupData[i].c_description[x-2] == '\n') { groupData[i].c_description[x-2] = '\0'; }
								}
								if (x < 2) { sprintf(groupData[i].c_description, "Group - %d", grpIndx); }
								break;
					case '5':	// screen size, location etc
								k=sscanf(&buf[2], "%d %d %d %d %d %d %d", &i_lastX, &i_lastY, &i_lastZoom, &sliderX, &sliderY, &i, &k);
								//vbar->value(sliderX);
								//hbar->value(sliderY);
								//vbar->redraw();
								//hbar->redraw();
								gridTopX = i_lastX; gridTopY = i_lastY;
								gridSize = gridSizes[i_lastZoom];
								gridSizePtr = i_lastZoom;
								if (externalTile != NULL) { externalTile->centreMap(i_lastX, i_lastY); }
								prevCentreX = gridTopX + ((w()/gridSize) / 2);
								prevCentreY = gridTopY + ((h()/gridSize) / 2);
								break;
					case '6':	//
								break;
					case '7':	//
								break;
					case '8':	//
								break;
					case '9':	// grid point data
								if (version == 150) {
									k=sscanf(&buf[2], "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", &x, &y,
									&lvl0_i_color, &lvl1_i_color, &lvl0_f_viewed, &lvl0_f_hidden, &lvl0_i_type, &i_mapLayer, &lvl1_i_id, &lvl0_i_id,
									&lvl1_f_viewed, &lvl1_f_hidden, &lvl1_i_type, &lvl0_f_shadow, &lvl1_f_shadow);
									if (version == 145) {
										if (lvl0_i_color > 7) { lvl0_i_color += 8; }
										if (lvl1_i_color > 7) { lvl1_i_color += 8; }
									}
								} else if (version == 160) {
k=sscanf(&buf[2], "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", &x, &y, &lvl0_i_color, &lvl0_i_id, &lvl0_i_type, &lvl0_f_viewed, &lvl0_f_shadow, &lvl0_f_hidden, &lvl1_i_color, &lvl1_i_id, &lvl1_i_type, &lvl1_f_viewed, &lvl1_f_shadow, &lvl1_f_hidden, 
&lvl2_i_color, &lvl2_i_id, &lvl2_i_type, &lvl2_f_viewed, &lvl2_f_shadow, &lvl2_f_hidden, &lvl3_i_color, &lvl3_i_id, &lvl3_i_type, &lvl3_f_viewed, &lvl3_f_shadow, &lvl3_f_hidden);
									if (lvl0_i_type == GRID_BACKGROUND) {
										if (lvl1_i_type == GRID_BACKGROUND) {
printf("lGM: 0 1 BGI fixed\n");
											lvl1_i_type = lvl1_i_id = 0;
										}
										if (lvl2_i_type == GRID_BACKGROUND) {
printf("lGM: 0 2 BGI fixed\n");
											lvl2_i_type = lvl2_i_id = 0;
										}
										if (lvl3_i_type == GRID_BACKGROUND) {
printf("lGM: 0 3 BGI fixed\n");
											lvl3_i_type = lvl3_i_id = 0;
										}
									} else if (lvl1_i_type == GRID_BACKGROUND) {
										if (lvl2_i_type == GRID_BACKGROUND) {
printf("lGM: 1 2 BGI fixed\n");
											lvl2_i_type = lvl2_i_id = 0;
										}
										if (lvl3_i_type == GRID_BACKGROUND) {
printf("lGM: 1 3 BGI fixed\n");
											lvl3_i_type = lvl3_i_id = 0;
										}
									} else if (lvl2_i_type == GRID_BACKGROUND) {
										if (lvl3_i_type == GRID_BACKGROUND) {
printf("lGM: 2 3 BGI fixed\n");
											lvl3_i_type = lvl3_i_id = 0;
										}
									}
								} else {
									k=sscanf(&buf[2], "%d %d %d %d %d %d %d %d %d %d %d %d %d", &x, &y,
									&lvl0_i_color, &lvl1_i_color, &lvl0_f_viewed, &lvl0_f_hidden, &lvl0_i_type, &i_mapLayer, &lvl1_i_id, &lvl0_i_id,
									&lvl1_f_viewed, &lvl1_f_hidden, &lvl1_i_type);
								}
								if (x < gridWidth && y < gridHeight) {
									i = x + (y * gridWidth);
									gridPoints[i].lvl0.i_id = lvl0_i_id;
									gridPoints[i].lvl0.i_type = lvl0_i_type;
									gridPoints[i].lvl0.i_color = lvl0_i_color;
									gridPoints[i].lvl0.f_viewed = lvl0_f_viewed;
									gridPoints[i].lvl0.f_hidden = lvl0_f_hidden;
									gridPoints[i].lvl0.f_shadow = lvl0_f_shadow;
									gridPoints[i].lvl1.i_id = lvl1_i_id;
									gridPoints[i].lvl1.i_type = lvl1_i_type;
									gridPoints[i].lvl1.i_color = lvl1_i_color;
									gridPoints[i].lvl1.f_viewed = lvl1_f_viewed;
									gridPoints[i].lvl1.f_hidden = lvl1_f_hidden;
									gridPoints[i].lvl1.f_shadow = lvl1_f_shadow;
									gridPoints[i].lvl2.i_id = lvl2_i_id;
									gridPoints[i].lvl2.i_type = lvl2_i_type;
									gridPoints[i].lvl2.i_color = lvl2_i_color;
									gridPoints[i].lvl2.f_viewed = lvl2_f_viewed;
									gridPoints[i].lvl2.f_hidden = lvl2_f_hidden;
									gridPoints[i].lvl2.f_shadow = lvl2_f_shadow;
									gridPoints[i].lvl3.i_id = lvl3_i_id;
									gridPoints[i].lvl3.i_type = lvl3_i_type;
									gridPoints[i].lvl3.i_color = lvl3_i_color;
									gridPoints[i].lvl3.f_viewed = lvl3_f_viewed;
									gridPoints[i].lvl3.f_hidden = lvl3_f_hidden;
									gridPoints[i].lvl3.f_shadow = lvl3_f_shadow;
									//gridPoints[i].i_mapLayer = i_mapLayer;
									if (playerData != NULL && (lvl0_i_type == GRID_PLAYER || lvl0_i_type == GRID_MONSTER) && lvl0_f_shadow == 0) {
										if (lvl0_i_id < MAX_MEMBERS) { playerData[lvl0_i_id].i_mapX = x; playerData[lvl0_i_id].i_mapY = y; }
									}
								}
								break;
				}
			}
		} else {
			fgets(buf, 100, sm); cp = strtok(buf, " "); gridWidth = atoi(cp); cp = strtok(NULL, " "); gridHeight = atoi(cp);
	//printf("gridTile::loadGridMap WH = %s %d/%d %d\n", n, gridWidth, gridHeight, version);
			setGridSize(gridWidth, gridHeight);
			fgets(buf, 100, sm); cp = strtok(buf, " "); colorMap[0] = (Fl_Color )atoi(cp);
			for (i=1; i<16; i++) {
				cp = strtok(NULL, " ");
				colorMap[i] = (Fl_Color )atoi(cp);
				if (externalTile != NULL) { externalTile->setColorMap(i, colorMap[i]); }
			}
	//printf("gridTile::loadGridMap CM0 = %d\n", colorMap[0]);
			fgets(buf, 100, sm); i = atoi(buf);
			for (; i>0; i--) {
				fgets(buf, 100, sm);
	//printf("gridTile::loadGridMap = %d %d/%s\n", i, j, buf);
				if (objectData != NULL) { 
					cp = strtok(buf, "|");
					if ((j = atoi(cp)) < MAX_OBJECTS) {
	//printf("gridTile::loadGridMap = %d %d/%s\n", i, j, buf);
						objectData[j].i_id = j;
						if ((cp = strtok(NULL, "|")) != NULL) {
							strncpy(objectData[j].c_description, cp, MAX_OBJECTDESC-1); objectData[j].c_description[MAX_OBJECTDESC] = '\0';
//							if ((cp2 = rindex(objectData[j].c_description, ' ')) != NULL) {
							if ((cp2 = strrchr(objectData[j].c_description, ' ')) != NULL) {
								*cp2 = '\0';
							}
						}
						if ((cp = strtok(NULL, "|")) != NULL) {
							strncpy(objectData[j].c_iconFile, cp, 159); objectData[j].c_iconFile[159] = '\0';
//							if ((cp2 = rindex(objectData[j].c_iconFile, ' ')) != NULL) {
							if ((cp2 = strrchr(objectData[j].c_iconFile, ' ')) != NULL) {
								*cp2 = '\0';
							}
						}
						if ((cp = strtok(NULL, "|")) != NULL) { objectData[j].i_width = atoi(cp); }
						if ((cp = strtok(NULL, "|")) != NULL) { objectData[j].i_height = atoi(cp); }
	//printf("gridTile::loadGridMap = %d:%s:%s:\n", j, objectData[j].c_description, objectData[j].c_iconFile);
					}
				}
			}
			if (version > 110) {		// group info is now here
				fgets(buf, 100, sm); k = atoi(buf);
				for (i=0; i<k; i++) { 
					fgets(groupData[i].c_description, 29, sm); 
					x = strlen(groupData[i].c_description);
					if (groupData[i].c_description[x] == '\n') { groupData[i].c_description[x] = '\0'; }
					if (groupData[i].c_description[x-1] == '\n') { groupData[i].c_description[x-1] = '\0'; }
					if (groupData[i].c_description[x-2] == '\n') { groupData[i].c_description[x-2] = '\0'; }
	//printf("gridTile::loadGridMap = %s/%d\n", groupData[i].c_description, i);
	}
			}
	
			if (version > 120) {		// last location etc here
					// TODO - screen size
				k=fscanf(sm, "%d %d %d %d %d %d %d", &i_lastX, &i_lastY, &i_lastZoom, &sliderX, &sliderY, &i, &k);
				//vbar->value(sliderX);
				//hbar->value(sliderY);
				//vbar->redraw();
				//hbar->redraw();
				gridTopX = i_lastX; gridTopY = i_lastY;
				gridSize = gridSizes[i_lastZoom];
				gridSizePtr = i_lastZoom;
				if (externalTile != NULL) { externalTile->centreMap(i_lastX, i_lastY); }
			}
	
			if (version == 100) {
				k=fscanf(sm, "%d %d %d %d %d %d %d %d %d %d", &x, &y,
				&lvl0_i_color, &lvl1_i_color, &lvl0_f_viewed, &lvl0_f_hidden, &lvl0_i_type, &i_mapLayer, &lvl1_i_id, &lvl0_i_id);
			} else {
				k=fscanf(sm, "%d %d %d %d %d %d %d %d %d %d %d %d %d", &x, &y,
				&lvl0_i_color, &lvl1_i_color, &lvl0_f_viewed, &lvl0_f_hidden, &lvl0_i_type, &i_mapLayer, &lvl1_i_id, &lvl0_i_id,
				&lvl1_f_viewed, &lvl1_f_hidden, &lvl1_i_type);
			}
			while (k != EOF) {
	//printf("gridTile::loadGridMap = %d/%d\n", x, y);
				if (x < gridWidth && y < gridHeight) {
					i = x + (y * gridWidth);
					gridPoints[i].lvl0.i_color = lvl0_i_color;
					gridPoints[i].lvl1.i_color = lvl1_i_color;
					gridPoints[i].lvl0.f_viewed = lvl0_f_viewed;
					gridPoints[i].lvl0.f_hidden = lvl0_f_hidden;
					gridPoints[i].lvl0.i_type = lvl0_i_type;
					//gridPoints[i].i_mapLayer = i_mapLayer;
					gridPoints[i].lvl1.i_id = lvl1_i_id;
					gridPoints[i].lvl0.i_id = lvl0_i_id;
					gridPoints[i].lvl1.f_viewed = lvl1_f_viewed;
					gridPoints[i].lvl1.f_hidden = lvl1_f_hidden;
					gridPoints[i].lvl1.i_type = lvl1_i_type;
					if (playerData != NULL && (lvl0_i_type == GRID_PLAYER || lvl0_i_type == GRID_MONSTER)) {
						if (lvl0_i_id < MAX_MEMBERS) { playerData[lvl0_i_id].i_mapX = x; playerData[lvl0_i_id].i_mapY = y; }
					}
				}
				if (version == 100) {
					k=fscanf(sm, "%d %d %d %d %d %d %d %d %d %d", &x, &y,
					&lvl0_i_color, &lvl1_i_color, &lvl0_f_viewed, &lvl0_f_hidden, &lvl0_i_type, &i_mapLayer, &lvl1_i_id, &lvl0_i_id);
				} else {
					k=fscanf(sm, "%d %d %d %d %d %d %d %d %d %d %d %d %d", &x, &y,
					&lvl0_i_color, &lvl1_i_color, &lvl0_f_viewed, &lvl0_f_hidden, &lvl0_i_type, &i_mapLayer, &lvl1_i_id, &lvl0_i_id,
					&lvl1_f_viewed, &lvl1_f_hidden, &lvl1_i_type);
				}
			}	
		}
	} else {
printf("loadGridMap - %s unable to open map ...\n", n);
		if (groupData == NULL) { printf("groupData = NULL\n"); } else {
			for (i=0; i<MAX_GROUPS; i++) { sprintf(groupData[i].c_description, "Group - %d", i); }
		}
	}
//reorgGP(0,0,gridWidth, gridHeight);
	repaint();
}

//*****************************************************************************************
void gridTile::drawLineOfSight(int x1, int y1, int x2, int y2, int pid) {
int deltax, deltay, x, y, xinc1, xinc2, yinc1, yinc2, den, num, numadd, numpixels, curpixel, pos, id;

//if (pid == 0) printf("gridTile::drawLineOfSight %d:%d - %d:%d\n", x1,y1, x2,y2);
	if (x2 > gridWidth) { x2 = gridWidth; }
	if (y2 > gridHeight) { y2 = gridHeight; }

	deltax = abs(x2 - x1);        // The difference between the x's
	deltay = abs(y2 - y1);        // The difference between the y's
	x = x1;                       // Start x off at the first pixel
	y = y1;                       // Start y off at the first pixel
		
	if (x2 >= x1)                 // The x-values are increasing
	{
		xinc1 = 1; xinc2 = 1;
	}
	else                          // The x-values are decreasing
	{
		xinc1 = -1; xinc2 = -1;
	}
		
	if (y2 >= y1)                 // The y-values are increasing
	{
		yinc1 = 1; yinc2 = 1;
	}
	else                          // The y-values are decreasing
	{
		yinc1 = -1; yinc2 = -1;
	}
		
	if (deltax >= deltay)         // There is at least one x-value for every y-value
	{
		xinc1 = 0;                  // Don't change the x when numerator >= denominator
		yinc2 = 0;                  // Don't change the y for every iteration
		den = deltax;
		num = deltax / 2;
		numadd = deltay;
		numpixels = deltax;         // There are more x-values than y-values
	}
	else                          // There is at least one y-value for every x-value
	{
		xinc2 = 0;                  // Don't change the x for every iteration
		yinc1 = 0;                  // Don't change the y when numerator >= denominator
		den = deltay;
		num = deltay / 2;
		numadd = deltax;
		numpixels = deltay;         // There are more y-values than x-values
	}
		
	for (curpixel = 0; curpixel <= numpixels; curpixel++) {
		if (x > -1 && y > -1) {
			pos = x + (y*gridWidth);
			if (hasBackGroundImage == 1) { gridPoints[pos].lvl0.f_viewed = 1; }
			if (gridPoints[pos].lvl0.i_color != 0 || gridPoints[pos].lvl0.i_type != 0) {		// if we hit a wall stop
				gridPoints[pos].lvl0.f_viewed = 1;
				id = gridPoints[pos].lvl0.i_id;
//if (pid == 0) printf("LoS: %d:%d = %d:%d\n", x, y, id, gridPoints[pos].lvl0.i_color);
				if (gridPoints[pos].lvl0.i_type == GRID_MONSTER && id != 0 && playerData[id].flags.f_invisible == 0) {
					playerData[id].flags.f_wasViewed = 1;
//if (pid == 0) printf("LoS: %d:%d = %d\n", x, y, id);
				}
			}
			//if ((gridPoints[pos].lvl0.i_color > 15 && gridPoints[pos].lvl0.i_color < 24) || gridPoints[pos].lvl0.i_color > 29) {		// if we hit anything stop
			if (gridPoints[pos].lvl0.i_color > 15) {		// if we hit anything stop
				if (gridPoints[pos].lvl0.i_type == GRID_PLAYER) {								// JIC ignore the players initial spot
					if (playerData[id].i_mapX != x && playerData[id].i_mapY != y) {
						break;
					}
				} else {
					if (gridPoints[pos].lvl0.i_color > 29) { gridPoints[pos].lvl0.f_viewed = 0; }
					break;
				}
			}
			num += numadd;              // Increase the numerator by the top of the fraction
			if (num >= den)             // Check if numerator >= denominator
			{
				num -= den;               // Calculate the new numerator value
				x += xinc1;               // Change the x as appropriate
				y += yinc1;               // Change the y as appropriate
			}
			x += xinc2;                 // Change the x as appropriate
			y += yinc2;                 // Change the y as appropriate
		}
	}
}

//*****************************************************************************************
void gridTile::checkLineOfSight(int cx, int cy, int x, int y, int id) {
	if (x > gridWidth) { x = gridWidth; }
	if (y > gridHeight) { y = gridHeight; }

	if (x == 0) {
		drawLineOfSight(cx, cy, cx, cy + y, id);
		drawLineOfSight(cx, cy, cx, cy - y, id);
		drawLineOfSight(cx, cy, cx + y, cy, id);
		drawLineOfSight(cx, cy, cx - y, cy, id);
	} else if (x == y) {
		drawLineOfSight(cx, cy, cx + x, cy + y, id);
		drawLineOfSight(cx, cy, cx - x, cy + y, id);
		drawLineOfSight(cx, cy, cx + x, cy - y, id);
		drawLineOfSight(cx, cy, cx - x, cy - y, id);
	} else if (x < y) {
		drawLineOfSight(cx, cy, cx + x, cy + y, id);
		drawLineOfSight(cx, cy, cx - x, cy + y, id);
		drawLineOfSight(cx, cy, cx + x, cy - y, id);
		drawLineOfSight(cx, cy, cx - x, cy - y, id);
		drawLineOfSight(cx, cy, cx + y, cy + x, id);
		drawLineOfSight(cx, cy, cx - y, cy + x, id);
		drawLineOfSight(cx, cy, cx + y, cy - x, id);
		drawLineOfSight(cx, cy, cx - y, cy - x, id);
	}
}

//*****************************************************************************************
void gridTile::setLOSGrid(int px, int py, int d) {
int sx, sy, mx, my, i=0, j=0, k, gp, lp;
char losID[MAX_MEMBERS];

//printf("gridTile::setLOSGrid = %d/%d\n", d, losGridSize);

	if (losAlgorithm != 1) { return; }

	if (d > losGridSize) {		// should we resize the losGrid
//printf("gridTile::setLOSGrid = %d/%d\n", d, losGridSize);
		d = losGridSize;
	}

	memset(losGrid, '\0', (losGridSize*losGridSize*sizeof(losPoint)));
	memset(losID, 255, MAX_MEMBERS);

	sx = px-d; if (sx < 0) { sy = 0; } 
	mx = px+d; if (mx >gridWidth) { mx = gridWidth; }

	sy = py-d; if (sy < 0) { sy = 0; } 
	my = py+d; if (my >gridHeight) { my = gridHeight; }
//printf("gridTile::setLOSGrid = %d/%d/%d %d:%d %d:%d\n", px, py, d, sx, sy, mx, my);

	j = i = 0;
	for ( ; sy <= my; sy++) {
		gp = (sy * gridWidth) + sx;
		lp = (j * losGridSize);
		k = sx;
//printf("\n%2.2d = ", j);
		for ( ; k <= mx; k++) {
			losGrid[lp].i_color = gridPoints[gp].lvl0.i_color;
			losGrid[lp].i_type = gridPoints[gp].lvl0.i_type;
			losGrid[lp].i_id = gridPoints[gp].lvl0.i_id;
//printf(" %d:%d:%d", losGrid[lp].lvl0.i_type, losGrid[lp].lvl0.i_id, losGrid[lp].lvl0.i_color);
			lp++; gp++;
		}
		j++;
	}
//printf("\n");

	for (j=0; j<losGridSize; j++) {
		lp = (j * losGridSize);
		for (i=0; i<losGridSize; i++) {
			if (losGrid[lp].i_type == GRID_MONSTER || losGrid[lp].i_type == GRID_PLAYER) {
				sx = losGrid[lp].i_id; k = (playerData[sx].i_space/5) - 1;
				if (losID[sx] != -1) { k = -1; }
//printf("Found %d = %d\n", sx, k);
				while (k > -1) {
					sy = (playerData[sx].i_space/5) - 1;
					gp = lp + (k * losGridSize);
					while (sy > -1) {
						if (losGrid[gp].i_type == 0 || losGrid[gp].i_color < 16) {
							losGrid[gp].i_type = losGrid[lp].i_type;
							losGrid[gp].i_id = losGrid[lp].i_id;
						}
						gp++; sy--;
					}
					k--;
				}
				losID[sx] = sx;
			}
			lp++;
		}
	}

	for (j=0; j<(d*2); j++) {
		lp = (j * losGridSize);
//printf("\n%2.2d = ", j);
		for (i=0; i<(d*2); i++) {
//printf(" %d:%d:%d", losGrid[lp].lvl0.i_type, losGrid[lp].lvl0.i_id, losGrid[lp].lvl0.i_color);
			lp++;
		}
	}
//printf("\n");
}

//*****************************************************************************************
void gridTile::setLineOfSight(int sx, int sy, int d, int id) {
int x = 0, y = d, p = (5 - d*4)/4, i, j, lp=0, nx, ny;

	if (gridType == 1) { return; }
//printf("gridTile::setLineOfSight %d:%d:%d:%d\n", sx,sy,d,id);

//	if (losAlgorithm == 1) {
//		setLOSGrid(sx, sy, d+3);
//		nx = -1; ny = -1;
//		for (j=0; j<losGridSize; j++) {
//			for (i=0; i<losGridSize; i++) {
//				if (losGrid[p].lvl0.i_id == id && losGrid[p].lvl0.i_type == GRID_PLAYER) {
//					nx = i; ny = j;
//					break;
//				}
//			}
//		}
//printf("gridTile::setLineOfSight %d:%d:%d\n", nx,ny,losGridSize);
//		if (nx == -1 || ny == -1) { return; }
//	} else {
		nx = sx; ny = sy;
//	}

	if (gridVisibility == 1 && hasBackGroundImage == 1) {
		x = nx - 1 + (ny*gridWidth); gridPoints[x].lvl0.f_viewed = 1;
		x = nx + 1 + (ny*gridWidth); gridPoints[x].lvl0.f_viewed = 1;
		x = nx - 1 + ((ny - 1)*gridWidth); gridPoints[x].lvl0.f_viewed = 1;
		x = nx + 1 + ((ny - 1)*gridWidth); gridPoints[x].lvl0.f_viewed = 1;
		x = nx  + ((ny - 1)*gridWidth); gridPoints[x].lvl0.f_viewed = 1;
		x = nx - 1 + ((ny + 1)*gridWidth); gridPoints[x].lvl0.f_viewed = 1;
		x = nx + 1 + ((ny + 1)*gridWidth); gridPoints[x].lvl0.f_viewed = 1;
		x = nx + ((ny + 1)*gridWidth); gridPoints[x].lvl0.f_viewed = 1;
		return;
	}

	checkLineOfSight(nx, ny, x, y, id);
	while (x < y) {
		x++;
		if (p < 0) {
			p += 2*x+1;
		} else {
			y--;
			p += 2*(x-y)+1;
		}
		checkLineOfSight(nx, ny, x, y, id);
	}
}

//*****************************************************************************************
void gridTile::drawLine(int x1, int y1, int x2, int y2) {
int deltax, deltay, x, y, xinc1, xinc2, yinc1, yinc2, den, num, numadd, numpixels, curpixel;

	if (gridType == 1) { return; }

	if (x2 > gridWidth) { x2 = gridWidth; }
	if (y2 > gridHeight) { y2 = gridHeight; }

	deltax = abs(x2 - x1);        // The difference between the x's
	deltay = abs(y2 - y1);        // The difference between the y's
	x = x1;                       // Start x off at the first pixel
	y = y1;                       // Start y off at the first pixel
		
	if (x2 >= x1)                 // The x-values are increasing
	{
		xinc1 = 1; xinc2 = 1;
	}
	else                          // The x-values are decreasing
	{
		xinc1 = -1; xinc2 = -1;
	}
		
	if (y2 >= y1)                 // The y-values are increasing
	{
		yinc1 = 1; yinc2 = 1;
	}
	else                          // The y-values are decreasing
	{
		yinc1 = -1; yinc2 = -1;
	}
		
	if (deltax >= deltay)         // There is at least one x-value for every y-value
	{
		xinc1 = 0;                  // Don't change the x when numerator >= denominator
		yinc2 = 0;                  // Don't change the y for every iteration
		den = deltax;
		num = deltax / 2;
		numadd = deltay;
		numpixels = deltax;         // There are more x-values than y-values
	}
	else                          // There is at least one y-value for every x-value
	{
		xinc2 = 0;                  // Don't change the x for every iteration
		yinc1 = 0;                  // Don't change the y when numerator >= denominator
		den = deltay;
		num = deltay / 2;
		numadd = deltax;
		numpixels = deltay;         // There are more y-values than x-values
	}
		
	for (curpixel = 0; curpixel <= numpixels; curpixel++) {
		setGridColor(x, y, currColor);             // Draw the current pixel
		num += numadd;              // Increase the numerator by the top of the fraction
		if (num >= den)             // Check if numerator >= denominator
		{
			num -= den;               // Calculate the new numerator value
			x += xinc1;               // Change the x as appropriate
			y += yinc1;               // Change the y as appropriate
		}
		x += xinc2;                 // Change the x as appropriate
		y += yinc2;                 // Change the y as appropriate
	}
}

//*****************************************************************************************
void gridTile::drawSquare(int sx, int sy, int ex, int ey) {
	if (gridType == 1) { return; }
}

//*****************************************************************************************
void gridTile::drawCirclePoints(int cx, int cy, int x, int y) {
	if (x == 0) {
		setGridColor(cx, cy + y, currColor);
		setGridColor(cx, cy - y, currColor);
		setGridColor(cx + y, cy, currColor);
		setGridColor(cx - y, cy, currColor);
		if (shapeFill != 0) {
			drawLine(cx, cy, cx, cy + y);
			drawLine(cx, cy, cx, cy - y);
			drawLine(cx, cy, cx + y, cy);
			drawLine(cx, cy, cx - y, cy);
		}
	} else if (x == y) {
		setGridColor(cx + x, cy + y, currColor);
		setGridColor(cx - x, cy + y, currColor);
		setGridColor(cx + x, cy - y, currColor);
		setGridColor(cx - x, cy - y, currColor);
		if (shapeFill != 0) {
			drawLine(cx,cy,cx + x, cy + y);
			drawLine(cx,cy,cx - x, cy + y);
			drawLine(cx,cy,cx + x, cy - y);
			drawLine(cx,cy,cx - x, cy - y);
		}
	} else if (x < y) {
		setGridColor(cx + x, cy + y, currColor);
		setGridColor(cx - x, cy + y, currColor);
		setGridColor(cx + x, cy - y, currColor);
		setGridColor(cx - x, cy - y, currColor);
		setGridColor(cx + y, cy + x, currColor);
		setGridColor(cx - y, cy + x, currColor);
		setGridColor(cx + y, cy - x, currColor);
		setGridColor(cx - y, cy - x, currColor);
		if (shapeFill != 0) {
			drawLine(cx,cy,cx + x, cy + y);
			drawLine(cx,cy,cx - x, cy + y);
			drawLine(cx,cy,cx + x, cy - y);
			drawLine(cx,cy,cx - x, cy - y);
			drawLine(cx,cy,cx + y, cy + x);
			drawLine(cx,cy,cx - y, cy + x);
			drawLine(cx,cy,cx + y, cy - x);
			drawLine(cx,cy,cx - y, cy - x);
		}
	}
}

//*****************************************************************************************
void gridTile::drawCircle(int xCenter, int yCenter, int radius) {
int x = 0, y = radius, p = (5 - radius*4)/4;
	if (gridType == 1) { return; }

	drawCirclePoints(xCenter, yCenter, x, y);
	while (x < y) {
		x++;
		if (p < 0) {
			p += 2*x+1;
		} else {
			y--;
			p += 2*(x-y)+1;
		}
		drawCirclePoints(xCenter, yCenter, x, y);
	}
}

//*****************************************************************************************
void gridTile::drawCorridor(int x, int y, int width) {
	if (gridType == 1) { return; }
	setGridColor(x, y, currColor);
	setGridColor(x+width, y, currColor);
}

//*****************************************************************************************
void gridTile::clearGridMap() {
	if (gridType == 1) { return; }
//printf("gridTile:clearGridMap\n");

	memset(gridPoints, '\0', (gridWidth*gridHeight*sizeof(gridPoint)));

	if (playerData != NULL) {
		for (int i=0; i<MAX_MEMBERS; i++) {
			playerData[i].i_mapX = playerData[i].i_mapY = -1;
		}
	}

	repaint();
}

//*****************************************************************************************
void gridTile::resizeGridMap(int w, int h) {
	int i,j;
	gridPoint *ngp;

	if (gridType == 1) { return; }

	ngp = (gridPoint *)malloc(w*h*sizeof(gridPoint));
	memset(ngp, '\0', (w*h*sizeof(gridPoint)));
	for (i=0; i<gridHeight; i++) {
		j = i*gridWidth;
		memcpy((char *)&ngp[i*w], (char *)&gridPoints[j], sizeof(gridPoint) * gridWidth);
	}
	gridWidth = w;
	gridHeight = h;

//printf("GA free %d\n", gridPoints);
	if (gridPoints != NULL ) { free(gridPoints); }
	gridPoints = ngp;
//printf("GA malloc %d\n", gridPoints);
	if (externalTile != NULL) { externalTile->setGridArray(gridPoints); }

//	if (vbar != NULL) { vbar->maximum(w); vbar->linesize(w/13); }
//	if (hbar != NULL) { hbar->maximum(h); hbar->linesize(h/13); }

}

//*****************************************************************************************
void gridTile::setMapCentre() {
	prevCentreX = gridTopX + ((w() / gridSize) / 2);
	prevCentreY = gridTopY + ((h() / gridSize) / 2);
}

//*****************************************************************************************
void gridTile::centreMap(int x, int y) {

//printf("gridTile::centreMap %d:%d %d:%d\n", prevCentreX, prevCentreY, x, y);
	if (x < 0) { x = prevCentreX; }
	if (y < 0) { y = prevCentreY; }

	prevCentreX = x; prevCentreY = y;

	x = x - ((w() / gridSize) / 2);
	y = y - ((h() / gridSize) / 2);

	setGridTop(x,y);
}

//*****************************************************************************************
void gridTile::setAllViewed() {
int id;

	if (gridType == 1) { return; }

	for (int i=(gridWidth*gridHeight)-1; i>-1; i--) {
			// only do those that are set
		if (gridPoints[i].lvl0.i_color != 0 || gridPoints[i].lvl0.i_type != 0) {
			gridPoints[i].lvl0.f_viewed = 1;

         id = gridPoints[i].lvl0.i_id;
         if (gridPoints[i].lvl0.i_type == GRID_MONSTER && id != 0) {
            playerData[id].flags.f_wasViewed = 1;
         }
		}
	}
}

//*****************************************************************************************
void gridTile::setGridPoint(int pos, gridPoint *gp) {
	if (gridType == 1) { return; }

	gridPoints[pos].lvl0.i_color = gp->lvl0.i_color;
	gridPoints[pos].lvl0.f_viewed = gp->lvl0.f_viewed;
	gridPoints[pos].lvl0.f_hidden = gp->lvl0.f_hidden;
	gridPoints[pos].lvl0.i_type = gp->lvl0.i_type;
	gridPoints[pos].lvl0.i_id = gp->lvl0.i_id;
	gridPoints[pos].lvl0.f_shadow = gp->lvl0.f_shadow;

	gridPoints[pos].lvl1.i_id = gp->lvl1.i_id;
	gridPoints[pos].lvl1.i_type = gp->lvl1.i_type;
	gridPoints[pos].lvl1.i_color = gp->lvl1.i_color;
	gridPoints[pos].lvl1.f_shadow = gp->lvl1.f_shadow;
	gridPoints[pos].lvl1.f_hidden = gp->lvl1.f_hidden;
	gridPoints[pos].lvl1.f_viewed = gp->lvl1.f_viewed;

	gridPoints[pos].lvl2.i_id = gp->lvl2.i_id;
	gridPoints[pos].lvl2.i_type = gp->lvl2.i_type;
	gridPoints[pos].lvl2.i_color = gp->lvl2.i_color;
	gridPoints[pos].lvl2.f_shadow = gp->lvl2.f_shadow;
	gridPoints[pos].lvl2.f_hidden = gp->lvl2.f_hidden;
	gridPoints[pos].lvl2.f_viewed = gp->lvl2.f_viewed;

	gridPoints[pos].lvl3.i_id = gp->lvl3.i_id;
	gridPoints[pos].lvl3.i_type = gp->lvl3.i_type;
	gridPoints[pos].lvl3.i_color = gp->lvl3.i_color;
	gridPoints[pos].lvl3.f_shadow = gp->lvl3.f_shadow;
	gridPoints[pos].lvl3.f_hidden = gp->lvl3.f_hidden;
	gridPoints[pos].lvl3.f_viewed = gp->lvl3.f_viewed;
}

//*****************************************************************************************
void gridTile::drawShape(int gx, int gy) {
	int i, j;
//printf("Shape: %d @ %d/%d\n", currShape, gx, gy);

	i = shapeWidth/5;
	switch (currShape) {		// type
		case 0:	// circle 
				drawCircle(gx, gy, shapeWidth/5);
				break;

		case 1:	// rectangle
				drawBox(gx, gy, (shapeWidth/5)+1, (shapeHeight/5)+1);
				if (shapeFill != 0) {
					for (j=(shapeHeight/5); j>0; j--) {
						drawLine(gx, gy+j, gx+i, gy+j);
					}
				}
				break;
	}
}

//*****************************************************************************************
void gridTile::drawBox(int sx, int sy, int dx, int dy) {
	drawLine(sx, sy, sx+dx, sy);
	drawLine(sx+dx, sy, sx+dx, sy+dy);
	drawLine(sx, sy, sx, sy+dy);
	drawLine(sx, sy+dy, sx+dx, sy+dy);
}

//*****************************************************************************************
void gridTile::removeObject(int x, int y) {
int gpos, id;

	if (gridType == 1) { return; }
	gpos = x + (y * gridWidth);

	id = gridPoints[gpos].lvl0.i_id;
//printf("rO: %d:%d = %d:%d\n", x, y, gridPoints[gpos].lvl0.i_type, gridPoints[gpos].lvl0.i_id);

	if (gridPoints[gpos].lvl0.i_type == GRID_OBJECT && objectData != NULL) {
		x = objectData[id].i_gridX; y = objectData[id].i_gridY;
		popGP(x, y, objectData[id].i_width/5, objectData[id].i_height/5, id, GRID_OBJECT);
		objectData[id].c_description[0] = objectData[id].c_iconFile[0] = objectData[id].c_playericonFile[0] = '\0';
		objectData[id].i_width = objectData[id].i_height = 0;
		objectData[id].i_id = objectData[id].i_gridX = objectData[id].i_gridY = -1;
		objectData[id].i_animated = 0; objectIcons[id] = NULL;
	} else if (gridPoints[gpos].lvl0.i_type == GRID_BACKGROUND && objectData != NULL) {
		x = objectData[id].i_gridX; y = objectData[id].i_gridY;
		popGP(x, y, objectData[id].i_width, objectData[id].i_height, id, GRID_BACKGROUND);
		objectData[id].c_description[0] = objectData[id].c_iconFile[0] = objectData[id].c_playericonFile[0] = '\0';
		objectData[id].i_width = objectData[id].i_height = 0;
		objectData[id].i_id = objectData[id].i_gridX = objectData[id].i_gridY = -1;
		objectData[id].i_animated = 0; objectIcons[id] = NULL;
	} else if ((gridPoints[gpos].lvl0.i_type == GRID_PLAYER || gridPoints[gpos].lvl0.i_type == GRID_MONSTER) && playerData != NULL) {
		x = playerData[id].i_mapX; y = playerData[id].i_mapY;
		popGP(x, y, (playerData[id].i_space/5), (playerData[id].i_space/5), id, gridPoints[gpos].lvl0.i_type);		// NGP
		playerData[id].i_mapX = playerData[id].i_mapY = -1;
		playerData[id].flags.f_wasViewed = 0;
	} else {
		popGP(x, y);		// NGP
	}

	repaint();
}

//*****************************************************************************************
void gridTile::setCurrentAsViewed(int v) {
int j,k,id;

	if (gridType == 1) { return; }

	for (int i=h()/gridSize; i>0; i--) {
		j = ((gridTopY + i) * gridWidth) + gridTopX;
		for (k = w()/gridSize; k>0; k--) {
			// only do those that are set
//			if (gridPoints[j].lvl0.i_color != 0 || gridPoints[j].lvl0.i_type != 0) {
				gridPoints[j].lvl0.f_viewed = v;
				id = gridPoints[j].lvl0.i_id;
				if (gridPoints[j].lvl0.i_type == GRID_MONSTER && id != 0) {
					playerData[id].flags.f_wasViewed = v;
				}
//			}
			j++;
		}
	}
}

//*****************************************************************************************
void gridTile::setLOSAll() {
int pos, i;

	if (gridType == 1) { return; }
//printf("sLA: setLOSAll\n");

	if (playerData != NULL) {
		for (i=MAX_PLAYERS; i<MAX_MEMBERS; i++) { playerData[i].flags.f_wasViewed = 0; }
		for (i=0; i<MAX_PLAYERS; i++) {
			if (playerData[i].i_mapX != -1 && playerData[i].i_mapY != -1 
			 && playerData[i].flags.f_disabled == 0 && playerData[i].i_hp[HP_MAX] > 0) {
				setLineOfSight(playerData[i].i_mapX, playerData[i].i_mapY, gridVisibility, i);
			}
			playerData[i].flags.f_wasViewed = 1;
		}
	}
}

//*****************************************************************************************
void gridTile::remapColors(int from, int to) {
int i=(gridHeight * gridWidth)-1;
	for (; i>-1; i--) {
		if (gridPoints[i].lvl0.i_color == from) { gridPoints[i].lvl0.i_color = to; } // printf("rmC: %d %d\n", i, to); }
	}
	repaint();
}

//*****************************************************************************************
void gridTile::setFogOfWar(int s) {
	f_fogOfWar = s;
//printf("sFOW: %d\n", s);
}

//*****************************************************************************************
void gridTile::doFogOfWar() {
int i;

	if (playerData != NULL) {
		for (i=MAX_PLAYERS; i<MAX_MEMBERS; i++) { 
			if (playerData[i].i_mapX > 0 && playerData[i].i_mapY > 0) {
//printf("dFOW: %d %d/%d\n", i, playerData[i].i_mapX, playerData[i].i_mapY);
				setGridPointViewed(playerData[i].i_mapX, playerData[i].i_mapY, 0);
				playerData[i].flags.f_wasViewed = 0;
			}
		}
	}
}

//*****************************************************************************************
void gridTile::saveMapToTemp() {
char buf[20];

	undoMapCnt++;
	if (undoMapCnt > 5) { undoMapCnt = 1; }
	sprintf(buf, "tmpMap%d.map", undoMapCnt);
//printf("sMTT: %d = %s\n", undoMapCnt, buf);

	saveGridMap(buf);
}

//*****************************************************************************************
void gridTile::undoMapDrawing(int n) {
char buf[20];

	sprintf(buf, "tmpMap%d.map", undoMapCnt);
//printf("uMD: %d = %s\n", undoMapCnt, buf);
	undoMapCnt -= n;
	if (undoMapCnt < 1) { undoMapCnt = 5; }

	loadGridMap(buf);
}

//*****************************************************************************************
void gridTile::setGridPointId(int x, int y, int id) {
int i=(y * gridWidth) + x;

	gridPoints[i].lvl0.i_id = id;
}

//*****************************************************************************************
void gridTile::setMode(int m) {
	gridMode = m;
	clickedX = clickedY = -1;

	if (m == MODE_COPYOBJECT) {
		copyObjX = copyObjY = -1;
	}
//printf("gridTile::setMode = %d\n", m);
}

//*****************************************************************************************
void gridTile::copyObject(int copyObjX, int copyObjY, int clickedX, int clickedY) {
int opos, npos, w, h, id, nid;

//printf("gridTile::copyObject %d/%d = %d/%d\n", copyObjX, copyObjY, clickedX, clickedY);

	if (copyObjX < 0 || copyObjY < 0 || clickedX < 0 || clickedY < 0) { return; }
	if (copyObjX > gridWidth || copyObjY > gridHeight || clickedX > gridWidth || clickedY > gridHeight) { return; }

	opos = copyObjX+(copyObjY*gridWidth); npos = clickedX+(clickedY*gridWidth);
	id = gridPoints[opos].lvl0.i_id;

	if (id < 0 || id > MAX_OBJECTS  || gridPoints[opos].lvl0.i_type != GRID_OBJECT) { return; }

	w = objectData[id].i_width/5; h = objectData[id].i_height/5;

	for (nid=0; nid<MAX_OBJECTS; nid++) {
		if (objectData[nid].c_description[0] == '\0' && objectData[nid].c_iconFile[0] == '\0') {
//printf("copyObject: %d -> %d %d:%d\n", id, nid, clickedX, clickedY);
			memcpy(objectData[nid].c_description, objectData[id].c_description, sizeof(ADMPobject));
			objectData[nid].i_id = nid;
			objectData[nid].i_gridX = clickedX;
			objectData[nid].i_gridY = clickedY;
			pushGP(clickedX, clickedY, w, h);
			setShadow(clickedX, clickedY, nid, GRID_OBJECT, w, h, 1);
			objectIcons[nid] = objectIcons[id];
			repaint();
			return;
		}
	}

}

//*****************************************************************************************
void gridTile::setShadow(int xpos, int ypos, int id, int type, int wid, int hei, int flag) {
int opos, i, j;
int ty0, id0, ty1, id1;

//printf("setShadow = %d/%d I:%d T:%d W:%d H:%d F:%d\n", xpos, ypos, id, type, wid, hei, flag);

	if (xpos < 0 || ypos < 0) { return; }
	if (id < 0 || id > MAX_MEMBERS) { return; }
	if (wid < 1) { return; }
	if (hei < 1) { return; }
	if (playerData == NULL) { return; }
	if ((xpos + wid) > gridWidth) { wid = gridWidth - xpos; printf("setShadow - adjusting width\n"); }
	if ((ypos + hei) > gridHeight) { hei = gridHeight - ypos; printf("setShadow - adjusting height\n"); }

	for (j=0; j<hei; j++) {
		opos = xpos+(ypos*gridWidth)+(j*gridWidth);
		for (i=0; i<wid; i++) {
			ty0 = gridPoints[opos].lvl0.i_type;
			id0 = gridPoints[opos].lvl0.i_id;
			ty1 = gridPoints[opos].lvl1.i_type;
			id1 = gridPoints[opos].lvl1.i_id;
//printf("setShadow = %d/%d I %d:%d T %d:%d F %d:%d\n", i, j, gid, pid, gty, pty, type, flag);
			if (flag == 0) {
				if (id0 == id && ty1 == type) {
					gridPoints[opos].lvl0.i_id = gridPoints[opos].lvl1.i_id;
					gridPoints[opos].lvl0.i_type = gridPoints[opos].lvl1.i_type;
					gridPoints[opos].lvl0.f_shadow = gridPoints[opos].lvl1.f_shadow;
					gridPoints[opos].lvl1.i_id = gridPoints[opos].lvl1.i_type = gridPoints[opos].lvl1.f_shadow = 0;
				}
					// if the previous type/id match then clear that out as well
				if (id1 == id && ty1 == type) {
					gridPoints[opos].lvl1.i_id = gridPoints[opos].lvl1.i_type = 0;
				}
			} else {
				if (gridPoints[opos].lvl0.i_color < 16 && (ty0 == 0 || ty0 == GRID_BACKGROUND || ty0 == GRID_OBJECT)) {
					if ((ty0 == type && id0 == id) || (ty0 == 0 && id0 == 0)) {
						gridPoints[opos].lvl0.i_id = id;
						gridPoints[opos].lvl0.i_type = type;
						gridPoints[opos].lvl0.f_shadow = flag;
					} else if ((ty1 == type && id1 == id) || (ty1 == 0 && id1 == 0)) {
						gridPoints[opos].lvl1.i_id = id;
						gridPoints[opos].lvl1.i_type = type;
						gridPoints[opos].lvl1.f_shadow = flag;
					}
				} else {
					if (ty0 == 0) {
						if (i == 1) { j = hei; }
						break;
					}
				}
			}
			opos++;
		}
	}

	opos = xpos+(ypos*gridWidth);
	ty0 = gridPoints[opos].lvl0.i_type;
	id0 = gridPoints[opos].lvl0.i_id;
	ty1 = gridPoints[opos].lvl1.i_type;
	id1 = gridPoints[opos].lvl1.i_id;

	if (type == GRID_BACKGROUND || type == GRID_OBJECT) { 
		if (ty0 == type && id0 == id) { gridPoints[opos].lvl0.f_shadow = 0; }
		else if (ty1 == type && id1 == id) { gridPoints[opos].lvl1.f_shadow = 0; }
	}

	if (flag == 1) {
		//gridPoints[opos].lvl0.i_id = id;
		//gridPoints[opos].lvl0.i_type = type;
		id = id;
	} else {
		if (type == GRID_BACKGROUND || ty1 == GRID_BACKGROUND) { 
			if (ty0 == type && id0 == id) { gridPoints[opos].lvl0.f_shadow = 1; }
			else if (ty1 == type && id1 == id) { gridPoints[opos].lvl1.f_shadow = 1; }
		}
	}

//printf("sS C%d:%d V%d:%d H%d:%d T%d:%d I%d:%d S%d:%d\n", gridPoints[opos].lvl0.i_color, gridPoints[opos].lvl1.i_color, gridPoints[opos].lvl0.f_viewed, gridPoints[opos].lvl1.f_viewed, gridPoints[opos].lvl0.f_hidden, gridPoints[opos].lvl1.f_hidden, gridPoints[opos].lvl0.i_type, gridPoints[opos].lvl1.i_type, gridPoints[opos].lvl0.i_id, gridPoints[opos].lvl1.i_id, gridPoints[opos].lvl0.f_shadow, gridPoints[opos].lvl1.f_shadow);
}

//**************************************************************************
Fl_Shared_Image * gridTile::rotate_image(Fl_Shared_Image *img, int angle) {
Fl_Shared_Image *rot;
int x, y, xstep, ystep;
const uchar	*imgptr;
uchar	*rotptr, *rotbase, *rotend;

  rot     = (Fl_Shared_Image *)img->copy(img->h(), img->w());
  rotbase = (uchar *)rot->data()[0];
  rotend  = rotbase + rot->w() * rot->h() * rot->d();

  if (angle == 90) {
    // Rotate 90 clockwise...
    rotptr = rotbase + (rot->h() - 1) * rot->w() * rot->d();
    xstep  = -rot->w() * rot->d() - rot->d();
    ystep  = (rot->w() * rot->h() + 1) * rot->d();
  } else {
    // Rotate 90 counter-clockwise...
    rotptr = rotbase + (rot->w() - 1) * rot->d();
    xstep  = rot->w() * rot->d() - rot->d();
    ystep  = -(rot->w() * rot->h() + 1) * rot->d();
  }

  if (img->d() == 1) {
    // Rotate grayscale image...
    for (y = 0, imgptr = (const uchar *)img->data()[0]; y < img->h(); y ++, rotptr += ystep) {
      for (x = img->w(); x > 0; x --, rotptr += xstep)
			if (rotptr < rotbase || rotptr >= rotend) {
	  			y = 1;
			 	break;
			} else
          *rotptr++ = *imgptr++;
    }
  } else {
    // Rotate color image...
    for (y = 0, imgptr = (const uchar *)img->data()[0]; y < img->h(); y ++, rotptr += ystep) {
      for (x = img->w(); x > 0; x --, rotptr += xstep)
			if (rotptr < rotbase || rotptr >= rotend) {
	  			y = 1;
	  			break;
			} else {
          *rotptr++ = *imgptr++;
          *rotptr++ = *imgptr++;
          *rotptr++ = *imgptr++;
			}
    }
  }

  return (rot);
}

//**************************************************************************
void fl_triangle_filled(int x1, int y1, int x2, int y2, int x3, int y3, int col) {
//get length of all sides
	int d1 = sqrt(((y2-y1) ^ 2)+((x2-x1) ^ 2));
	int d2 = sqrt(((y3-y2) ^ 2)+((x3-x2) ^ 2));
	int d3 = sqrt(((y1-y3) ^ 2)+((x1-x3) ^ 2));
	int tx, ty, vx, vy, counter;

	fl_color(col);

	if (((d1 < d2) || (d1 == d2)) && ((d1 < d2) || (d1 == d2))) {
		tx = x1;
		ty = y1;
		vx = (x2-x1)/d1;
		vy = (y2-y1)/d1;
		counter = 0;
		while (counter < d1) {
			fl_line(x3,y3,tx,ty);
			//drawing a line from point(x3,y3) to point(tx,ty).
			tx = tx + vx;
			ty = ty + vy;
			counter = counter + 1;
		}
	} else if ((d2 < d3) || (d2 == d3)) {
		tx = x2;
		ty = y2;
		vx = (x3-x2)/d2;
		vy = (y3-y2)/d2;
		counter = 0;
		while (counter < d2) {
			fl_line(x1,y1,tx,ty);
			tx = tx + vx;
			ty = ty + vy;
			counter = counter + 1;
		}
	} else {
		tx = x3;
		ty = y3;
		vx = (x1-x3)/d3;
		vy = (y1-y3)/d3;
		counter = 0;
		while (counter < d3) {
			fl_line(x2,y2,tx,ty);
			tx = tx + vx;
			ty = ty + vy;
			counter = counter + 1;
		}
	}
}

//**************************************************************************
void gridTile::resetShadow(int pid, int npid, int owid, int nwid) {
int pos, i = GRID_PLAYER;

//printf("resetShadow = %d : %d : %d : %d\n", pid, npid, owid, nwid);

	pos = playerData[pid].i_mapX + (playerData[pid].i_mapY * gridWidth);

	if (owid < 1) { owid = 1; }
	if (nwid < 1) { nwid = 1; }

	if (npid >= MAX_PLAYERS) { i = GRID_MONSTER; }

	popGP(playerData[pid].i_mapX, playerData[pid].i_mapY, owid, owid, pid, i);
	pushGP(playerData[pid].i_mapX, playerData[pid].i_mapY, nwid, nwid);

	if (nwid > 1) {
		setShadow(playerData[pid].i_mapX, playerData[pid].i_mapY, npid, i, nwid, nwid, 1);
	} else {
		setGridType(playerData[pid].i_mapX, playerData[pid].i_mapY, i, npid);
	}
	gridPoints[pos].lvl1.f_shadow = gridPoints[pos].lvl0.f_shadow; gridPoints[pos].lvl0.f_shadow = 0;

}

//**************************************************************************
void gridTile::undoGridPoint(int x, int y, int wid, int hei) {
int pos = x + (y * gridWidth), i, j;

	if (wid < 1) { wid = 1; }
	if (hei < 1) { hei = 1; }

	for (i=0; i<hei; i++) {
		for (j=0; j<wid; j++) {
			popGP(x + j, y + i); // NGP
		}
		pos += gridWidth;
	}
}

//**************************************************************************
void gridTile::displayInitiatives() {
int xpos=0, ypos=0, xinc=0, yinc=0, ninit=0, i=0;

	if (config == NULL) { return; }

	for (ninit=0; ninit < MAX_MEMBERS; ninit++) { if (config->i_idList[ID_INIT][ninit] == -1) { break; } } 

	if (ninit == 0) { return; }

	switch (initListSetting) {
		case 0:		// top
			break;
		case 1:		// bottom
			break;
		case 2:		// left
			break;
		case 3:		// right
			break;
	}
}

//**************************************************************************
int gridTile::isTopLHS(int gx, int gy) {
	int pos, id;

	pos = (gridWidth * gy) + gx;
	id = gridPoints[pos].lvl0.i_id;

	if (gridPoints[pos].lvl0.i_type == GRID_MONSTER || gridPoints[pos].lvl0.i_type == GRID_PLAYER) {
		if (playerData[id].i_mapX == gx && playerData[id].i_mapY == gy) { return 1; }
	} else if (gridPoints[pos].lvl0.i_type == GRID_BACKGROUND || gridPoints[pos].lvl0.i_type == GRID_OBJECT) {
		if (objectData[id].i_gridX == gx && objectData[id].i_gridY == gy) { return 1; }
	}

	return 0;
}

//**************************************************************************
void gridTile::smooth_line(int x, int y) {
	int pos, p_color, tx, ty, sx, sy, topleft=0, topright=0, botleft=0, botright=0;
	unsigned int color[3][3];
	char line[10], found[2];

	x += gridTopX; y += gridTopY;

//printf("sl: %d %d %d\n", x, y, gridSize);

	if (x == 0 || y == 0 || gridSize < 15) { return; }

		// now get all the colors around them in a 3x3 grid
	pos = (x - 1 ) + ((y - 1) * gridWidth); color[0][0] = gridPoints[pos].lvl0.i_color;
	pos = (x - 0 ) + ((y - 1) * gridWidth); color[0][1] = gridPoints[pos].lvl0.i_color;
	pos = (x + 1 ) + ((y - 1) * gridWidth); color[0][2] = gridPoints[pos].lvl0.i_color;

	pos = (x - 1 ) + ((y - 0) * gridWidth); color[1][0] = gridPoints[pos].lvl0.i_color;
	pos = (x - 0 ) + ((y - 0) * gridWidth); color[1][1] = gridPoints[pos].lvl0.i_color;
	pos = (x + 1 ) + ((y - 0) * gridWidth); color[1][2] = gridPoints[pos].lvl0.i_color;

	pos = (x - 1 ) + ((y + 1) * gridWidth); color[2][0] = gridPoints[pos].lvl0.i_color;
	pos = (x - 0 ) + ((y + 1) * gridWidth); color[2][1] = gridPoints[pos].lvl0.i_color;
	pos = (x + 1 ) + ((y + 1) * gridWidth); color[2][2] = gridPoints[pos].lvl0.i_color;

	strcpy(line, "xxxxxxxxx"); line[9] = '\0';

	if (color[0][0] == color[1][1]) { line[0] = 'X'; }
	if (color[0][1] == color[1][1]) { line[1] = 'X'; }
	if (color[0][2] == color[1][1]) { line[2] = 'X'; }
	if (color[1][0] == color[1][1]) { line[3] = 'X'; }
	if (color[1][1] == color[1][1]) { line[4] = 'X'; }
	if (color[1][2] == color[1][1]) { line[5] = 'X'; }
	if (color[2][0] == color[1][1]) { line[6] = 'X'; }
	if (color[2][1] == color[1][1]) { line[7] = 'X'; }
	if (color[2][2] == color[1][1]) { line[8] = 'X'; }
/*
	if (color[0][0] != colorMap[0]) { line[0] = 'X'; }
	if (color[0][1] != colorMap[0]) { line[1] = 'X'; }
	if (color[0][2] != colorMap[0]) { line[2] = 'X'; }
	if (color[1][0] != colorMap[0]) { line[3] = 'X'; }
	if (color[1][1] != colorMap[0]) { line[4] = 'X'; }
	if (color[1][2] != colorMap[0]) { line[5] = 'X'; }
	if (color[2][0] != colorMap[0]) { line[6] = 'X'; }
	if (color[2][1] != colorMap[0]) { line[7] = 'X'; }
	if (color[2][2] != colorMap[0]) { line[8] = 'X'; }
*/

//printf("sl: %d %d %s\n", x, y, line);

	if (strcmp(line, "XXXXXXXXX") == 0) { return; }		// completely the same color ....

	fl_font(FL_TIMES | FL_BOLD, (int )(gridSize/1.3));
	fl_color(labelColor);

	sx = 234; sy = 89; if (gridType == 1) { sx = 30; sy = 31; }

	tx = sx + (gridSize / 1.8) + ((x - gridTopX) * gridSize);
	ty = sy + (gridSize / 1.8) + ((y - gridTopY) * gridSize);

	found[0] = '.'; found[1] = '\0';

	if (strcmp(line, "XxxxXxxxX") == 0) { found[0] = '\\'; topleft=0; topright=1; botleft=1; botright=0; }
	else if (strcmp(line, "XxxXXxXXX") == 0) { found[0] = '\\'; topleft=0; topright=1; botleft=0; botright=0; }
	else if (strcmp(line, "XXXxXXxxX") == 0) { found[0] = '\\'; topleft=0; topright=0; botleft=1; botright=0; }
	else if (strcmp(line, "xxXxXxXxx") == 0) { found[0] = '/'; topleft=1; topright=0; botleft=0; botright=1; }
	else if (strcmp(line, "xxXxXXXXX") == 0) { found[0] = '/'; topleft=1; topright=0; botleft=0; botright=0; }
	else if (strcmp(line, "xxxxXXXXX") == 0) { found[0] = '/'; topleft=1; topright=0; botleft=0; botright=0; }
	else if (strcmp(line, "XXXXXxXxx") == 0) { found[0] = '/'; topleft=0; topright=0; botleft=0; botright=1; }
	else if (strcmp(line, "XXxxXXxxX") == 0) { found[0] = '\\'; topleft=0; topright=0; botleft=1; botright=0; }
	else if (strcmp(line, "xxXxXxxxX") == 0) { found[0] = '<'; topleft=1; topright=0; botleft=1; botright=0; }
	else if (strcmp(line, "xxXxXXxxX") == 0) { found[0] = '<'; topleft=1; topright=0; botleft=1; botright=0; }
	else if (strcmp(line, "XxXxXxxxx") == 0) { found[0] = 'V'; topleft=0; topright=0; botleft=1; botright=1; }
	else if (strcmp(line, "XXXxXxxxx") == 0) { found[0] = 'V'; topleft=0; topright=0; botleft=1; botright=1; }
	else if (strcmp(line, "XxxxXxXxx") == 0) { found[0] = '>'; topleft=0; topright=1; botleft=0; botright=1; }
	else if (strcmp(line, "XxxXXxXxx") == 0) { found[0] = '>'; topleft=0; topright=1; botleft=0; botright=1; }
	else if (strcmp(line, "xxxxXxXxX") == 0) { found[0] = '^'; topleft=1; topright=1; botleft=0; botright=0; }
	else if (strcmp(line, "xxxxXxXXX") == 0) { found[0] = '^'; topleft=1; topright=1; botleft=0; botright=0; }
	else if (strcmp(line, "XXxXXxXxx") == 0) { found[0] = '/'; topleft=0; topright=0; botleft=0; botright=1; }
	else if (strcmp(line, "xxXxXXxXX") == 0) { found[0] = '/'; topleft=1; topright=0; botleft=0; botright=0; }
	else if (strcmp(line, "XXXXXxxxx") == 0) { found[0] = '/'; topleft=0; topright=0; botleft=0; botright=1; }
	else if (strcmp(line, "XxXxXxXxx") == 0) { found[0] = '/'; topleft=0; topright=0; botleft=0; botright=1; }
	else if (strcmp(line, "xxXxXXxXx") == 0) { found[0] = '/'; topleft=1; topright=0; botleft=0; botright=0; }
	else if (strcmp(line, "xxXxXXxxx") == 0) { found[0] = '/'; topleft=1; topright=0; botleft=0; botright=0; }
	else if (strcmp(line, "xXXxXXxxX") == 0) { found[0] = '\\'; topleft=0; topright=0; botleft=1; botright=0; }
	else if (strcmp(line, "XXXxXxxxX") == 0) { found[0] = '\\'; topleft=0; topright=0; botleft=1; botright=0; }
	else if (strcmp(line, "xxxXXxXXX") == 0) { found[0] = '\\'; topleft=0; topright=1; botleft=0; botright=0; }
	else if (line[1] == line[2] == line[5] == 'x') { found[0] = '\\'; topleft=0; topright=1; botleft=0; botright=0; }
	else if (line[3] == line[6] == line[7] == 'x') { found[0] = '\\'; topleft=0; topright=0; botleft=1; botright=0; }
	else if (line[0] == line[1] == line[3] == 'x') { found[0] = '/'; topleft=1; topright=0; botleft=0; botright=0; }
	else if (line[3] == line[5] == line[6] == line[7] == line[8] == 'x') { found[0] = 'V'; topleft=0; topright=0; botleft=1; botright=1; }

	if (found[0] != '.') {
		//fl_draw(found, tx, ty); 
		//printf("sl: %d %d %s \n", x, y, found);
		fl_color(colorMap[0]);
		x -= gridTopX; y -= gridTopY;
		tx = sx + (x * gridSize);
		ty = sy + (y * gridSize);
		if (topleft == 1) {
//			fl_line(tx, ty + (gridSize * 0.4), tx + (gridSize * 0.4), ty);
//			fl_line(tx, ty + (gridSize * 0.4) - 1, tx + (gridSize * 0.4) - 1, ty);
//			fl_triangle_filled(tx, ty + (gridSize * 0.4), tx, ty, tx + (gridSize * 0.4), ty, colorMap[0]);
			fl_rectf(tx, ty, (gridSize * 0.3), (gridSize * 0.3));
		} 
		if (topright == 1) {
			//fl_line(tx + (gridSize * 0.6), ty, tx + gridSize, ty + (gridSize * 0.4));
			//fl_line(tx + (gridSize * 0.6) + 1, ty, tx + gridSize, ty + (gridSize * 0.4) - 1);
			fl_rectf(tx + (gridSize * 0.7), ty, (gridSize * 0.3) + 1, (gridSize * 0.3));
		} 
		if (botleft == 1) {
			//fl_line(tx, ty + (gridSize * 0.6), tx + (gridSize * 0.4), ty + gridSize);
			//fl_line(tx, ty + (gridSize * 0.6) + 1, tx + (gridSize * 0.4) + 1, ty + gridSize + 1);
			fl_rectf(tx, ty + (gridSize * 0.7), (gridSize * 0.3), (gridSize * 0.3) + 1);
		} 
		if (botright == 1) {
			//fl_line(tx + (gridSize * 0.6), ty + gridSize, tx + gridSize, ty + (gridSize * 0.6));
			//fl_line(tx + (gridSize * 0.6) + 1, ty + gridSize, tx + gridSize, ty + (gridSize * 0.6) - 1);
			fl_rectf(tx + (gridSize * 0.7), ty + (gridSize * 0.7), (gridSize * 0.3), (gridSize * 0.3) + 1);
		}
	}
}

//**************************************************************************
void gridTile::popGP(int gx, int gy) {
int pos, x=0;

	if (gx < 0 || gx > gridWidth) { printf("popGP 1 - width size error %d", gx); return; }
	if (gy < 0 || gy > gridHeight) { printf("popGP 1 - height size error %d", gy); return; }

	pos = gx + (gy * gridWidth);

	gridPoints[pos+x].lvl0.i_id = gridPoints[pos+x].lvl1.i_id;
	gridPoints[pos+x].lvl0.i_type = gridPoints[pos+x].lvl1.i_type;
	gridPoints[pos+x].lvl0.i_color = gridPoints[pos+x].lvl1.i_color;
	gridPoints[pos+x].lvl0.f_viewed = gridPoints[pos+x].lvl1.f_viewed;
	gridPoints[pos+x].lvl0.f_hidden = gridPoints[pos+x].lvl1.f_hidden;
	gridPoints[pos+x].lvl0.f_shadow = gridPoints[pos+x].lvl1.f_shadow;

	gridPoints[pos+x].lvl1.i_id = gridPoints[pos+x].lvl2.i_id;
	gridPoints[pos+x].lvl1.i_type = gridPoints[pos+x].lvl2.i_type;
	gridPoints[pos+x].lvl1.i_color = gridPoints[pos+x].lvl2.i_color;
	gridPoints[pos+x].lvl1.f_viewed = gridPoints[pos+x].lvl2.f_viewed;
	gridPoints[pos+x].lvl1.f_hidden = gridPoints[pos+x].lvl2.f_hidden;
	gridPoints[pos+x].lvl1.f_shadow = gridPoints[pos+x].lvl2.f_shadow;

	gridPoints[pos+x].lvl2.i_id = gridPoints[pos+x].lvl3.i_id;
	gridPoints[pos+x].lvl2.i_type = gridPoints[pos+x].lvl3.i_type;
	gridPoints[pos+x].lvl2.i_color = gridPoints[pos+x].lvl3.i_color;
	gridPoints[pos+x].lvl2.f_viewed = gridPoints[pos+x].lvl3.f_viewed;
	gridPoints[pos+x].lvl2.f_hidden = gridPoints[pos+x].lvl3.f_hidden;
	gridPoints[pos+x].lvl2.f_shadow = gridPoints[pos+x].lvl3.f_shadow;

	gridPoints[pos+x].lvl3.i_id = gridPoints[pos+x].lvl3.i_type = gridPoints[pos+x].lvl3.i_color = gridPoints[pos+x].lvl3.f_viewed = gridPoints[pos+x].lvl3.f_hidden = gridPoints[pos+x].lvl3.f_shadow = 0;
}

//**************************************************************************
void gridTile::popGP(int gx, int gy, int nx, int ny) {
int pos, x;

//printf("popGP: %d %d %d %d\n", gx, gy, nx, ny);

	//if (nx < 1 || ny < 1) { printf("popGP - no size\n"); return; }

	if (gx < 0 || gx > gridWidth) { printf("popGP 2 - width size error %d", gx); return; }
	if (gy < 0 || gy > gridHeight) { printf("popGP 2 - height size error %d", gy); return; }
	if (nx < 1 || ny < 1) { printf("popGP 2 - no size (%d:%d)\n", nx, ny); return; }

	pos = gx + (gy * gridWidth);
	for (; ny>0; ny--) {
		for (x=0; x<nx; x++) {
			gridPoints[pos+x].lvl0.i_id = gridPoints[pos+x].lvl1.i_id;
			gridPoints[pos+x].lvl0.i_type = gridPoints[pos+x].lvl1.i_type;
			gridPoints[pos+x].lvl0.i_color = gridPoints[pos+x].lvl1.i_color;
			gridPoints[pos+x].lvl0.f_viewed = gridPoints[pos+x].lvl1.f_viewed;
			gridPoints[pos+x].lvl0.f_hidden = gridPoints[pos+x].lvl1.f_hidden;
			gridPoints[pos+x].lvl0.f_shadow = gridPoints[pos+x].lvl1.f_shadow;

			gridPoints[pos+x].lvl1.i_id = gridPoints[pos+x].lvl2.i_id;
			gridPoints[pos+x].lvl1.i_type = gridPoints[pos+x].lvl2.i_type;
			gridPoints[pos+x].lvl1.i_color = gridPoints[pos+x].lvl2.i_color;
			gridPoints[pos+x].lvl1.f_viewed = gridPoints[pos+x].lvl2.f_viewed;
			gridPoints[pos+x].lvl1.f_hidden = gridPoints[pos+x].lvl2.f_hidden;
			gridPoints[pos+x].lvl1.f_shadow = gridPoints[pos+x].lvl2.f_shadow;

			gridPoints[pos+x].lvl2.i_id = gridPoints[pos+x].lvl3.i_id;
			gridPoints[pos+x].lvl2.i_type = gridPoints[pos+x].lvl3.i_type;
			gridPoints[pos+x].lvl2.i_color = gridPoints[pos+x].lvl3.i_color;
			gridPoints[pos+x].lvl2.f_viewed = gridPoints[pos+x].lvl3.f_viewed;
			gridPoints[pos+x].lvl2.f_hidden = gridPoints[pos+x].lvl3.f_hidden;
			gridPoints[pos+x].lvl2.f_shadow = gridPoints[pos+x].lvl3.f_shadow;

			gridPoints[pos+x].lvl3.i_id = gridPoints[pos+x].lvl3.i_type = gridPoints[pos+x].lvl3.i_color = gridPoints[pos+x].lvl3.f_viewed = gridPoints[pos+x].lvl3.f_hidden = gridPoints[pos+x].lvl3.f_shadow = 0;
		}
		pos += gridWidth;
	}
}

//**************************************************************************
void gridTile::popGP(int gx, int gy, int nx, int ny, int id, int typ) {
int pos, x, lvl=3;


//printf("popGP: %d %d %d %d %d %d\n", gx, gy, nx, ny, id, typ);

	if (gx < 0 || gx > gridWidth) { printf("popGP 3 - width size error %d", gx); return; }
	if (gy < 0 || gy > gridHeight) { printf("popGP 3 - height size error %d", gy); return; }
	if (nx < 1 || ny < 1) { printf("popGP 3 - no size (%d:%d)\n", nx, ny); return; }

	pos = gx + (gy * gridWidth);
	for (; ny>0; ny--) {
		for (x=0; x<nx; x++) {
			if (gridPoints[pos+x].lvl0.i_id == id && gridPoints[pos+x].lvl0.i_type == typ) { lvl = 0; }
			else if (gridPoints[pos+x].lvl1.i_id == id && gridPoints[pos+x].lvl1.i_type == typ) { lvl = 1; }
			else if (gridPoints[pos+x].lvl2.i_id == id && gridPoints[pos+x].lvl2.i_type == typ) { lvl = 2; }
			else if (gridPoints[pos+x].lvl3.i_id == id && gridPoints[pos+x].lvl3.i_type == typ) { lvl = 3; }
			else { lvl = -1; }
//printf("popGP: lvl = %d\n", lvl);

			if (lvl == 0) {
				gridPoints[pos+x].lvl0.i_id = gridPoints[pos+x].lvl1.i_id;
				gridPoints[pos+x].lvl0.i_type = gridPoints[pos+x].lvl1.i_type;
				gridPoints[pos+x].lvl0.i_color = gridPoints[pos+x].lvl1.i_color;
				gridPoints[pos+x].lvl0.f_viewed = gridPoints[pos+x].lvl1.f_viewed;
				gridPoints[pos+x].lvl0.f_hidden = gridPoints[pos+x].lvl1.f_hidden;
				gridPoints[pos+x].lvl0.f_shadow = gridPoints[pos+x].lvl1.f_shadow;
				lvl = 1;
			} 
			if (lvl == 1) {
				gridPoints[pos+x].lvl1.i_id = gridPoints[pos+x].lvl2.i_id;
				gridPoints[pos+x].lvl1.i_type = gridPoints[pos+x].lvl2.i_type;
				gridPoints[pos+x].lvl1.i_color = gridPoints[pos+x].lvl2.i_color;
				gridPoints[pos+x].lvl1.f_viewed = gridPoints[pos+x].lvl2.f_viewed;
				gridPoints[pos+x].lvl1.f_hidden = gridPoints[pos+x].lvl2.f_hidden;
				gridPoints[pos+x].lvl1.f_shadow = gridPoints[pos+x].lvl2.f_shadow;
				lvl = 2;
			} 
			if (lvl == 2) {
				gridPoints[pos+x].lvl2.i_id = gridPoints[pos+x].lvl3.i_id;
				gridPoints[pos+x].lvl2.i_type = gridPoints[pos+x].lvl3.i_type;
				gridPoints[pos+x].lvl2.i_color = gridPoints[pos+x].lvl3.i_color;
				gridPoints[pos+x].lvl2.f_viewed = gridPoints[pos+x].lvl3.f_viewed;
				gridPoints[pos+x].lvl2.f_hidden = gridPoints[pos+x].lvl3.f_hidden;
				gridPoints[pos+x].lvl2.f_shadow = gridPoints[pos+x].lvl3.f_shadow;
				lvl = 3;
			}
			if (lvl == 3) {
				gridPoints[pos+x].lvl3.i_id = gridPoints[pos+x].lvl3.i_type = gridPoints[pos+x].lvl3.i_color = gridPoints[pos+x].lvl3.f_viewed = gridPoints[pos+x].lvl3.f_hidden = gridPoints[pos+x].lvl3.f_shadow = 0;
			}
//printf("popGP: Id: %d/%d/%d/%d  Type: %d/%d/%d/%d\n", gridPoints[pos+x].lvl0.i_id, gridPoints[pos+x].lvl1.i_id, gridPoints[pos+x].lvl2.i_id, gridPoints[pos+x].lvl3.i_id, gridPoints[pos+x].lvl0.i_type, gridPoints[pos+x].lvl1.i_type, gridPoints[pos+x].lvl2.i_type, gridPoints[pos+x].lvl3.i_type);
		}
		pos += gridWidth;
	}
}
//**************************************************************************
void gridTile::pushGP(int gx, int gy) {
int pos, x=0;

	if (gx < 0 || gx > gridWidth) { printf("pushGP 1 - width size error %d", gx); return; }
	if (gy < 0 || gy > gridHeight) { printf("pushGP 1 - height size error %d", gy); return; }

	pos = gx + (gy * gridWidth);

	gridPoints[pos+x].lvl3.i_id = gridPoints[pos+x].lvl2.i_id;
	gridPoints[pos+x].lvl3.i_type = gridPoints[pos+x].lvl2.i_type;
	gridPoints[pos+x].lvl3.i_color = gridPoints[pos+x].lvl2.i_color;
	gridPoints[pos+x].lvl3.f_viewed = gridPoints[pos+x].lvl2.f_viewed;
	gridPoints[pos+x].lvl3.f_hidden = gridPoints[pos+x].lvl2.f_hidden;
	gridPoints[pos+x].lvl3.f_shadow = gridPoints[pos+x].lvl2.f_shadow;

	gridPoints[pos+x].lvl2.i_id = gridPoints[pos+x].lvl1.i_id;
	gridPoints[pos+x].lvl2.i_type = gridPoints[pos+x].lvl1.i_type;
	gridPoints[pos+x].lvl2.i_color = gridPoints[pos+x].lvl1.i_color;
	gridPoints[pos+x].lvl2.f_viewed = gridPoints[pos+x].lvl1.f_viewed;
	gridPoints[pos+x].lvl2.f_hidden = gridPoints[pos+x].lvl1.f_hidden;
	gridPoints[pos+x].lvl2.f_shadow = gridPoints[pos+x].lvl1.f_shadow;

	gridPoints[pos+x].lvl1.i_id = gridPoints[pos+x].lvl0.i_id;
	gridPoints[pos+x].lvl1.i_type = gridPoints[pos+x].lvl0.i_type;
	gridPoints[pos+x].lvl1.i_color = gridPoints[pos+x].lvl0.i_color;
	gridPoints[pos+x].lvl1.f_viewed = gridPoints[pos+x].lvl0.f_viewed;
	gridPoints[pos+x].lvl1.f_hidden = gridPoints[pos+x].lvl0.f_hidden;
	gridPoints[pos+x].lvl1.f_shadow = gridPoints[pos+x].lvl0.f_shadow;

	gridPoints[pos+x].lvl0.i_id = gridPoints[pos+x].lvl0.i_type = gridPoints[pos+x].lvl0.i_color = gridPoints[pos+x].lvl0.f_viewed = gridPoints[pos+x].lvl0.f_hidden = gridPoints[pos+x].lvl0.f_shadow = 0;
}

//**************************************************************************
void gridTile::pushGP(int gx, int gy, int nx, int ny) {
int pos, x;

//printf("pushGP: %d %d %d %d\n", gx, gy, nx, ny);

	if (gx < 0 || gx > gridWidth) { printf("pushGP 2 - width size error %d", gx); return; }
	if (gy < 0 || gy > gridHeight) { printf("pushGP 2 - height size error %d", gy); return; }
	if (nx < 1 || ny < 1) { printf("pushGP 2 - no size (%d:%d)\n", nx, ny); return; }

	pos = gx + (gy * gridWidth);
	for (; ny>0; ny--) {
		for (x=0; x<nx; x++) {
			gridPoints[pos+x].lvl3.i_id = gridPoints[pos+x].lvl2.i_id;
			gridPoints[pos+x].lvl3.i_type = gridPoints[pos+x].lvl2.i_type;
			gridPoints[pos+x].lvl3.i_color = gridPoints[pos+x].lvl2.i_color;
			gridPoints[pos+x].lvl3.f_viewed = gridPoints[pos+x].lvl2.f_viewed;
			gridPoints[pos+x].lvl3.f_hidden = gridPoints[pos+x].lvl2.f_hidden;
			gridPoints[pos+x].lvl3.f_shadow = gridPoints[pos+x].lvl2.f_shadow;

			gridPoints[pos+x].lvl2.i_id = gridPoints[pos+x].lvl1.i_id;
			gridPoints[pos+x].lvl2.i_type = gridPoints[pos+x].lvl1.i_type;
			gridPoints[pos+x].lvl2.i_color = gridPoints[pos+x].lvl1.i_color;
			gridPoints[pos+x].lvl2.f_viewed = gridPoints[pos+x].lvl1.f_viewed;
			gridPoints[pos+x].lvl2.f_hidden = gridPoints[pos+x].lvl1.f_hidden;
			gridPoints[pos+x].lvl2.f_shadow = gridPoints[pos+x].lvl1.f_shadow;

			gridPoints[pos+x].lvl1.i_id = gridPoints[pos+x].lvl0.i_id;
			gridPoints[pos+x].lvl1.i_type = gridPoints[pos+x].lvl0.i_type;
			gridPoints[pos+x].lvl1.i_color = gridPoints[pos+x].lvl0.i_color;
			gridPoints[pos+x].lvl1.f_viewed = gridPoints[pos+x].lvl0.f_viewed;
			gridPoints[pos+x].lvl1.f_hidden = gridPoints[pos+x].lvl0.f_hidden;
			gridPoints[pos+x].lvl1.f_shadow = gridPoints[pos+x].lvl0.f_shadow;

			gridPoints[pos+x].lvl0.i_id = gridPoints[pos+x].lvl0.i_type = gridPoints[pos+x].lvl0.i_color = gridPoints[pos+x].lvl0.f_viewed = gridPoints[pos+x].lvl0.f_hidden = gridPoints[pos+x].lvl0.f_shadow = 0;
//printf("pushGP: %d - %d %d (%d/%d)\n", pos+x, x, ny, gridPoints[pos+x].lvl0.i_type, gridPoints[pos+x].lvl1.i_type);
		}
		pos += gridWidth;
	}
}

//**************************************************************************
void gridTile::pushGP(int gx, int gy, int nx, int ny, int ty, int id) {
int pos, x, type;

//printf("pushGP: %d %d %d %d\n", gx, gy, nx, ny);
	if (gx < 0 || gx > gridWidth) { printf("pushGP 3 - width size error %d", gx); return; }
	if (gy < 0 || gy > gridHeight) { printf("pushGP 3 - height size error %d", gy); return; }
	if (nx < 1 || ny < 1) { printf("pushGP 3 - no size (%d:%d)\n", nx, ny); return; }

	pos = gx + (gy * gridWidth);
	for (; ny>0; ny--) {
		for (x=0; x<nx; x++) {
			gridPoints[pos+x].lvl3.i_id = gridPoints[pos+x].lvl2.i_id;
			gridPoints[pos+x].lvl3.i_type = gridPoints[pos+x].lvl2.i_type;
			gridPoints[pos+x].lvl3.i_color = gridPoints[pos+x].lvl2.i_color;
			gridPoints[pos+x].lvl3.f_viewed = gridPoints[pos+x].lvl2.f_viewed;
			gridPoints[pos+x].lvl3.f_hidden = gridPoints[pos+x].lvl2.f_hidden;
			gridPoints[pos+x].lvl3.f_shadow = gridPoints[pos+x].lvl2.f_shadow;

			gridPoints[pos+x].lvl2.i_id = gridPoints[pos+x].lvl1.i_id;
			gridPoints[pos+x].lvl2.i_type = gridPoints[pos+x].lvl1.i_type;
			gridPoints[pos+x].lvl2.i_color = gridPoints[pos+x].lvl1.i_color;
			gridPoints[pos+x].lvl2.f_viewed = gridPoints[pos+x].lvl1.f_viewed;
			gridPoints[pos+x].lvl2.f_hidden = gridPoints[pos+x].lvl1.f_hidden;
			gridPoints[pos+x].lvl2.f_shadow = gridPoints[pos+x].lvl1.f_shadow;

			type = gridPoints[pos+x].lvl0.i_type;
			if ((ty == GRID_PLAYER || ty == GRID_MONSTER || ty == GRID_OBJECT) && (type != GRID_PLAYER && type != GRID_MONSTER && type != GRID_OBJECT)) {
				gridPoints[pos+x].lvl1.i_id = gridPoints[pos+x].lvl0.i_id;
				gridPoints[pos+x].lvl1.i_type = gridPoints[pos+x].lvl0.i_type;
				gridPoints[pos+x].lvl1.i_color = gridPoints[pos+x].lvl0.i_color;
				gridPoints[pos+x].lvl1.f_viewed = gridPoints[pos+x].lvl0.f_viewed;
				gridPoints[pos+x].lvl1.f_hidden = gridPoints[pos+x].lvl0.f_hidden;
				gridPoints[pos+x].lvl1.f_shadow = gridPoints[pos+x].lvl0.f_shadow;

				gridPoints[pos+x].lvl0.i_id = gridPoints[pos+x].lvl0.i_type = gridPoints[pos+x].lvl0.i_color = gridPoints[pos+x].lvl0.f_viewed = gridPoints[pos+x].lvl0.f_hidden = gridPoints[pos+x].lvl0.f_shadow = 0;
			} else {
				gridPoints[pos+x].lvl1.i_id = id; gridPoints[pos+x].lvl1.i_type = ty;
				gridPoints[pos+x].lvl1.i_color = gridPoints[pos+x].lvl1.f_viewed = gridPoints[pos+x].lvl1.f_hidden = gridPoints[pos+x].lvl1.f_shadow = 0;
			}
//printf("pushGP: %d - %d %d (%d/%d)\n", pos+x, x, ny, gridPoints[pos+x].lvl0.i_type, gridPoints[pos+x].lvl1.i_type);
		}
		pos += gridWidth;
	}
}

//**************************************************************************
void gridTile::pushGP(int gx, int gy, int nx, int ny, int ty, int id, int shad) {
int pos, x, ty0, ty1, ty2, lvl;

//printf("pushGP: %d %d %d %d\n", gx, gy, nx, ny);
	if (gx < 0 || gx > gridWidth) { printf("pushGP 4 - width size error %d", gx); return; }
	if (gy < 0 || gy > gridHeight) { printf("pushGP 4 - height size error %d", gy); return; }
	if (nx < 1 || ny < 1) { printf("pushGP 4 - no size (%d:%d)\n", nx, ny); return; }

	pos = gx + (gy * gridWidth);
	for (; ny>0; ny--) {
		for (x=0; x<nx; x++) {
			ty0 = gridPoints[pos+x].lvl0.i_type;
			ty1 = gridPoints[pos+x].lvl1.i_type;
			ty2 = gridPoints[pos+x].lvl2.i_type;
			lvl = 3;
// do a hierarchy of player/monster/object/BI ....
			if (ty == GRID_MONSTER && ty0 == GRID_PLAYER) { 
				lvl = 2; 
				if (ty == GRID_MONSTER && ty1 == GRID_PLAYER) { lvl = 1; }
			} else if (ty == GRID_OBJECT && (ty0 == GRID_PLAYER || ty0 == GRID_MONSTER)) { 
				lvl = 2; 
				if (ty == GRID_OBJECT && (ty1 == GRID_PLAYER || ty1 == GRID_MONSTER)) { lvl = 1; }
			} else if (ty == GRID_BACKGROUND && (ty0 == GRID_PLAYER || ty0 == GRID_MONSTER)) { 
				lvl = 2; 
				if (ty == GRID_BACKGROUND && (ty1 == GRID_PLAYER || ty1 == GRID_MONSTER)) { lvl = 1; }
			}

			gridPoints[pos+x].lvl3.i_id = gridPoints[pos+x].lvl2.i_id;
			gridPoints[pos+x].lvl3.i_type = gridPoints[pos+x].lvl2.i_type;
			gridPoints[pos+x].lvl3.i_color = gridPoints[pos+x].lvl2.i_color;
			gridPoints[pos+x].lvl3.f_viewed = gridPoints[pos+x].lvl2.f_viewed;
			gridPoints[pos+x].lvl3.f_hidden = gridPoints[pos+x].lvl2.f_hidden;
			gridPoints[pos+x].lvl3.f_shadow = gridPoints[pos+x].lvl2.f_shadow;

			if (lvl == 3) {
				gridPoints[pos+x].lvl2.i_id = gridPoints[pos+x].lvl1.i_id;
				gridPoints[pos+x].lvl2.i_type = gridPoints[pos+x].lvl1.i_type;
				gridPoints[pos+x].lvl2.i_color = gridPoints[pos+x].lvl1.i_color;
				gridPoints[pos+x].lvl2.f_viewed = gridPoints[pos+x].lvl1.f_viewed;
				gridPoints[pos+x].lvl2.f_hidden = gridPoints[pos+x].lvl1.f_hidden;
				gridPoints[pos+x].lvl2.f_shadow = gridPoints[pos+x].lvl1.f_shadow;

				gridPoints[pos+x].lvl1.i_id = gridPoints[pos+x].lvl0.i_id;
				gridPoints[pos+x].lvl1.i_type = gridPoints[pos+x].lvl0.i_type;
				gridPoints[pos+x].lvl1.i_color = gridPoints[pos+x].lvl0.i_color;
				gridPoints[pos+x].lvl1.f_viewed = gridPoints[pos+x].lvl0.f_viewed;
				gridPoints[pos+x].lvl1.f_hidden = gridPoints[pos+x].lvl0.f_hidden;
				gridPoints[pos+x].lvl1.f_shadow = gridPoints[pos+x].lvl0.f_shadow;

				gridPoints[pos+x].lvl0.i_id = id; gridPoints[pos+x].lvl0.i_type = ty;  gridPoints[pos+x].lvl0.f_shadow = shad;
				gridPoints[pos+x].lvl0.i_color = gridPoints[pos+x].lvl0.f_viewed = gridPoints[pos+x].lvl0.f_hidden = 0;
			} else if (lvl == 2) {
				gridPoints[pos+x].lvl2.i_id = gridPoints[pos+x].lvl1.i_id;
				gridPoints[pos+x].lvl2.i_type = gridPoints[pos+x].lvl1.i_type;
				gridPoints[pos+x].lvl2.i_color = gridPoints[pos+x].lvl1.i_color;
				gridPoints[pos+x].lvl2.f_viewed = gridPoints[pos+x].lvl1.f_viewed;
				gridPoints[pos+x].lvl2.f_hidden = gridPoints[pos+x].lvl1.f_hidden;
				gridPoints[pos+x].lvl2.f_shadow = gridPoints[pos+x].lvl1.f_shadow;

				gridPoints[pos+x].lvl1.i_id = id; gridPoints[pos+x].lvl1.i_type = ty;  gridPoints[pos+x].lvl1.f_shadow = shad;
				gridPoints[pos+x].lvl1.i_color = gridPoints[pos+x].lvl1.f_viewed = gridPoints[pos+x].lvl1.f_hidden = 0;
			} else if (lvl == 1) {
				gridPoints[pos+x].lvl2.i_id = id; gridPoints[pos+x].lvl2.i_type = ty;  gridPoints[pos+x].lvl2.f_shadow = shad;
				gridPoints[pos+x].lvl2.i_color = gridPoints[pos+x].lvl2.f_viewed = gridPoints[pos+x].lvl2.f_hidden = 0;
			}
		}
	}

}

//**************************************************************************
void gridTile::reorgGP(int gx, int gy, int nx, int ny) {
int pos, x, ty0, ty1, ty2, ty3, flip, p_id;
gridDataPoint gdp;

//printf("reorgGP: %d %d %d %d\n", gx, gy, nx, ny);
	if (gx < 0 || gx > gridWidth) { printf("reorgGP - width size error %d", gx); return; }
	if (gy < 0 || gy > gridHeight) { printf("reorgGP - height size error %d", gy); return; }
	if (nx < 1 || ny < 1) { printf("reorgGP - no size (%d:%d)\n", nx, ny); return; }

	pos = gx + (gy * gridWidth);
	flip = 0;
	for (; ny>0; ny--) {
		for (x=0; x<nx; x++) {
			ty2 = gridPoints[pos+x].lvl2.i_type;
			ty3 = gridPoints[pos+x].lvl3.i_type;

			if (ty3 == GRID_PLAYER && ty2 != GRID_PLAYER) {flip = 1; }
			else if (ty3 == GRID_MONSTER && (ty2 != GRID_PLAYER && ty2 != GRID_MONSTER)) { flip = 1; }
			else if (ty2 == GRID_OBJECT && ty3 == GRID_OBJECT && objectData != NULL) {
				p_id = gridPoints[pos+x].lvl3.i_id;
				if (objectData[p_id].i_width == 5 && objectData[p_id].i_height == 5) { flip = 1; }
			}

			if (flip == 1) {
//printf("reorgGP: flip 2 %d/%d\n", nx+x, ny);
				gdp.i_id = gridPoints[pos+x].lvl2.i_id;
				gdp.i_type = gridPoints[pos+x].lvl2.i_type;
				gdp.i_color = gridPoints[pos+x].lvl2.i_color;
				gdp.f_viewed = gridPoints[pos+x].lvl2.f_viewed;
				gdp.f_hidden = gridPoints[pos+x].lvl2.f_hidden;
				gdp.f_shadow = gridPoints[pos+x].lvl2.f_shadow;

				gridPoints[pos+x].lvl2.i_id = gridPoints[pos+x].lvl3.i_id;
				gridPoints[pos+x].lvl2.i_type = gridPoints[pos+x].lvl3.i_type;
				gridPoints[pos+x].lvl2.i_color = gridPoints[pos+x].lvl3.i_color;
				gridPoints[pos+x].lvl2.f_viewed = gridPoints[pos+x].lvl3.f_viewed;
				gridPoints[pos+x].lvl2.f_hidden = gridPoints[pos+x].lvl3.f_hidden;
				gridPoints[pos+x].lvl2.f_shadow = gridPoints[pos+x].lvl3.f_shadow;

				gridPoints[pos+x].lvl3.i_id = gdp.i_id;
				gridPoints[pos+x].lvl3.i_type = gdp.i_type;
				gridPoints[pos+x].lvl3.i_color = gdp.i_color;
				gridPoints[pos+x].lvl3.f_viewed = gdp.f_viewed;
				gridPoints[pos+x].lvl3.f_hidden = gdp.f_hidden;
				gridPoints[pos+x].lvl3.f_shadow = gdp.f_shadow;

				flip = 0;
			}

			ty1 = gridPoints[pos+x].lvl1.i_type;
			ty2 = gridPoints[pos+x].lvl2.i_type;

			if (ty2 == GRID_PLAYER && ty1 != GRID_PLAYER) {flip = 1; }
			else if (ty2 == GRID_MONSTER && (ty1 != GRID_PLAYER && ty1 != GRID_MONSTER)) { flip = 1; }
			else if (ty2 == GRID_OBJECT && ty1 == GRID_OBJECT && objectData != NULL) {
				p_id = gridPoints[pos+x].lvl1.i_id;
				if (objectData[p_id].i_width == 5 && objectData[p_id].i_height == 5) { flip = 1; }
			}

			if (flip == 1) {
//printf("reorgGP: flip 2 %d/%d\n", nx+x, ny);
				gdp.i_id = gridPoints[pos+x].lvl1.i_id;
				gdp.i_type = gridPoints[pos+x].lvl1.i_type;
				gdp.i_color = gridPoints[pos+x].lvl1.i_color;
				gdp.f_viewed = gridPoints[pos+x].lvl1.f_viewed;
				gdp.f_hidden = gridPoints[pos+x].lvl1.f_hidden;
				gdp.f_shadow = gridPoints[pos+x].lvl1.f_shadow;

				gridPoints[pos+x].lvl1.i_id = gridPoints[pos+x].lvl2.i_id;
				gridPoints[pos+x].lvl1.i_type = gridPoints[pos+x].lvl2.i_type;
				gridPoints[pos+x].lvl1.i_color = gridPoints[pos+x].lvl2.i_color;
				gridPoints[pos+x].lvl1.f_viewed = gridPoints[pos+x].lvl2.f_viewed;
				gridPoints[pos+x].lvl1.f_hidden = gridPoints[pos+x].lvl2.f_hidden;
				gridPoints[pos+x].lvl1.f_shadow = gridPoints[pos+x].lvl2.f_shadow;

				gridPoints[pos+x].lvl2.i_id = gdp.i_id;
				gridPoints[pos+x].lvl2.i_type = gdp.i_type;
				gridPoints[pos+x].lvl2.i_color = gdp.i_color;
				gridPoints[pos+x].lvl2.f_viewed = gdp.f_viewed;
				gridPoints[pos+x].lvl2.f_hidden = gdp.f_hidden;
				gridPoints[pos+x].lvl2.f_shadow = gdp.f_shadow;

				flip = 0;
			}

			ty0 = gridPoints[pos+x].lvl0.i_type;
			ty1 = gridPoints[pos+x].lvl1.i_type;

			if (ty1 == GRID_PLAYER && ty0 != GRID_PLAYER) {flip = 1; }
			else if (ty1 == GRID_MONSTER && (ty0 != GRID_PLAYER && ty0 != GRID_MONSTER)) { flip = 1; }
			else if (ty1 == GRID_OBJECT && ty0 == GRID_OBJECT && objectData != NULL) {
				p_id = gridPoints[pos+x].lvl1.i_id;
				if (objectData[p_id].i_width == 5 && objectData[p_id].i_height == 5) { flip = 1; }
			} else if (ty0 == GRID_BACKGROUND && ty1 != 0 && ty1 != GRID_BACKGROUND) { flip = 1; }

			if (flip == 1) {
//printf("reorgGP: flip %d/%d\n", nx+x, ny);
				gdp.i_id = gridPoints[pos+x].lvl0.i_id;
				gdp.i_type = gridPoints[pos+x].lvl0.i_type;
				gdp.i_color = gridPoints[pos+x].lvl0.i_color;
				gdp.f_viewed = gridPoints[pos+x].lvl0.f_viewed;
				gdp.f_hidden = gridPoints[pos+x].lvl0.f_hidden;
				gdp.f_shadow = gridPoints[pos+x].lvl0.f_shadow;

				gridPoints[pos+x].lvl0.i_id = gridPoints[pos+x].lvl1.i_id;
				gridPoints[pos+x].lvl0.i_type = gridPoints[pos+x].lvl1.i_type;
				gridPoints[pos+x].lvl0.i_color = gridPoints[pos+x].lvl1.i_color;
				gridPoints[pos+x].lvl0.f_viewed = gridPoints[pos+x].lvl1.f_viewed;
				gridPoints[pos+x].lvl0.f_hidden = gridPoints[pos+x].lvl1.f_hidden;
				gridPoints[pos+x].lvl0.f_shadow = gridPoints[pos+x].lvl1.f_shadow;

				gridPoints[pos+x].lvl1.i_id = gdp.i_id;
				gridPoints[pos+x].lvl1.i_type = gdp.i_type;
				gridPoints[pos+x].lvl1.i_color = gdp.i_color;
				gridPoints[pos+x].lvl1.f_viewed = gdp.f_viewed;
				gridPoints[pos+x].lvl1.f_hidden = gdp.f_hidden;
				gridPoints[pos+x].lvl1.f_shadow = gdp.f_shadow;

				flip = 0;
			}
		}
		pos += gridWidth;
	}
}

//**************************************************************************
void gridTile::setGridPointViewed(int gx, int gy, int nx, int ny, int f) {
	int pos = gx + (gy * gridWidth), x;

	for (; ny>0; ny--) {
		for (x=0; x<nx; x++) {
			gridPoints[pos+x].lvl0.f_viewed = gridPoints[pos+x].lvl1.f_viewed = gridPoints[pos+x].lvl2.f_viewed = gridPoints[pos+x].lvl3.f_viewed = f;
		}
		pos += gridWidth;
	}
}

//**************************************************************************
void gridTile::setTimer(int minutes) {
	if (minutes < 0) { timerMinutes += minutes; return; }
	timerStart = time(NULL);
	timerMinutes = minutes;
}
