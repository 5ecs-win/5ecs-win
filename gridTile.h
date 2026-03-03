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

#ifndef gridTile_H
#define gridTile_H

#ifndef Fl_Tile_H
#include "FL/Fl_Tile.H"
#endif
#include "FL/Fl_Browser.H"
#include "FL/Fl_Window.H"
#include "FL/Fl_Button.H"
#include "FL/Fl_Scrollbar.H"
#include "FL/Fl_Image.H"
#include "FL/Fl_Shared_Image.H"
#include "FL/Fl_PNG_Image.H"
#include "FL/Fl_JPEG_Image.H"
#include <stdlib.h>
#include <math.h>
#include <time.h>

#include "gridPoint.h"
#include "5eCSdefines.h"

#ifndef ADMPDATA_H
#include "ADMPdata.h"
#endif

class FL_EXPORT gridTile : public Fl_Tile {
	gridPoint *gridPoints;
	//gridNewPoint *gridNPoints;
	Fl_Color colorMap[MAX_COLORS];
	int gridSize, gridWidth, gridHeight, gridSizes[40], gridSizePtr;
	int gridTopX, gridTopY, gridMode, gridLayer;
	int clickedX, clickedY, prevEvent, gridType, gridVisibility, xAdjust, yAdjust;
	int deltaX, deltaY, currColor, currShape;
	int shapeWidth, shapeHeight, shapeFill;
	int prevX, prevY, undoMapCnt;
	int prevCentreX, prevCentreY;
	int copyObjX, copyObjY;
	int labelColor;
	int showHealthStatus = 0, autoCenterPlayerWindow = 0;
	int hasBackGroundImage = 0;
	int doAnimation = 0;

	int timerMinutes;
	time_t timerStart;

	int showInitList=0, initListSetting=0;

	losPoint *losGrid;
	uchar losGridSize;

	uchar losAlgorithm;

	Fl_Browser *gridOutputText;
	Fl_Window *actionWindow;

	ADMPobject *objectData = NULL;

	Fl_Image *playerIcons[MAX_MEMBERS+2], *objectIcons[(MAX_OBJECTS+2)*2], *inactiveIcons[MAX_MEMBERS+2];
	Fl_Image *texture[16];

	gridTile *externalTile;

	ADMPplayer *playerData;

	int (*eventTileHandler)();
	int (*eventMapHandler)();

	Fl_Scrollbar *vbar, *hbar;

	char f_fogOfWar;

	ADMPgroup *groupData = NULL;

	Fl_Widget *parent;

	ADMPsystem *config = NULL;

protected:

  virtual void draw();

public:

  virtual int handle(int);

  gridTile(int,int,int,int);

	void doAnimations();
	int getGridSize();
	void setAnimation(int i) { doAnimation = i; }
	int setGridSize(int);
	int setGridSize(int, int);
	int setGridColor(int, int, int);
	int setGridType(int, int, int, int);
	int setColorMap(int, Fl_Color);
	Fl_Color getColorMap(int);
	int setGridTop(int, int);
	int getGridTopX();
	int getGridTopY();
	int getGridWidth() { return w(); }
	int getGridHeight() { return h(); }
	int getGridSzWidth() { return gridWidth; }
	int getGridSzHeight() { return gridHeight; }

	void setScrollBars(Fl_Scrollbar *v, Fl_Scrollbar *h) { vbar = v; hbar = h; }

	void repaint() { redraw(); if (externalTile != NULL) { externalTile->redraw(); } }

	void setGridText(Fl_Browser *o) { gridOutputText = o; }

	void setMode(int );

	void setExternalTile(gridTile *t) { externalTile = t; }

	void moveGridPoint(int , int , int , int );

	void setActionWindow(Fl_Window *w) { actionWindow = w; }

	void setGridType(int t) { gridType = t; }
	void setGridLayer(int l) { gridLayer = l; }

	void setSystemConfig(ADMPsystem *c) { config = c; }

	void setPlayerData(ADMPplayer *p) { playerData = p; }
	void setObjectData(ADMPobject *p) { objectData = p; if (gridType == 0 && externalTile != NULL) { externalTile->setObjectData(p); } }

	void setGridVisibility(int );

	void saveGridMap(char *);
	void loadGridMap(char *);

	gridPoint *getGridPointArray() { return gridPoints; }

	void setMapEventHandler(int (*e)()) { eventMapHandler = e; }
	void setTileEventHandler(int (*e)()) { eventTileHandler = e; }

	int getClickedX() { return clickedX; }
	int getClickedY() { return clickedY; }

	int getClickedGridID() { int i = clickedX+(clickedY*gridWidth); if (gridPoints[i].lvl0.i_type == 0) { return -1; } return (gridPoints[i].lvl0.i_id); }
	int getClickedGridType() { int i = clickedX+(clickedY*gridWidth); return gridPoints[i].lvl0.i_type; }
	int getGridType(int x, int y) { int i = x+(y*gridWidth); return gridPoints[i].lvl0.i_type; }

