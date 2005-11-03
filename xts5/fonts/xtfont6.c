/*
Copyright (c) 2005 X.Org Foundation L.L.C.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
/*
* $Header: /cvs/xtest/xtest/xts5/fonts/xtfont6.c,v 1.2 2005-11-03 08:42:00 jmichael Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1995
* All Rights Reserved.
*
* Project:     VSW5
*
* File:        xts5/fonts/xtfont6.c
*
* Description:
*	VSW test font
*
* Modifications:
* $Log: xtfont6.c,v $
* Revision 1.2  2005-11-03 08:42:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:06  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:22:56  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:40:57  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:15:30  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:12:02  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/01/25 02:01:11  andy
* Portability improvements from DEPLOY tools
*
* Revision 4.0  1995/12/15  08:37:59  tbr
* Branch point for Release 5.0.0
*
* Revision 3.2  1995/12/15  00:33:46  andy
* Prepare for GA Release
*
*/

/*
Portions of this software are based on Xlib and X Protocol Test Suite.
We have used this material under the terms of its copyright, which grants
free use, subject to the conditions below.  Note however that those
portions of this software that are based on the original Test Suite have
been significantly revised and that all such revisions are copyright (c)
1995 Applied Testing and Technology, Inc.  Insomuch as the proprietary
revisions cannot be separated from the freely copyable material, the net
result is that use of this software is governed by the ApTest copyright.

Copyright (c) 1990, 1991  X Consortium

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
X CONSORTIUM BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Except as contained in this notice, the name of the X Consortium shall not be
used in advertising or otherwise to promote the sale, use or other dealings
in this Software without prior written authorization from the X Consortium.

Copyright 1990, 1991 by UniSoft Group Limited.

Permission to use, copy, modify, distribute, and sell this software and
its documentation for any purpose is hereby granted without fee,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of UniSoft not be
used in advertising or publicity pertaining to distribution of the
software without specific, written prior permission.  UniSoft
makes no representations about the suitability of this software for any
purpose.  It is provided "as is" without express or implied warranty.
 */

#include	"xtest.h"
#include	"X11/Xlib.h"
#include	"X11/Xutil.h"
#include	"X11/Xatom.h"

