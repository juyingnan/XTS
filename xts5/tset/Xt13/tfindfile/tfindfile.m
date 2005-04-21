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
$Header: /cvs/xtest/xtest/xts5/tset/Xt13/tfindfile/tfindfile.m,v 1.2 2005-04-21 09:40:42 ajosey Exp $

Copyright (c) 1999 The Open Group
Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt13/tfindfile/tfindfile.m
>># 
>># Description:
>>#	Tests for XtFindFile()
>># 
>># Modifications:
>># $Log: tfindfile.m,v $
>># Revision 1.2  2005-04-21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.2  2005/01/21 12:14:41  gwc
>># Updated copyright notice
>>#
>># Revision 8.1  1999/11/26 10:31:26  vsx
>># avoid fixed file locations (for exec-in-place false)
>>#
>># Revision 8.0  1998/12/23 23:38:25  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:27  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:27  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:00  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:19  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:18:32  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

char *filepath	= "/test/path/";
char *string_good1 = "/test/path/:";
Boolean FindFile1(string)
String string;
{
	check_str(string_good1, string, "String passed to predicate");
	return(TRUE);
}

char *string_good2 = "/test/path/%";
Boolean FindFile2(string)
String string;
{
	check_str(string_good2, string, "String passed to predicate");
	return(TRUE);
}
char *string_good3_1 = "/test/path/128data1";
char *string_good3_2 = "/test/path/data1128";
Boolean FindFile3(string)
String string;
{
int count3;

	count3 = avs_get_event(1);

	if (count3 == 0) {
		tet_infoline("TEST: First string passed to predicate has substitutions");
		check_str(string_good3_1, string, "First string passed to predicate");
		avs_set_event(1, 1);
		tet_infoline("PREP: Return false for first string");
		return(FALSE);
	}
	if (count3 == 1) {
		tet_infoline("TEST: Second string passed to predicate has substitutions");
		check_str(string_good3_2, string, "Second string passed to predicate");
		avs_set_event(1, 2);
		tet_infoline("PREP: Return true for second string");
		return(TRUE);
	}
	sprintf(ebuf, "ERROR: path contained two strings but predicate called %d times", count3++);
	avs_set_event(1, count3);
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
}

char *string_good5 = "/test/path/%";
Boolean FindFile5(string)
String string;
{
	return(FALSE);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtFindFile Xt13
String
XtFindFile(path, substitutions, num_substitutions, predicate)
>>ASSERTION Good A
A successful call to
String XtFindFile(path, substitutions, num_substitutions, predicate)
shall obtain each colon-separated string from 
.A path,
replace in this string each occurrence of a percent character 
followed by a character other than a ':' or '%' with the 
substitution field of the structure in the list of substitutions 
specified by
.A substitutions
that has the match field equal to the character 
following the percent character, pass each resulting string 
to the procedure
.A predicate,
until a a string is found for which this procedure returns True, and 
return this string.
>>CODE
char path[1024];
SubstitutionRec sub[2];
Cardinal num_substitutions;
String str;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tfindfile3", "XtFindFile");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get path name");
	strcpy(path, filepath);
	strcat(path, "%d%s:");
	strcat(path, filepath);
	strcat(path, "%s%d");
	tet_infoline("TEST: Call XtFindFile with path containing two file names");
	sub[0].match = 's';
	sub[0].substitution = "data1";
	sub[1].match = 'd';
	sub[1].substitution = "128";
	str = XtFindFile(path, &sub[0], 2, FindFile3);
	if (str == NULL) {
		tet_infoline("ERROR: XtFindFile returned NULL");
		tet_result(TET_FAIL);
		exit(0);
	}
	tet_infoline("TEST: Returned string is second path name after substitutions");
	check_str(string_good3_2, str, "String");
	LKROF(pid2, AVSXTTIMEOUT-2);
	if (avs_get_event(1) == 0) {
		tet_infoline("ERROR: predicate was never called");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
When no string in the colon-separated list of strings specified by
.A path
yields a True return from the procedure
.A predicate
a call to
String XtFindFile(path, substitutions, num_substitutions, predicate)
shall return NULL.
>>CODE
char path[1024];
SubstitutionRec sub[1];
Cardinal num_substitutions;
String str;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tfindfile5", "XtFindFile");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get path name");
	strcpy(path, filepath);
	strcat(path, "%s");
	tet_infoline("TEST: No match yields NULL");
	sub[0].match = 's';
	sub[0].substitution = "data1";
	str = XtFindFile(path, &sub[0], 1, FindFile5);
	if (str != NULL) {
		tet_infoline("ERROR: XtFindFile did not return NULL");
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
String XtFindFile(path, substitutions, num_substitutions, predicate)
shall replace each "%:" sequences in 
.A path 
by a single colon before passing it to the procedure
.A predicate.
>>CODE
char path[1024];
SubstitutionRec sub[1];
Cardinal num_substitutions;
String str;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tfindfile1", "XtFindFile");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get path name");
	strcpy(path, filepath);
	strcat(path, "%:");
	tet_infoline("TEST: Character sequence of percent colon replaced to colon");
	sub[0].match = 's';
	sub[0].substitution = "data1";
	str = XtFindFile(path, &sub[0], 1, FindFile1);
	if (str == NULL) {
		tet_infoline("ERROR: XtFindFile returned NULL");
		tet_result(TET_FAIL);
		exit(0);
	}
	tet_infoline("TEST: Returned string");
	check_str(string_good1, str, "String");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