	int getGridPointHidden(int sx, int sy) { return gridPoints[sx+(sy*gridWidth)].lvl0.f_hidden; }
	int getGridPointViewed(int sx, int sy) { return gridPoints[sx+(sy*gridWidth)].lvl0.f_viewed; }
	int getGridPointType(int sx, int sy) { return gridPoints[sx+(sy*gridWidth)].lvl0.i_type; }
	int getGridPointColor(int sx, int sy) { return gridPoints[sx+(sy*gridWidth)].lvl0.i_color; }
	int getGridPointPrevColor(int sx, int sy) { return gridPoints[sx+(sy*gridWidth)].lvl1.i_color; }
	int getGridPointShadow(int sx, int sy) { return gridPoints[sx+(sy*gridWidth)].lvl0.f_shadow; }

	void setGridPointHidden(int sx, int sy, int h) { if (sx < 0 || sy < 0) { return; } gridPoints[sx+(sy*gridWidth)].lvl0.f_hidden = h; repaint(); }
	void setGridPointViewed(int sx, int sy, int v) { int p = sx+(sy*gridWidth); if (sx < 0 || sy < 0) { return; } gridPoints[p].lvl0.f_viewed = gridPoints[p].lvl1.f_viewed = gridPoints[p].lvl2.f_viewed = gridPoints[p].lvl3.f_viewed = v; repaint(); }
	void setGridPointViewed(int , int , int, int, int);
	void setGridPointColor(int sx, int sy, int c) { gridPoints[sx+(sy*gridWidth)].lvl0.i_color = c; }

	void drawLineOfSight(int , int , int, int, int);
	void checkLineOfSight(int ,int ,int, int, int);
	void setLineOfSight(int , int , int, int);

	void drawCirclePoints(int, int, int, int);
	void drawLine(int , int , int , int );
	void drawCircle(int , int , int );
	void drawSquare(int , int , int , int );
	void drawCorridor(int , int , int);

	void setPlayerIcon(int p, Fl_Image *i) { if (p < 0 || p > MAX_MEMBERS) { printf("setPlayerIcon: error (%d)\n", p); return; } playerIcons[p] = i; }
	void setInactiveIcon(int p, Fl_Image *i) { if (p < 0 || p > MAX_MEMBERS) { printf("setInactiveIcon: error (%d)\n", p); return; } inactiveIcons[p] = i; }
	void setObjectIcon(int p, Fl_Image *i) { if (p < 0 || p > (MAX_OBJECTS*2)) { printf("setObjectIcon: error (%d)\n", p); return; } objectIcons[p] = i; if (gridType == 0 && externalTile != NULL) { externalTile->setObjectIcon(p, i); } }
	void setActiveColor(int c) { currColor = c; }

	void resizeGridMap(int , int );
	void clearGridMap();
	void centreMap(int, int);

	void setAllViewed();

	void setGridPoint(int, gridPoint *);

	void setGridArray(gridPoint *gp) { gridPoints = gp; }

	void setCurrentShape(int i) { currShape = i; }
	void drawShape(int, int);
	void drawBox(int, int, int, int);

	void removeObject(int, int);

	void setShapeSize(int w, int h) { shapeWidth = w; shapeHeight = h; }
	void setShapeFill(int w) { shapeFill = w; }

	void setCurrentAsViewed(int);

	void setLOSAll();

	void remapColors(int, int);

	void setFogOfWar(int);
	void doFogOfWar();

	void saveMapToTemp();
	void undoMapDrawing(int);
	void setGridPointId(int, int, int);

	void copyObject(int, int, int, int);

	void setMapCentre();

	void setGroupData(ADMPgroup *g) { groupData = g; }

	void cleanUp() { if (gridType != 1 && gridPoints != NULL) { free(gridPoints); } } // printf("Free gridPoints\n"); } }

	void setLOSGrid(int, int, int);

	void setShadow(int, int, int, int, int, int, int);

	Fl_Shared_Image *rotate_image(Fl_Shared_Image *, int );

	void setParent(Fl_Widget *p) { parent = p; }

	void setLabelColor(int c) { labelColor = c; }

	void setShowHealthStatus(int c) { showHealthStatus = c; }

	void setAutoCentrePlayerWindow(int c) { autoCenterPlayerWindow = c; }

	void setTexture(int c, Fl_Image *t) { if (c < 0 || c > 15) { printf("setTexture = %d\n", c); return; } texture[c] = t; }

	void smooth_line(int ,int );

	int hasBackGroundImages() { return hasBackGroundImage; }
	
	void undoGridPoint(int, int, int, int);

	void resetShadow(int, int, int, int);

	void showInitiatives(int c, int b) { if (c != -1) { showInitList = c; } initListSetting = b; }

	int getInitiatives() { return showInitList; }

	void displayInitiatives();

	int isTopLHS(int , int);

	void popGP(int, int);
	void pushGP(int, int);
	void popGP(int, int, int, int);
	void popGP(int, int, int, int, int, int);
	void pushGP(int, int, int, int);
	void pushGP(int, int, int, int, int, int);
	void pushGP(int, int, int, int, int, int, int);
	void reorgGP(int, int, int, int);

	void setTimer(int );
	int getTimer() { return timerMinutes; }
};

#endif
