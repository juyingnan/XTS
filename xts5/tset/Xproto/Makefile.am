include ../../common.mk

AM_CFLAGS = $(XP_LCFLAGS) $(XP_CFLAGS)
LDADD = $(TCM) $(XP_LLIBS) $(XP_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)
.PHONY: $(TESTS)

tprogs = allcclr/allcclr
TESTS = pAllocColor

tprogs += allcclrcll/allcclrcll
TESTS += pAllocColorCells

tprogs += allcclrpln/allcclrpln
TESTS += pAllocColorPlanes

tprogs += allcnmdclr/allcnmdclr
TESTS += pAllocNamedColor

tprogs += allwevnts/allwevnts
TESTS += pAllowEvents

tprogs += bdrqst/bdrqst
TESTS += pBadRequest

tprogs += bll/bll
TESTS += pBell

tprogs += chngactvpn/chngactvpn
TESTS += pChangeActivePointerGrab

tprogs += chnggc/chnggc
TESTS += pChangeGC

tprogs += chnghsts/chnghsts
TESTS += pChangeHosts

tprogs += chngkybrdc/chngkybrdc
TESTS += pChangeKeyboardControl

tprogs += chngkybrdm/chngkybrdm
TESTS += pChangeKeyboardMapping

tprogs += chngpntrcn/chngpntrcn
TESTS += pChangePointerControl

tprogs += chngprprty/chngprprty
TESTS += pChangeProperty

tprogs += chngsvst/chngsvst
TESTS += pChangeSaveSet

tprogs += chngwdwatt/chngwdwatt
TESTS += pChangeWindowAttributes

tprogs += clrar/clrar
TESTS += pClearArea

tprogs += clsfnt/clsfnt
TESTS += pCloseFont

tprogs += cnfgrwdw/cnfgrwdw
TESTS += pConfigureWindow

tprogs += cnvrtslctn/cnvrtslctn
TESTS += pConvertSelection

tprogs += cpyar/cpyar
TESTS += pCopyArea

tprogs += cpyclrmpan/cpyclrmpan
TESTS += pCopyColormapAndFree

tprogs += cpygc/cpygc
TESTS += pCopyGC

tprogs += cpypln/cpypln
TESTS += pCopyPlane

tprogs += crcltwdw/crcltwdw
TESTS += pCirculateWindow

tprogs += crtclrmp/crtclrmp
TESTS += pCreateColormap

tprogs += crtcrsr/crtcrsr
TESTS += pCreateCursor

tprogs += crtgc/crtgc
TESTS += pCreateGC

tprogs += crtglyphcr/crtglyphcr
TESTS += pCreateGlyphCursor

tprogs += crtpxmp/crtpxmp
TESTS += pCreatePixmap

tprogs += crtwdw/crtwdw
TESTS += pCreateWindow

tprogs += dltprprty/dltprprty
TESTS += pDeleteProperty

tprogs += dstrysbws/dstrysbws
TESTS += pDestroySubwindows

tprogs += dstrywdw/dstrywdw
TESTS += pDestroyWindow

tprogs += fllply/fllply
TESTS += pFillPoly

tprogs += frclrmp/frclrmp
TESTS += pFreeColormap

tprogs += frclrs/frclrs
TESTS += pFreeColors

tprogs += frcrsr/frcrsr
TESTS += pFreeCursor

tprogs += frcscrnsvr/frcscrnsvr
TESTS += pForceScreenSaver

tprogs += frgc/frgc
TESTS += pFreeGC

tprogs += frpxmp/frpxmp
TESTS += pFreePixmap

tprogs += grbbttn/grbbttn
TESTS += pGrabButton

tprogs += grbky/grbky
TESTS += pGrabKey

tprogs += grbkybrd/grbkybrd
TESTS += pGrabKeyboard

tprogs += grbpntr/grbpntr
TESTS += pGrabPointer

tprogs += grbsrvr/grbsrvr
TESTS += pGrabServer

tprogs += gtatmnm/gtatmnm
TESTS += pGetAtomName

tprogs += gtfntpth/gtfntpth
TESTS += pGetFontPath

tprogs += gtgmtry/gtgmtry
TESTS += pGetGeometry

tprogs += gtimg/gtimg
TESTS += pGetImage

tprogs += gtinptfcs/gtinptfcs
TESTS += pGetInputFocus

tprogs += gtkybrdcnt/gtkybrdcnt
TESTS += pGetKeyboardControl

tprogs += gtkybrdmpp/gtkybrdmpp
TESTS += pGetKeyboardMapping

tprogs += gtmdfrmppn/gtmdfrmppn
TESTS += pGetModifierMapping

tprogs += gtmtnevnts/gtmtnevnts
TESTS += pGetMotionEvents

tprogs += gtpntrcntr/gtpntrcntr
TESTS += pGetPointerControl

tprogs += gtpntrmppn/gtpntrmppn
TESTS += pGetPointerMapping

tprogs += gtprprty/gtprprty
TESTS += pGetProperty

tprogs += gtscrnsvr/gtscrnsvr
TESTS += pGetScreenSaver