String XtFindFile(path, substitutions, num_substitutions, predicate)
shall replace each "%%" sequences in 
.A path 
by a single percent character before passing it to the procedure
.A predicate.
>>CODE
char path[1024];
SubstitutionRec sub[1];
Cardinal num_substitutions;
String str;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tfindfile2", "XtFindFile");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get path name");
	strcpy(path, filepath);
	strcat(path, "%%");
	tet_infoline("TEST: Character sequence percent precent replaced with percent");
	sub[0].match = 's';
	sub[0].substitution = "data1";
	str = XtFindFile(path, &sub[0], 1, FindFile2);
	if (str == NULL) {
		tet_infoline("ERROR: XtFindFile returned NULL");
		tet_result(TET_FAIL);
		exit(0);
	}
	tet_infoline("TEST: Returned string");
	check_str(string_good2, str, "String");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good D 3
If the operating system does not interpret multiple 
embedded name separators in a path in the same way as a single seperator:
A call to
String XtFindFile(path, substitutions, num_substitutions, predicate)
shall replace multiple embedded name seperators in each string specified by
.A path
with a single seperator character after all other substitutions are made and
before passing it to the procedure
.A predicate.
>>ASSERTION Good A
When 
.A predicate 
is NULL a call to
String XtFindFile(path, substitutions, num_substitutions, predicate)
shall return a string specified in 
.A path
that matches a file that is readable and not a directory.
>>CODE
char path[1024];
SubstitutionRec sub[1];
Cardinal num_substitutions;
String str;
char string_good4[1024];
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tfindfile4", "XtFindFile");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get path name");
	if (getcwd(path, sizeof(path)-3) == NULL) {
		tet_infoline("ERROR: getcwd() returned NULL");
		tet_result(TET_UNRESOLVED);
		exit(0);
	}
	strcat(path, "/%s");
	tet_infoline("TEST: Character sequence percent character replaced by");
	tet_infoline("      corresponding match");
	sub[0].match = 's';
	sub[0].substitution = "data1";
	str = XtFindFile(path, &sub[0], 1, NULL);
	if (str == NULL) {
		tet_infoline("ERROR: XtFindFile returned NULL");
		tet_result(TET_FAIL);
		exit(0);
	}
	tet_infoline("PREP: Get data1 file path");
	if (getcwd(string_good4, sizeof(string_good4)-6) == NULL) {
		tet_infoline("ERROR: getcwd() returned NULL");
		tet_result(TET_UNRESOLVED);
		exit(0);
	}
	strcat(string_good4, "/data1");
	tet_infoline("TEST: Returned string");
	check_str(string_good4, str, "String");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When 
.A predicate 
is NULL and no file that is readable, not a directory and matches 
any of the specified file names in
.A path
is found a call to
String XtFindFile(path, substitutions, num_substitutions, predicate)
shall return NULL.
>>CODE
char path[1024];
SubstitutionRec sub[1];
Cardinal num_substitutions;
String str;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tfindfile4", "XtFindFile");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get path name");
	if (getcwd(path, sizeof(path)-3) == NULL) {
		tet_infoline("ERROR: getcwd() returned NULL");
		tet_result(TET_UNRESOLVED);
		exit(0);
	}
	strcat(path, "/%s");
	tet_infoline("TEST: Call XtFindFile for non-existent file");
	sub[0].match = 's';
	sub[0].substitution = "data5";
	str = XtFindFile(path, &sub[0], 1, NULL);
	if (str != NULL) {
		tet_infoline("ERROR: XtFindFile did not return NULL");
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
