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
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <FL/Fl.H>
#include <FL/fl_draw.H>

#include "gridMap.h"
#include "5eCSdefines.h"

//**********************************************************************************************
void gridMap::draw() {
//	printf("in gridMap::draw\n");

	drawColumnHeaders(); 
	drawRowHeaders();
}

//**********************************************************************************************
int gridMap::handle(int event) {
//printf("in gridMap::handle\n");
	if (gridType == 1 && event == FL_MOUSEWHEEL) { drawRowHeaders(); drawColumnHeaders(); }
	return 0;
}

//**********************************************************************************************
int gridMap::setGridSize(int sz) {
//	printf("gridMap::setGridSize = %d\n", sz);
	mapTile->setGridSize(sz);
	drawColumnHeaders(); 
	drawRowHeaders();

//	vbar->value((int )vbar->value(), size, top, total);

	return 0;
}

//**********************************************************************************************
int gridMap::drawRowHeaders() {
	char buf[9];
	int sy = mapTile->getGridTopY(), ny=(mapTile->getGridHeight()/mapTile->getGridSize()), yp, xp, gs=mapTile->getGridSize();

	xp = x();
	fl_color((Fl_Color)92);
	fl_rectf(x(), y(), 25, h());

	buf[1] = '\0'; buf[2] = '\0';
//printf("dRH: %d\n", gs);

	for (int yc = 0; yc<=ny; yc+=1) {
		yp = y() + (yc * gs);
		if (yc == ignoreY) {
			fl_color((Fl_Color)61);
		} else {
			fl_color((Fl_Color)6);
		}
		fl_rectf(xp, yp+25+2, 25, gs-3);

		fl_color(FL_BLACK);
		if (gs > 40) {
			fl_font(FL_TIMES | FL_BOLD, 20);
		} else {
			fl_font(FL_TIMES | FL_BOLD, gs/2);
		}
//		sprintf(buf, "%d", (yc+i)*5);
//		buf[0] = gridXID[yc % 52];
		buf[0] = gridXID[(sy + yc) % 52];
//		buf[1] = gridXID[(sy + yc) % 52];
		fl_draw(buf, xp+7, (int )(yp+(gs/1.5))+25);
	}
	redraw();
	return 0;
}

//**********************************************************************************************
int gridMap::drawColumnHeaders() {
	char buf[9];
	int sx = mapTile->getGridTopX(), nx=(mapTile->getGridWidth()/mapTile->getGridSize()), yp=0, xp=0, xc=0, gs=mapTile->getGridSize();

	if (sx < 0) { sx = 0; }

	buf[1] = '\0'; buf[2] = '\0';

	yp = y();

//printf("gridMap:dCH: sx=%d nx=%d yp=%d xp=%d xc=%d gs=%d\n", sx,nx,yp,xp,xc,gs);

	fl_color((Fl_Color)92);
	fl_rectf(x(), yp, w(), 25);

	for (xc = 0; xc<=nx; xc+=1) {
		xp = x() + (xc * gs);
		if (xc == ignoreX) {
			fl_color((Fl_Color)61);
		} else {
			fl_color((Fl_Color)6);
		}
		fl_rectf(xp+25+2, yp, gs-2, 25);

		fl_color(FL_BLACK);
		buf[0] = gridID[(sx + xc) % 52];
		if (gs > 50) { 
			fl_font(FL_TIMES | FL_BOLD, 25); 
			fl_draw(buf, (int )(xp+(gs/1.5)), (int )(yp+20));
		} else { 
			fl_font(FL_TIMES | FL_BOLD, gs/2);
			fl_draw(buf, (int )(xp+35), (int )(yp+20));
		}
	}
	redraw();
	return 0;
}

//**********************************************************************************************
gridMap::gridMap(int X, int Y, int W, int H, const char *l) : Fl_Widget(X,Y,W,H,l) {
	int i;

	gridMode = gridType = 0;

	gridWidth = W-25;
	gridHeight = H-25;

//	hbar = new Fl_Scrollbar(X+25, Y+gridHeight+25, gridWidth, 20); hbar->type(1);
//	hbar->callback(my_cb_scrollbar, (void *)this);

//	vbar = new Fl_Scrollbar(X+gridWidth+25, Y+25, 20, gridHeight);
//	vbar->callback(my_cb_scrollbar, (void *)this);

//	vbar->deactivate(); hbar->deactivate();
//	vbar->hide(); hbar->hide();

//	resizeScrollbars(MAPSIZE, MAPSIZE);

	mapTile = new gridTile(X+25,Y+25,gridWidth,gridHeight);
	mapTile->setParent(this);

	externalGrid = NULL;

//	mapTile->setScrollBars(vbar, hbar);

	strcpy(gridID, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz");
	strcpy(gridXID, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ");

	ignoreX = ignoreY = -1;
}

//**********************************************************************************************
void gridMap::cb_scrollbar(Fl_Widget *w) {
	int tx=0, ty=0, i=0;
//printf("scrollbar scrolled: H:%d V:%d\n", hbar->value(), vbar->value());

	i = mapTile->getGridSzWidth() - (mapTile->w()/mapTile->getGridSize());
//	tx = hbar->value(); if (tx > i) { tx = i; }
//printf(" %d/%d", tx, ty);
	i = mapTile->getGridSzHeight() - (mapTile->h()/mapTile->getGridSize());
//	ty = vbar->value(); if (ty > i) { ty = i; }
//printf(" %d/%d", tx, ty);

	if (tx < 0) { tx = 0; }
	if (ty < 0) { ty = 0; }

	mapTile->setGridTop(tx, ty);
	drawColumnHeaders(); 
	drawRowHeaders();
}

//**********************************************************************************************
void gridMap::setGridText(Fl_Browser *o) { mapTile->setGridText(o); }

//**********************************************************************************************
void gridMap::resizeGridMap(int w, int h) { 
	mapTile->resizeGridMap(w, h); 
	if (externalGrid != NULL) { externalGrid->getGridTile()->setGridArray(mapTile->getGridPointArray()); } 

//	resizeScrollbars(w, h);
}

//**********************************************************************************************
void gridMap::resizeScrollbars(int w, int h) { 
//	hbar->maximum(h);
//	hbar->linesize(h/13);
//	hbar->slider_size(0.1);
//	vbar->maximum(w);
//	vbar->linesize(w/13);
//	vbar->slider_size(0.1);
}

//**********************************************************************************************
void gridMap::size(int W,int H) { 
	resize(x(),y(),W,H);
	mapTile->size(W-15,H-15);

//	vbar = new Fl_Scrollbar(X+gridWidth+25, Y+25, 20, gridHeight);
//	hbar = new Fl_Scrollbar(X+25, Y+gridHeight+25, gridWidth, 20);

//	vbar->resize(x()+W-20, y()+25, 20, H-45);
//	hbar->resize(x()+25, y()+H-20, W-45, 20);
}

//**********************************************************************************************
void gridMap::markPlayerLocation(int xpos, int ypos) {
int yp, xp, gs=mapTile->getGridSize();

//printf("mPL: %d:%d\n", xpos, ypos);

	if (xpos < 0 || ypos < 0) { return; }

	xpos = xpos - mapTile->getGridTopX();
	ypos = ypos - mapTile->getGridTopY();

	if (xpos < 0 || ypos < 0) { return; }
//printf("mPL: %d:%d\n", xpos, ypos);

	ignoreX = xpos; ignoreY = ypos;
	redraw();
//	ignoreX = ignoreY = -1;
}
