LIB=../fltk-144/
INC=../fltk-144/
FLTKVERSION=144

CCLIB=../fltk-144/win
CCFIX=i686-w64-mingw32
CCCC=$(PREFIX)-gcc
CCCXX=$(PREFIX)-g++
CCCPP=$(PREFIX)-cpp
CCRANLIB=$(PREFIX)-ranlib
# libs for arch linux
LDLIBS=-pthread -lpthread -lm  -lwayland-cursor -lwayland-client -lxkbcommon -lpangocairo-1.0 -lpango-1.0 -lgobject-2.0 -lglib-2.0 -lharfbuzz -lcairo  -lX11 -ldl -ldbus-1 -lgtk-3 -lgdk-3 -lz -lharfbuzz -lpangocairo-1.0 -lpango-1.0 -latk-1.0 -lcairo -lcairo-gobject -lgdk_pixbuf-2.0 -lgio-2.0 -lglib-2.0 -lgobject-2.0 -lpangocairo-1.0 -lpango-1.0 -lgobject-2.0 -lglib-2.0 -lharfbuzz -lcairo -lXinerama -lXcursor -lXfixes -lXrender -lX11
# libs for standard linux
LDLIBS=-ldl -lm -lXext -lX11 -lXinerama -lXrender -lXcursor -lXfixes -lXext -lXft -lfontconfig -lXinerama -lpthread -ldl -lm  -lX11

#clean:
#	rm *.o admpnew.exe admpnew

admpnew: ADMPextraa.o  ADMPextrab.o  ADMPtreasure.o  gridMap.o  gridTile.o  pDBlibrary.o
	g++ -D_LIBCPP_HARDENING_MODE=_LIBCPP_HARDENING_MODE_EXTENSIVE -g -Wno-write-strings -DADMP_TEXT_SIZE=12 -DADMP_LABEL_SIZE=12 -fsigned-char ADMPnew.cxx -o admpnew pDBlibrary.o ADMPextraa.o ADMPextrab.o ADMPtreasure.o gridTile.o gridMap.o -I$(INC) -L$(LIB) -lfltk_images -lfltk_png -lfltk_z -lfltk_jpeg -lfltk $(LDLIBS)

ADMPextraa.o: ADMPextraa.cxx ADMPdata.h ADMPexternals.h ADMPmerp.h ADMPwindows.h gridMap.h pDBlibrary.h stdmodifiers.h stdmonsters.h
	g++ -D_LIBCPP_HARDENING_MODE=_LIBCPP_HARDENING_MODE_EXTENSIVE -g -Wformat-overflow=0 -Wno-write-strings -DFLTKVERSION=${FLTKVERSION} -DADMP_TEXT_SIZE=12 -DADMP_LABEL_SIZE=12 -fsigned-char -c ADMPextraa.cxx -I$(INC)

ADMPextrab.o: ADMPextrab.cxx ADMPdata.h ADMPexternals.h ADMPmerp.h gridMap.h pDBlibrary.h
	g++ -D_LIBCPP_HARDENING_MODE=_LIBCPP_HARDENING_MODE_EXTENSIVE -g -Wformat-overflow=0 -Wno-write-strings -DFLTKVERSION=${FLTKVERSION} -DADMP_TEXT_SIZE=12 -DADMP_LABEL_SIZE=12 -fsigned-char -c ADMPextrab.cxx -I$(INC)

ADMPtreasure.o: ADMPtreasure.cxx ADMPdata.h ADMPexternals.h
	g++ -g -Wformat-overflow=0 -Wno-write-strings -DADMP_TEXT_SIZE=12 -DADMP_LABEL_SIZE=12 -fsigned-char -c ADMPtreasure.cxx -I$(INC)

gridMap.o: gridMap.cxx gridMap.h 5eCSdefines.h ADMPdata.h
	g++ -D_LIBCPP_HARDENING_MODE=_LIBCPP_HARDENING_MODE_EXTENSIVE -g -Wformat-overflow=0 -c gridMap.cxx -I$(INC)

gridTile.o: gridTile.cxx gridTile.h 5eCSdefines.h ADMPdata.h
	g++ -D_LIBCPP_HARDENING_MODE=_LIBCPP_HARDENING_MODE_EXTENSIVE -g -Wformat-overflow=0 -Wno-write-strings -c gridTile.cxx -I$(INC)

pDBlibrary.o: pDBlibrary.cxx pDBlibrary.h ADMPdata.h
	g++ -g -Wformat-overflow=0 -Wno-write-strings -Wall -c pDBlibrary.cxx

cscMain: cscMain.o cscspells.h
	g++ -g -Wno-write-strings -DADMP_TEXT_SIZE=12 -DADMP_LABEL_SIZE=12 -fsigned-char dndcsc.cxx -o dndcsc cscMain.o -I$(INC) -L$(LIB) -lfltk_images -lfltk_png -lfltk_z -lfltk_jpeg -lfltk $(LDLIBS)

cscMain.o: cscMain.cxx
	g++ -g -Wno-unused -Wformat-overflow=0 -Wno-write-strings -Wall -c cscMain.cxx -I$(INC)

cccscMain: 
	i686-w64-mingw32-g++ -g -DWINDOWS -DCYGWIN -fstack-protector-all -Wno-write-strings -c cscMain.cxx -I$(INC)
	i686-w64-mingw32-g++ -g -DWINDOWS -DCYGWIN -fstack-protector-all -Wno-write-strings -DADMP_TEXT_SIZE=12 -DADMP_LABEL_SIZE=12 -fsigned-char dndcsc.cxx -o dndcsc.exe cscMain.o -I$(INC) -L$(CCLIB) -lfltk_images -lfltk_png -lfltk_z -lfltk_jpeg -lfltk -lole32 -luuid -lcomctl32 -mwindows -static -lwinpthread -static-libgcc -static-libstdc++ -Wl,-Bstatic
	rm -f cscMain.o