static XCharStruct perchar[] = {
	{0, 0, 0, 0, 0, 0},	/* 0 */
	{-8, -1, -8, 11, -8, 0},	/* 1 */
	{-7, -1, -8, 10, 0, 0},	/* 2 */
	{-7, 0, -8, 7, 3, 0},	/* 3 */
	{-7, -1, -7, 10, -8, 0},	/* 4 */
	{-7, -3, -7, 11, -8, 0},	/* 5 */
	{-10, 0, -10, 10, 0, 0},	/* 6 */
	{-3, 0, -4, 10, -5, 0},	/* 7 */
	{-3, -1, -5, 10, 0, 0},	/* 8 */
	{0, 0, 0, 10, -10, 0},	/* 9 */
	{0, 0, 0, 10, -10, 0},	/* 10 */
	{-6, -2, -6, 11, -8, 0},	/* 11 */
	{0, 0, 0, 10, -10, 0},	/* 12 */
	{0, 0, 0, 10, -10, 0},	/* 13 */
	{-7, -2, -7, 10, -8, 0},	/* 14 */
	{-16, -16, -16, 10, -10, 0},	/* 15 */
	{-8, -1, -8, 10, -8, 0},	/* 16 */
	{-13, 0, -14, 10, 0, 0},	/* 17 */
	{-13, 0, -14, 10, 0, 0},	/* 18 */
	{-16, 0, -16, 5, -3, 0},	/* 19 */
	{-8, 0, -9, 10, 0, 0},	/* 20 */
	{-8, 0, -9, 10, 0, 0},	/* 21 */
	{-8, 0, -8, 5, -3, 0},	/* 22 */
	{-7, -1, -7, 11, -8, 0},	/* 23 */
	{-12, -4, -16, 5, -3, 0},	/* 24 */
	{-9, -9, -9, 10, -10, 0},	/* 25 */
	{0, 0, 0, 10, -10, 0},	/* 26 */
	{0, 0, 0, 10, -10, 0},	/* 27 */
	{-8, -8, -8, 10, -10, 0},	/* 28 */
	{-6, -4, -6, -1, 3, 0},	/* 29 */
	{-8, -1, -8, 10, -8, 0},	/* 30 */
	{-7, -2, -7, 11, -7, 0},	/* 31 */
	{-7, -7, -7, 10, -10, 0},	/* 32 */
	{-3, -1, -4, 10, 0, 0},	/* 33 */
	{-6, -1, -7, 10, -6, 0},	/* 34 */
	{-11, -1, -12, 10, 0, 0},	/* 35 */
	{-8, -1, -9, 11, 1, 0},	/* 36 */
	{-13, -1, -14, 10, 0, 0},	/* 37 */
	{-10, -1, -11, 10, 0, 0},	/* 38 */
	{-3, 0, -4, 10, -5, 0},	/* 39 */
	{-5, -1, -6, 10, 2, 0},	/* 40 */
	{-5, -1, -6, 10, 2, 0},	/* 41 */
	{-6, -1, -7, 11, -5, 0},	/* 42 */
	{-9, -1, -10, 8, 0, 0},	/* 43 */
	{-3, -1, -4, 2, 3, 0},	/* 44 */
	{-8, -2, -9, 5, -3, 0},	/* 45 */
	{-3, -1, -4, 2, 0, 0},	/* 46 */
	{-7, -1, -8, 10, 0, 0},	/* 47 */
	{-8, -1, -9, 10, 0, 0},	/* 48 */
	{-7, -2, -9, 10, 0, 0},	/* 49 */
	{-8, -1, -9, 10, 0, 0},	/* 50 */
	{-8, -1, -9, 10, 0, 0},	/* 51 */
	{-8, -1, -9, 10, 0, 0},	/* 52 */
	{-8, -1, -9, 10, 0, 0},	/* 53 */
	{-8, -1, -9, 10, 0, 0},	/* 54 */
	{-8, -1, -9, 10, 0, 0},	/* 55 */
	{-8, -1, -9, 10, 0, 0},	/* 56 */
	{-8, -1, -9, 10, 0, 0},	/* 57 */
	{-3, -1, -4, 7, 0, 0},	/* 58 */
	{-3, -1, -4, 7, 3, 0},	/* 59 */
	{-7, -1, -8, 10, 0, 0},	/* 60 */
	{-7, -2, -8, 6, -1, 0},	/* 61 */
	{-7, -1, -8, 10, 0, 0},	/* 62 */
	{-7, -1, -8, 10, 0, 0},	/* 63 */
	{-13, -1, -14, 10, 0, 0},	/* 64 */
	{-8, 0, -9, 10, 0, 0},	/* 65 */
	{-7, 0, -8, 10, 0, 0},	/* 66 */
	{-8, 0, -9, 10, 0, 0},	/* 67 */
	{-8, 0, -9, 10, 0, 0},	/* 68 */
	{-7, 0, -8, 10, 0, 0},	/* 69 */
	{-7, 0, -8, 10, 0, 0},	/* 70 */
	{-9, 0, -10, 10, 0, 0},	/* 71 */
	{-8, 0, -9, 10, 0, 0},	/* 72 */
	{-2, 0, -3, 10, 0, 0},	/* 73 */
	{-6, 0, -7, 10, 0, 0},	/* 74 */
	{-8, 0, -9, 10, 0, 0},	/* 75 */
	{-6, 0, -7, 10, 0, 0},	/* 76 */
	{-11, 0, -12, 10, 0, 0},	/* 77 */
	{-8, 0, -9, 10, 0, 0},	/* 78 */
	{-9, 0, -10, 10, 0, 0},	/* 79 */
	{-7, 0, -8, 10, 0, 0},	/* 80 */
	{-9, 0, -10, 10, 1, 0},	/* 81 */
	{-8, 0, -9, 10, 0, 0},	/* 82 */
	{-7, 0, -8, 10, 0, 0},	/* 83 */
	{-8, 0, -9, 10, 0, 0},	/* 84 */
	{-8, 0, -9, 10, 0, 0},	/* 85 */
	{-8, 0, -9, 10, 0, 0},	/* 86 */
	{-13, 0, -14, 10, 0, 0},	/* 87 */
	{-8, 0, -9, 10, 0, 0},	/* 88 */
	{-8, 0, -9, 10, 0, 0},	/* 89 */
	{-8, 0, -9, 10, 0, 0},	/* 90 */
	{-6, -1, -7, 10, 3, 0},	/* 91 */
	{-7, -1, -8, 10, 0, 0},	/* 92 */
	{-6, -1, -7, 10, 3, 0},	/* 93 */
	{-7, -1, -8, 9, -1, 0},	/* 94 */
	{-9, -1, -10, 8, -2, 0},	/* 95 */
	{-3, 0, -4, 10, -5, 0},	/* 96 */
	{-7, 0, -8, 7, 0, 0},	/* 97 */
	{-7, 0, -8, 10, 0, 0},	/* 98 */
	{-7, 0, -8, 7, 0, 0},	/* 99 */
	{-7, 0, -8, 10, 0, 0},	/* 100 */
	{-7, 0, -8, 7, 0, 0},	/* 101 */
	{-5, 0, -6, 10, 0, 0},	/* 102 */
	{-7, 0, -8, 7, 3, 0},	/* 103 */
	{-7, 0, -8, 10, 0, 0},	/* 104 */
	{-2, 0, -3, 10, 0, 0},	/* 105 */
	{-4, 0, -5, 10, 2, 0},	/* 106 */
	{-7, 0, -8, 10, 0, 0},	/* 107 */
	{-2, 0, -3, 10, 0, 0},	/* 108 */
	{-10, 0, -11, 7, 0, 0},	/* 109 */
	{-7, 0, -8, 7, 0, 0},	/* 110 */
	{-7, 0, -8, 7, 0, 0},	/* 111 */
	{-7, 0, -8, 7, 3, 0},	/* 112 */
	{-7, 0, -8, 7, 3, 0},	/* 113 */
	{-5, 0, -6, 7, 0, 0},	/* 114 */
	{-6, 0, -7, 7, 0, 0},	/* 115 */
	{-5, 0, -6, 9, 0, 0},	/* 116 */
	{-7, 0, -8, 7, 0, 0},	/* 117 */
	{-8, 0, -9, 7, 0, 0},	/* 118 */
	{-11, 0, -12, 7, 0, 0},	/* 119 */
	{-6, 0, -7, 7, 0, 0},	/* 120 */
	{-7, 0, -8, 7, 3, 0},	/* 121 */
	{-6, 0, -7, 7, 0, 0},	/* 122 */
	{-7, -1, -8, 10, 3, 0},	/* 123 */
	{-4, -2, -5, 10, 3, 0},	/* 124 */
	{-7, -1, -8, 10, 3, 0},	/* 125 */
	{-9, -1, -10, 6, -3, 0},	/* 126 */
	{-8, -1, -8, 11, -8, 0},	/* 127 */
	{-7, -1, -8, 10, 0, 0},	/* 128 */
	{-7, 0, -8, 7, 3, 0},	/* 129 */
	{-7, -1, -7, 10, -8, 0},	/* 130 */
	{-7, -3, -7, 11, -8, 0},	/* 131 */
	{-10, 0, -10, 10, 0, 0},	/* 132 */
	{-3, 0, -4, 10, -5, 0},	/* 133 */
	{-3, -1, -5, 10, 0, 0},	/* 134 */
	{0, 0, 0, 10, -10, 0},	/* 135 */
	{0, 0, 0, 10, -10, 0},	/* 136 */
	{-6, -2, -6, 11, -8, 0},	/* 137 */
	{0, 0, 0, 10, -10, 0},	/* 138 */
	{0, 0, 0, 10, -10, 0},	/* 139 */
	{-7, -2, -7, 10, -8, 0},	/* 140 */
	{-16, -16, -16, 10, -10, 0},	/* 141 */
	{-8, -1, -8, 10, -8, 0},	/* 142 */
	{-13, 0, -14, 10, 0, 0},	/* 143 */
	{-13, 0, -14, 10, 0, 0},	/* 144 */
	{-16, 0, -16, 5, -3, 0},	/* 145 */
	{-8, 0, -9, 10, 0, 0},	/* 146 */
	{-8, 0, -9, 10, 0, 0},	/* 147 */
	{-8, 0, -8, 5, -3, 0},	/* 148 */
	{-7, -1, -7, 11, -8, 0},	/* 149 */
	{-12, -4, -16, 5, -3, 0},	/* 150 */
	{-9, -9, -9, 10, -10, 0},	/* 151 */
	{0, 0, 0, 10, -10, 0},	/* 152 */
	{0, 0, 0, 10, -10, 0},	/* 153 */
	{-8, -8, -8, 10, -10, 0},	/* 154 */
	{-6, -4, -6, -1, 3, 0},	/* 155 */
	{-8, -1, -8, 10, -8, 0},	/* 156 */
	{-7, -2, -7, 11, -7, 0},	/* 157 */
	{-7, -7, -7, 10, -10, 0},	/* 158 */
	{-3, -1, -4, 10, 0, 0},	/* 159 */
	{-6, -1, -7, 10, -6, 0},	/* 160 */
	{-11, -1, -12, 10, 0, 0},	/* 161 */
	{-8, -1, -9, 11, 1, 0},	/* 162 */
	{-13, -1, -14, 10, 0, 0},	/* 163 */
	{-10, -1, -11, 10, 0, 0},	/* 164 */
	{-3, 0, -4, 10, -5, 0},	/* 165 */
	{-5, -1, -6, 10, 2, 0},	/* 166 */
	{-5, -1, -6, 10, 2, 0},	/* 167 */
	{-6, -1, -7, 11, -5, 0},	/* 168 */
	{-9, -1, -10, 8, 0, 0},	/* 169 */
	{-3, -1, -4, 2, 3, 0},	/* 170 */
	{-8, -2, -9, 5, -3, 0},	/* 171 */
	{-3, -1, -4, 2, 0, 0},	/* 172 */
	{-7, -1, -8, 10, 0, 0},	/* 173 */
	{-8, -1, -9, 10, 0, 0},	/* 174 */
	{-7, -2, -9, 10, 0, 0},	/* 175 */
	{-8, -1, -9, 10, 0, 0},	/* 176 */
	{-8, -1, -9, 10, 0, 0},	/* 177 */
	{-8, -1, -9, 10, 0, 0},	/* 178 */
	{-8, -1, -9, 10, 0, 0},	/* 179 */
	{-8, -1, -9, 10, 0, 0},	/* 180 */
	{-8, -1, -9, 10, 0, 0},	/* 181 */
	{-8, -1, -9, 10, 0, 0},	/* 182 */
	{-8, -1, -9, 10, 0, 0},	/* 183 */
	{-3, -1, -4, 7, 0, 0},	/* 184 */
	{-3, -1, -4, 7, 3, 0},	/* 185 */
	{-7, -1, -8, 10, 0, 0},	/* 186 */
	{-7, -2, -8, 6, -1, 0},	/* 187 */
	{-7, -1, -8, 10, 0, 0},	/* 188 */
	{-7, -1, -8, 10, 0, 0},	/* 189 */
	{-13, -1, -14, 10, 0, 0},	/* 190 */
	{-8, 0, -9, 10, 0, 0},	/* 191 */
	{-7, 0, -8, 10, 0, 0},	/* 192 */
	{-8, 0, -9, 10, 0, 0},	/* 193 */
	{-8, 0, -9, 10, 0, 0},	/* 194 */
	{-7, 0, -8, 10, 0, 0},	/* 195 */
	{-7, 0, -8, 10, 0, 0},	/* 196 */
	{-9, 0, -10, 10, 0, 0},	/* 197 */
	{-8, 0, -9, 10, 0, 0},	/* 198 */
	{-2, 0, -3, 10, 0, 0},	/* 199 */
	{-6, 0, -7, 10, 0, 0},	/* 200 */
	{-8, 0, -9, 10, 0, 0},	/* 201 */
	{-6, 0, -7, 10, 0, 0},	/* 202 */
	{-11, 0, -12, 10, 0, 0},	/* 203 */
	{-8, 0, -9, 10, 0, 0},	/* 204 */
	{-9, 0, -10, 10, 0, 0},	/* 205 */
	{-7, 0, -8, 10, 0, 0},	/* 206 */
	{-9, 0, -10, 10, 1, 0},	/* 207 */
	{-8, 0, -9, 10, 0, 0},	/* 208 */
	{-7, 0, -8, 10, 0, 0},	/* 209 */
	{-8, 0, -9, 10, 0, 0},	/* 210 */
	{-8, 0, -9, 10, 0, 0},	/* 211 */
	{-8, 0, -9, 10, 0, 0},	/* 212 */
	{-13, 0, -14, 10, 0, 0},	/* 213 */
	{-8, 0, -9, 10, 0, 0},	/* 214 */
	{-8, 0, -9, 10, 0, 0},	/* 215 */
	{-8, 0, -9, 10, 0, 0},	/* 216 */
	{-6, -1, -7, 10, 3, 0},	/* 217 */
	{-7, -1, -8, 10, 0, 0},	/* 218 */
	{-6, -1, -7, 10, 3, 0},	/* 219 */
	{-7, -1, -8, 9, -1, 0},	/* 220 */
	{-9, -1, -10, 8, -2, 0},	/* 221 */
	{-3, 0, -4, 10, -5, 0},	/* 222 */
	{-7, 0, -8, 7, 0, 0},	/* 223 */
	{-7, 0, -8, 10, 0, 0},	/* 224 */
	{-7, 0, -8, 7, 0, 0},	/* 225 */
	{-7, 0, -8, 10, 0, 0},	/* 226 */
	{-7, 0, -8, 7, 0, 0},	/* 227 */
	{-5, 0, -6, 10, 0, 0},	/* 228 */
	{-7, 0, -8, 7, 3, 0},	/* 229 */
	{-7, 0, -8, 10, 0, 0},	/* 230 */
	{-2, 0, -3, 10, 0, 0},	/* 231 */
	{-4, 0, -5, 10, 2, 0},	/* 232 */
	{-7, 0, -8, 10, 0, 0},	/* 233 */
	{-2, 0, -3, 10, 0, 0},	/* 234 */
	{-10, 0, -11, 7, 0, 0},	/* 235 */
	{-7, 0, -8, 7, 0, 0},	/* 236 */
	{-7, 0, -8, 7, 0, 0},	/* 237 */
	{-7, 0, -8, 7, 3, 0},	/* 238 */
	{-7, 0, -8, 7, 3, 0},	/* 239 */
	{-5, 0, -6, 7, 0, 0},	/* 240 */
	{-6, 0, -7, 7, 0, 0},	/* 241 */
	{-5, 0, -6, 9, 0, 0},	/* 242 */
	{-7, 0, -8, 7, 0, 0},	/* 243 */
	{-8, 0, -9, 7, 0, 0},	/* 244 */
	{-11, 0, -12, 7, 0, 0},	/* 245 */
	{-6, 0, -7, 7, 0, 0},	/* 246 */
	{-7, 0, -8, 7, 3, 0},	/* 247 */
	{-6, 0, -7, 7, 0, 0},	/* 248 */
	{-7, -1, -8, 10, 3, 0},	/* 249 */
	{-4, -2, -5, 10, 3, 0},	/* 250 */
	{-7, -1, -8, 10, 3, 0},	/* 251 */
	{-9, -1, -10, 6, -3, 0},	/* 252 */
	{-8, -1, -8, 11, -8, 0},	/* 253 */
	{-7, -1, -8, 10, 0, 0},	/* 254 */
	{-7, 0, -8, 7, 3, 0},	/* 255 */
	{-7, -1, -7, 10, -8, 0},	/* 256 */
	{-7, -3, -7, 11, -8, 0},	/* 257 */
	{-10, 0, -10, 10, 0, 0},	/* 258 */
	{-3, 0, -4, 10, -5, 0},	/* 259 */
	{-3, -1, -5, 10, 0, 0},	/* 260 */
	{0, 0, 0, 10, -10, 0},	/* 261 */
	{0, 0, 0, 10, -10, 0},	/* 262 */
	{-6, -2, -6, 11, -8, 0},	/* 263 */
	{0, 0, 0, 10, -10, 0},	/* 264 */
	{0, 0, 0, 10, -10, 0},	/* 265 */
	{-7, -2, -7, 10, -8, 0},	/* 266 */
	{-16, -16, -16, 10, -10, 0},	/* 267 */
	{-8, -1, -8, 10, -8, 0},	/* 268 */
	{-13, 0, -14, 10, 0, 0},	/* 269 */
	{-13, 0, -14, 10, 0, 0},	/* 270 */
	{-16, 0, -16, 5, -3, 0},	/* 271 */
	{-8, 0, -9, 10, 0, 0},	/* 272 */
	{-8, 0, -9, 10, 0, 0},	/* 273 */
	{-8, 0, -8, 5, -3, 0},	/* 274 */
	{-7, -1, -7, 11, -8, 0},	/* 275 */
	{-12, -4, -16, 5, -3, 0},	/* 276 */
	{-9, -9, -9, 10, -10, 0},	/* 277 */
	{0, 0, 0, 10, -10, 0},	/* 278 */
	{0, 0, 0, 10, -10, 0},	/* 279 */
	{-8, -8, -8, 10, -10, 0},	/* 280 */
	{-6, -4, -6, -1, 3, 0},	/* 281 */
	{-8, -1, -8, 10, -8, 0},	/* 282 */
	{-7, -2, -7, 11, -7, 0},	/* 283 */
	{-7, -7, -7, 10, -10, 0},	/* 284 */
	{-3, -1, -4, 10, 0, 0},	/* 285 */
	{-6, -1, -7, 10, -6, 0},	/* 286 */
	{-11, -1, -12, 10, 0, 0},	/* 287 */
	{-8, -1, -9, 11, 1, 0},	/* 288 */
	{-13, -1, -14, 10, 0, 0},	/* 289 */
	{-10, -1, -11, 10, 0, 0},	/* 290 */
	{-3, 0, -4, 10, -5, 0},	/* 291 */
	{-5, -1, -6, 10, 2, 0},	/* 292 */
	{-5, -1, -6, 10, 2, 0},	/* 293 */
	{-6, -1, -7, 11, -5, 0},	/* 294 */
	{-9, -1, -10, 8, 0, 0},	/* 295 */
	{-3, -1, -4, 2, 3, 0},	/* 296 */
	{-8, -2, -9, 5, -3, 0},	/* 297 */
	{-3, -1, -4, 2, 0, 0},	/* 298 */
	{-7, -1, -8, 10, 0, 0},	/* 299 */
	{-8, -1, -9, 10, 0, 0},	/* 300 */
	{-7, -2, -9, 10, 0, 0},	/* 301 */
	{-8, -1, -9, 10, 0, 0},	/* 302 */
	{-8, -1, -9, 10, 0, 0},	/* 303 */
	{-8, -1, -9, 10, 0, 0},	/* 304 */
	{-8, -1, -9, 10, 0, 0},	/* 305 */
	{-8, -1, -9, 10, 0, 0},	/* 306 */
	{-8, -1, -9, 10, 0, 0},	/* 307 */
	{-8, -1, -9, 10, 0, 0},	/* 308 */
	{-8, -1, -9, 10, 0, 0},	/* 309 */
	{-3, -1, -4, 7, 0, 0},	/* 310 */
	{-3, -1, -4, 7, 3, 0},	/* 311 */
	{-7, -1, -8, 10, 0, 0},	/* 312 */
	{-7, -2, -8, 6, -1, 0},	/* 313 */
	{-7, -1, -8, 10, 0, 0},	/* 314 */
	{-7, -1, -8, 10, 0, 0},	/* 315 */
	{-13, -1, -14, 10, 0, 0},	/* 316 */
	{-8, 0, -9, 10, 0, 0},	/* 317 */
	{-7, 0, -8, 10, 0, 0},	/* 318 */
	{-8, 0, -9, 10, 0, 0},	/* 319 */
	{-8, 0, -9, 10, 0, 0},	/* 320 */
	{-7, 0, -8, 10, 0, 0},	/* 321 */
	{-7, 0, -8, 10, 0, 0},	/* 322 */
	{-9, 0, -10, 10, 0, 0},	/* 323 */
	{-8, 0, -9, 10, 0, 0},	/* 324 */
	{-2, 0, -3, 10, 0, 0},	/* 325 */
	{-6, 0, -7, 10, 0, 0},	/* 326 */
	{-8, 0, -9, 10, 0, 0},	/* 327 */
	{-6, 0, -7, 10, 0, 0},	/* 328 */
	{-11, 0, -12, 10, 0, 0},	/* 329 */
	{-8, 0, -9, 10, 0, 0},	/* 330 */
	{-9, 0, -10, 10, 0, 0},	/* 331 */
	{-7, 0, -8, 10, 0, 0},	/* 332 */
	{-9, 0, -10, 10, 1, 0},	/* 333 */
	{-8, 0, -9, 10, 0, 0},	/* 334 */
	{-7, 0, -8, 10, 0, 0},	/* 335 */
	{-8, 0, -9, 10, 0, 0},	/* 336 */
	{-8, 0, -9, 10, 0, 0},	/* 337 */
	{-8, 0, -9, 10, 0, 0},	/* 338 */
	{-13, 0, -14, 10, 0, 0},	/* 339 */
	{-8, 0, -9, 10, 0, 0},	/* 340 */
	{-8, 0, -9, 10, 0, 0},	/* 341 */
	{-8, 0, -9, 10, 0, 0},	/* 342 */
	{-6, -1, -7, 10, 3, 0},	/* 343 */
	{-7, -1, -8, 10, 0, 0},	/* 344 */
	{-6, -1, -7, 10, 3, 0},	/* 345 */
	{-7, -1, -8, 9, -1, 0},	/* 346 */
	{-9, -1, -10, 8, -2, 0},	/* 347 */
	{-3, 0, -4, 10, -5, 0},	/* 348 */
	{-7, 0, -8, 7, 0, 0},	/* 349 */
	{-7, 0, -8, 10, 0, 0},	/* 350 */
	{-7, 0, -8, 7, 0, 0},	/* 351 */
	{-7, 0, -8, 10, 0, 0},	/* 352 */
	{-7, 0, -8, 7, 0, 0},	/* 353 */
	{-5, 0, -6, 10, 0, 0},	/* 354 */
	{-7, 0, -8, 7, 3, 0},	/* 355 */
	{-7, 0, -8, 10, 0, 0},	/* 356 */
	{-2, 0, -3, 10, 0, 0},	/* 357 */
	{-4, 0, -5, 10, 2, 0},	/* 358 */
	{-7, 0, -8, 10, 0, 0},	/* 359 */
	{-2, 0, -3, 10, 0, 0},	/* 360 */
	{-10, 0, -11, 7, 0, 0},	/* 361 */
	{-7, 0, -8, 7, 0, 0},	/* 362 */
	{-7, 0, -8, 7, 0, 0},	/* 363 */
	{-7, 0, -8, 7, 3, 0},	/* 364 */
	{-7, 0, -8, 7, 3, 0},	/* 365 */
	{-5, 0, -6, 7, 0, 0},	/* 366 */
	{-6, 0, -7, 7, 0, 0},	/* 367 */
	{-5, 0, -6, 9, 0, 0},	/* 368 */
	{-7, 0, -8, 7, 0, 0},	/* 369 */
	{-8, 0, -9, 7, 0, 0},	/* 370 */
	{-11, 0, -12, 7, 0, 0},	/* 371 */
	{-6, 0, -7, 7, 0, 0},	/* 372 */
	{-7, 0, -8, 7, 3, 0},	/* 373 */
	{-6, 0, -7, 7, 0, 0},	/* 374 */
	{-7, -1, -8, 10, 3, 0},	/* 375 */
	{-4, -2, -5, 10, 3, 0},	/* 376 */
	{-7, -1, -8, 10, 3, 0},	/* 377 */
	{-9, -1, -10, 6, -3, 0},	/* 378 */
	{-8, -1, -8, 11, -8, 0},	/* 379 */
	{-7, -1, -8, 10, 0, 0},	/* 380 */
	{-7, 0, -8, 7, 3, 0},	/* 381 */
	{-7, -1, -7, 10, -8, 0},	/* 382 */
	{-7, -3, -7, 11, -8, 0},	/* 383 */
	{-10, 0, -10, 10, 0, 0},	/* 384 */
	{-3, 0, -4, 10, -5, 0},	/* 385 */
	{-3, -1, -5, 10, 0, 0},	/* 386 */
	{0, 0, 0, 10, -10, 0},	/* 387 */
	{0, 0, 0, 10, -10, 0},	/* 388 */
	{-6, -2, -6, 11, -8, 0},	/* 389 */
	{0, 0, 0, 10, -10, 0},	/* 390 */
	{0, 0, 0, 10, -10, 0},	/* 391 */
	{-7, -2, -7, 10, -8, 0},	/* 392 */
	{-16, -16, -16, 10, -10, 0},	/* 393 */
	{-8, -1, -8, 10, -8, 0},	/* 394 */
	{-13, 0, -14, 10, 0, 0},	/* 395 */
	{-13, 0, -14, 10, 0, 0},	/* 396 */
	{-16, 0, -16, 5, -3, 0},	/* 397 */
	{-8, 0, -9, 10, 0, 0},	/* 398 */
	{-8, 0, -9, 10, 0, 0},	/* 399 */
	{-8, 0, -8, 5, -3, 0},	/* 400 */
	{-7, -1, -7, 11, -8, 0},	/* 401 */
	{-12, -4, -16, 5, -3, 0},	/* 402 */
	{-9, -9, -9, 10, -10, 0},	/* 403 */
	{0, 0, 0, 10, -10, 0},	/* 404 */
	{0, 0, 0, 10, -10, 0},	/* 405 */
	{-8, -8, -8, 10, -10, 0},	/* 406 */
	{-6, -4, -6, -1, 3, 0},	/* 407 */
	{-8, -1, -8, 10, -8, 0},	/* 408 */
	{-7, -2, -7, 11, -7, 0},	/* 409 */
	{-7, -7, -7, 10, -10, 0},	/* 410 */
	{-3, -1, -4, 10, 0, 0},	/* 411 */
	{-6, -1, -7, 10, -6, 0},	/* 412 */
	{-11, -1, -12, 10, 0, 0},	/* 413 */
	{-8, -1, -9, 11, 1, 0},	/* 414 */
	{-13, -1, -14, 10, 0, 0},	/* 415 */
	{-10, -1, -11, 10, 0, 0},	/* 416 */
	{-3, 0, -4, 10, -5, 0},	/* 417 */
	{-5, -1, -6, 10, 2, 0},	/* 418 */
	{-5, -1, -6, 10, 2, 0},	/* 419 */
	{-6, -1, -7, 11, -5, 0},	/* 420 */
	{-9, -1, -10, 8, 0, 0},	/* 421 */
	{-3, -1, -4, 2, 3, 0},	/* 422 */
	{-8, -2, -9, 5, -3, 0},	/* 423 */
	{-3, -1, -4, 2, 0, 0},	/* 424 */
	{-7, -1, -8, 10, 0, 0},	/* 425 */
	{-8, -1, -9, 10, 0, 0},	/* 426 */
	{-7, -2, -9, 10, 0, 0},	/* 427 */
	{-8, -1, -9, 10, 0, 0},	/* 428 */
	{-8, -1, -9, 10, 0, 0},	/* 429 */
	{-8, -1, -9, 10, 0, 0},	/* 430 */
	{-8, -1, -9, 10, 0, 0},	/* 431 */
	{-8, -1, -9, 10, 0, 0},	/* 432 */
	{-8, -1, -9, 10, 0, 0},	/* 433 */
	{-8, -1, -9, 10, 0, 0},	/* 434 */
	{-8, -1, -9, 10, 0, 0},	/* 435 */
	{-3, -1, -4, 7, 0, 0},	/* 436 */
	{-3, -1, -4, 7, 3, 0},	/* 437 */
	{-7, -1, -8, 10, 0, 0},	/* 438 */
	{-7, -2, -8, 6, -1, 0},	/* 439 */
	{-7, -1, -8, 10, 0, 0},	/* 440 */
	{-7, -1, -8, 10, 0, 0},	/* 441 */
	{-13, -1, -14, 10, 0, 0},	/* 442 */
	{-8, 0, -9, 10, 0, 0},	/* 443 */
	{-7, 0, -8, 10, 0, 0},	/* 444 */
	{-8, 0, -9, 10, 0, 0},	/* 445 */
	{-8, 0, -9, 10, 0, 0},	/* 446 */
	{-7, 0, -8, 10, 0, 0},	/* 447 */
	{-7, 0, -8, 10, 0, 0},	/* 448 */
	{-9, 0, -10, 10, 0, 0},	/* 449 */
	{-8, 0, -9, 10, 0, 0},	/* 450 */
	{-2, 0, -3, 10, 0, 0},	/* 451 */
	{-6, 0, -7, 10, 0, 0},	/* 452 */
	{-8, 0, -9, 10, 0, 0},	/* 453 */
	{-6, 0, -7, 10, 0, 0},	/* 454 */
	{-11, 0, -12, 10, 0, 0},	/* 455 */
	{-8, 0, -9, 10, 0, 0},	/* 456 */
	{-9, 0, -10, 10, 0, 0},	/* 457 */
	{-7, 0, -8, 10, 0, 0},	/* 458 */
	{-9, 0, -10, 10, 1, 0},	/* 459 */
	{-8, 0, -9, 10, 0, 0},	/* 460 */
	{-7, 0, -8, 10, 0, 0},	/* 461 */
	{-8, 0, -9, 10, 0, 0},	/* 462 */
	{-8, 0, -9, 10, 0, 0},	/* 463 */
	{-8, 0, -9, 10, 0, 0},	/* 464 */
	{-13, 0, -14, 10, 0, 0},	/* 465 */
	{-8, 0, -9, 10, 0, 0},	/* 466 */
	{-8, 0, -9, 10, 0, 0},	/* 467 */
	{-8, 0, -9, 10, 0, 0},	/* 468 */
	{-6, -1, -7, 10, 3, 0},	/* 469 */
	{-7, -1, -8, 10, 0, 0},	/* 470 */
	{-6, -1, -7, 10, 3, 0},	/* 471 */
	{-7, -1, -8, 9, -1, 0},	/* 472 */
	{-9, -1, -10, 8, -2, 0},	/* 473 */
	{-3, 0, -4, 10, -5, 0},	/* 474 */
	{-7, 0, -8, 7, 0, 0},	/* 475 */
	{-7, 0, -8, 10, 0, 0},	/* 476 */
	{-7, 0, -8, 7, 0, 0},	/* 477 */
	{-7, 0, -8, 10, 0, 0},	/* 478 */
	{-7, 0, -8, 7, 0, 0},	/* 479 */
	{-5, 0, -6, 10, 0, 0},	/* 480 */
	{-7, 0, -8, 7, 3, 0},	/* 481 */
	{-7, 0, -8, 10, 0, 0},	/* 482 */
	{-2, 0, -3, 10, 0, 0},	/* 483 */
	{-4, 0, -5, 10, 2, 0},	/* 484 */
	{-7, 0, -8, 10, 0, 0},	/* 485 */
	{-2, 0, -3, 10, 0, 0},	/* 486 */
	{-10, 0, -11, 7, 0, 0},	/* 487 */
	{-7, 0, -8, 7, 0, 0},	/* 488 */
	{-7, 0, -8, 7, 0, 0},	/* 489 */
	{-7, 0, -8, 7, 3, 0},	/* 490 */
	{-7, 0, -8, 7, 3, 0},	/* 491 */
	{-5, 0, -6, 7, 0, 0},	/* 492 */
	{-6, 0, -7, 7, 0, 0},	/* 493 */
	{-5, 0, -6, 9, 0, 0},	/* 494 */
	{-7, 0, -8, 7, 0, 0},	/* 495 */
	{-8, 0, -9, 7, 0, 0},	/* 496 */
	{-11, 0, -12, 7, 0, 0},	/* 497 */
	{-6, 0, -7, 7, 0, 0},	/* 498 */
	{-7, 0, -8, 7, 3, 0},	/* 499 */
	{-6, 0, -7, 7, 0, 0},	/* 500 */
	{-7, -1, -8, 10, 3, 0},	/* 501 */
	{-4, -2, -5, 10, 3, 0},	/* 502 */
	{-7, -1, -8, 10, 3, 0},	/* 503 */
	{-9, -1, -10, 6, -3, 0},	/* 504 */
	{0, 0, 0, 0, 0, 0},	/* 505 */
	{0, 0, 0, 0, 0, 0},	/* 506 */
	{0, 0, 0, 0, 0, 0},	/* 507 */
	{0, 0, 0, 0, 0, 0},	/* 508 */
	{0, 0, 0, 0, 0, 0},	/* 509 */
	{0, 0, 0, 0, 0, 0},	/* 510 */
	{0, 0, 0, 0, 0, 0},	/* 511 */
};
static XFontProp props[] = {
	{XA_COPYRIGHT, 0},
	{XA_UNDERLINE_POSITION, 3},
	{XA_RESOLUTION, 78},
};

char	*xtfont6cpright = "These glyphs are unencumbered";

XFontStruct xtfont6 = {
	(XExtData*)0,
	(Font)0,
	FontRightToLeft,	/* direction */
	0,	/* min_byte2 */
	255,	/* max_byte2 */
	0,	/* min_byte1 */
	1,	/* max_byte1 */
	0,	/* all chars exist */
	2,	/* default char */
	3,	/* n_properties */
	props,
	{-16, -16, -16, -1, -10, 0},
#if XT_X_RELEASE == 6
        {-2, 0, -3, 11, 3, 0},
#else
        {0, 0, 0, 11, 3, 0},
#endif
	perchar,
	11,	/* font ascent */
	3,	/* font descent */
};