tprogs += gtslctnown/gtslctnown
TESTS += pGetSelectionOwner

tprogs += gtwdwattrb/gtwdwattrb
TESTS += pGetWindowAttributes

tprogs += imgtxt16/imgtxt16
TESTS += pImageText16

tprogs += imgtxt8/imgtxt8
TESTS += pImageText8

tprogs += instllclrm/instllclrm
TESTS += pInstallColormap

tprogs += intrnatm/intrnatm
TESTS += pInternAtom

tprogs += kllclnt/kllclnt
TESTS += pKillClient

tprogs += lkpclr/lkpclr
TESTS += pLookupColor

tprogs += lstextnsns/lstextnsns
TESTS += pListExtensions

tprogs += lstfnts/lstfnts
TESTS += pListFonts

tprogs += lstfntswth/lstfntswth
TESTS += pListFontsWithInfo

tprogs += lsthsts/lsthsts
TESTS += pListHosts

tprogs += lstinstlld/lstinstlld
TESTS += pListInstalledColormaps

tprogs += lstprprts/lstprprts
TESTS += pListProperties

tprogs += mpsbws/mpsbws
TESTS += pMapSubwindows

tprogs += mpwdw/mpwdw
TESTS += pMapWindow

tprogs += noprtn/noprtn
TESTS += pNoOperation

tprogs += opndsply/opndsply
TESTS += pOpenDisplay

tprogs += opnfnt/opnfnt
TESTS += pOpenFont

tprogs += plyarc/plyarc
TESTS += pPolyArc

tprogs += plyfllarc/plyfllarc
TESTS += pPolyFillArc

tprogs += plyfllrctn/plyfllrctn
TESTS += pPolyFillRectangle

tprogs += plyln/plyln
TESTS += pPolyLine

tprogs += plypnt/plypnt
TESTS += pPolyPoint

tprogs += plyrctngl/plyrctngl
TESTS += pPolyRectangle

tprogs += plysgmnt/plysgmnt
TESTS += pPolySegment

tprogs += plytxt16/plytxt16
TESTS += pPolyText16

tprogs += plytxt8/plytxt8
TESTS += pPolyText8

tprogs += ptimg/ptimg
TESTS += pPutImage

tprogs += qrybstsz/qrybstsz
TESTS += pQueryBestSize

tprogs += qryclrs/qryclrs
TESTS += pQueryColors

tprogs += qryextnsn/qryextnsn
TESTS += pQueryExtension

tprogs += qryfnt/qryfnt
TESTS += pQueryFont

tprogs += qrykymp/qrykymp
TESTS += pQueryKeymap

tprogs += qrypntr/qrypntr
TESTS += pQueryPointer

tprogs += qrytr/qrytr
TESTS += pQueryTree

tprogs += qrytxtextn/qrytxtextn
TESTS += pQueryTextExtents

tprogs += rclrcrsr/rclrcrsr
TESTS += pRecolorCursor

tprogs += rprntwdw/rprntwdw
TESTS += pReparentWindow

tprogs += rttprprts/rttprprts
TESTS += pRotateProperties

tprogs += sndevnt/sndevnt
TESTS += pSendEvent

tprogs += staccsscnt/staccsscnt
TESTS += pSetAccessControl

tprogs += stclprctng/stclprctng
TESTS += pSetClipRectangles

tprogs += stclsdwnmd/stclsdwnmd
TESTS += pSetCloseDownMode

tprogs += stdshs/stdshs
TESTS += pSetDashes

tprogs += stfntpth/stfntpth
TESTS += pSetFontPath

tprogs += stinptfcs/stinptfcs
TESTS += pSetInputFocus

tprogs += stmdfrmppn/stmdfrmppn
TESTS += pSetModifierMapping

tprogs += stpntrmppn/stpntrmppn
TESTS += pSetPointerMapping

tprogs += strclrs/strclrs
TESTS += pStoreColors

tprogs += strnmdclr/strnmdclr
TESTS += pStoreNamedColor

tprogs += stscrnsvr/stscrnsvr
TESTS += pSetScreenSaver

tprogs += stslctnown/stslctnown
TESTS += pSetSelectionOwner

tprogs += trnsltcrds/trnsltcrds
TESTS += pTranslateCoords

tprogs += ungrbbttn/ungrbbttn
TESTS += pUngrabButton

tprogs += ungrbky/ungrbky
TESTS += pUngrabKey

tprogs += ungrbkybrd/ungrbkybrd
TESTS += pUngrabKeyboard

tprogs += ungrbpntr/ungrbpntr
TESTS += pUngrabPointer

tprogs += ungrbsrvr/ungrbsrvr
TESTS += pUngrabServer

tprogs += unmpsbws/unmpsbws
TESTS += pUnmapSubwindows

tprogs += unmpwdw/unmpwdw
TESTS += pUnmapWindow

tprogs += unnstllclr/unnstllclr
TESTS += pUninstallColormap

tprogs += wrppntr/wrppntr
TESTS += pWarpPointer
