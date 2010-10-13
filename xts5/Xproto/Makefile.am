include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = -I$(top_srcdir)/include \
	-I$(top_srcdir)/src/tet3/inc \
	-I$(top_srcdir)/xts5/include \
	$(XTS_CFLAGS)
LDADD = $(top_builddir)/src/tet3/tcm/libtcmmain.la \
	$(top_builddir)/xts5/src/libxts5proto.la \
	$(top_builddir)/xts5/src/libxts5.la \
	$(top_builddir)/src/tet3/apilib/libapi.la \
	$(top_builddir)/src/tet3/apilib/libapi_s.la \
	$(XTS_LIBS)

testprogdir = $(libexecdir)/$(subdir)
nobase_testprog_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:=.c)
EXTRA_DIST = $(addsuffix .m,$(filter-out %_m,$(tprogs)))
DISTCLEANFILES = $(BUILT_SOURCES)

tprogs = \
	pAllocColor \
	pAllocColorCells \
	pAllocColorPlanes \
	pAllocNamedColor \
	pAllowEvents \
	pBadRequest \
	pBell \
	pChangeActivePointerGrab \
	pChangeGC \
	pChangeHosts \
	pChangeKeyboardControl \
	pChangeKeyboardMapping \
	pChangePointerControl \
	pChangeProperty \
	pChangeSaveSet \
	pChangeWindowAttributes \
	pClearArea \
	pCloseFont \
	pConfigureWindow \
	pConvertSelection \
	pCopyArea \
	pCopyColormapAndFree \
	pCopyGC \
	pCopyPlane \
	pCirculateWindow \
	pCreateColormap \
	pCreateCursor \
	pCreateGC \
	pCreateGlyphCursor \
	pCreatePixmap \
	pCreateWindow \
	pDeleteProperty \
	pDestroySubwindows \
	pDestroyWindow \
	pFillPoly \
	pFreeColormap \
	pFreeColors \
	pFreeCursor \
	pForceScreenSaver \
	pFreeGC \
	pFreePixmap \
	pGrabButton \
	pGrabKey \
	pGrabKeyboard \
	pGrabPointer \
	pGrabServer \
	pGetAtomName \
	pGetFontPath \
	pGetGeometry \
	pGetImage \
	pGetInputFocus \
	pGetKeyboardControl \
	pGetKeyboardMapping \
	pGetModifierMapping \
	pGetMotionEvents \
	pGetPointerControl \
	pGetPointerMapping \
	pGetProperty \
	pGetScreenSaver \
	pGetSelectionOwner \
	pGetWindowAttributes \
	pImageText16 \
	pImageText8 \
	pInstallColormap \
	pInternAtom \
	pKillClient \
	pLookupColor \
	pListExtensions \
	pListFonts \
	pListFontsWithInfo \
	pListHosts \
	pListInstalledColormaps \
	pListProperties \
	pMapSubwindows \
	pMapWindow \
	pNoOperation \
	pOpenDisplay \
	pOpenFont \
	pPolyArc \
	pPolyFillArc \
	pPolyFillRectangle \
	pPolyLine \
	pPolyPoint \
	pPolyRectangle \
	pPolySegment \
	pPolyText16 \
	pPolyText8 \
	pPutImage \
	pQueryBestSize \
	pQueryColors \
	pQueryExtension \
	pQueryFont \
	pQueryKeymap \
	pQueryPointer \
	pQueryTree \
	pQueryTextExtents \
	pRecolorCursor \
	pReparentWindow \
	pRotateProperties \
	pSendEvent \
	pSetAccessControl \
	pSetClipRectangles \
	pSetCloseDownMode \
	pSetDashes \
	pSetFontPath \
	pSetInputFocus \
	pSetModifierMapping \
	pSetPointerMapping \
	pStoreColors \
	pStoreNamedColor \
	pSetScreenSaver \
	pSetSelectionOwner \
	pTranslateCoords \
	pUngrabButton \
	pUngrabKey \
	pUngrabKeyboard \
	pUngrabPointer \
	pUngrabServer \
	pUnmapSubwindows \
	pUnmapWindow \
	pUninstallColormap \
	pWarpPointer
