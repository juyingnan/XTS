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
*
* (C) Copyright 2000-2001 The Open Group
* (C) Copyright 1996 Applied Testing Technology, Inc.
* (C) Copyright 1996 X/Open Company Limited
*
* All rights reserved.  No part of this source code may be reproduced,
* stored in a retrieval system, or transmitted, in any form or by any
* means, electronic, mechanical, photocopying, recording or otherwise,
* except as stated in the end-user licence agreement, without the prior
* permission of the copyright owners.
*
* X/Open and the 'X' symbol are trademarks of X/Open Company Limited in
* the UK and other countries.
* Motif is a trademark of The Open Software Foundation, Inc.
*
* Project: Common report generator for X/Open test suites
*
* File:	vsurpt.c, vswrpt.c, vsmrpt.c
*
* Description:
*	Report Generator
*
* Modifications:
* $Log: vswrpt.c,v $
* Revision 1.3  2005-11-03 08:42:01  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.2  2005/04/21 09:40:42  ajosey
* resync to VSW5.1.5
*
* Revision 8.4  2005/01/20 15:53:34  gwc
* Updated copyright notice
*
* Revision 8.3  2001/09/11 15:35:17  vsx
* Make commandline[] bigger to allow for v. long command lines
*
* Revision 8.2  2000/01/05 11:21:06  vsx
* Fix Year2000 bug reading year from journal
*
* Revision 8.1  1999/11/09 17:06:26  vsx
* Release 5.1.1beta
*
* Revision 8.0  1998/12/23 23:24:19  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:42:29  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.1  1998/08/07 02:27:36  andy
* Changed store to lstore.
*
* Revision 6.0  1998/03/02 05:16:45  tbr
* Branch point for Release 5.0.1
*
* Revision 5.1  1998/02/05 06:38:35  andy
* Accomodate record type 5 produced by TETware.
*
* Revision 5.0  1998/01/26 03:13:18  tbr
* Branch point for Release 5.0.1b1
*
* Revision 1.3  1998/01/13 08:05:50  andy
* In -w mode continue rather than fail if a directory in results does
* not contain a journal.
*
* Revision 1.2  1997/10/26 22:37:35  andy
* Editoail
*
* Revision 1.1  1996/07/09  23:49:56  andy
* Initial revision
*
*/

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <libgen.h>
#include <dirent.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/utsname.h>
#include <pwd.h>
#include <time.h>

static void parseinidle(void);

#define OPTIONS	":f:d:j:s:t:x:hcuvw"

/* detail of additional information reporting*/
int	detail, scope;

char	verbuf[81];
char	specverbuf[81];
char	test_dir[16];
char	test_flag[32];
char	vendor_name[64];
char	test_name[16];
char	test_prefix[16];
char	doc_dir[16];
char	special1[16];
char	special2[16];
char	*bname;
int	print_config_vars=0;
int	xopen_report = 0;

struct	utsname	ouruname;

/*input file name*/
char 	*infile;
/*where its stored if not user provided*/
char	inbuf[512];

/*a buffer to play with*/
char	tmpbuf[512];

/*stream for the journal file*/
FILE	*jfile;

/*goodies for the summary report*/
/*time test run started (from TCC start)*/
char	starttime[64];
/*time test run ended (from TCC end)*/
char	endtime[64];
/*test run user (from TCC start)*/
char	username[64];
/*test command line (from TCC start)*/
char	commandline[512];
/*number of build errors*/
int	nbuilderr = 0;
/*number of TCC errors*/
int	ntccerr = 0;
/*number of TCM errors*/
int	ntcmerr = 0;
/*number of NORESULT errors*/
int	nnoresult = 0;

/*report detail on only a specific case?*/
int	freportcase = 0;
/*case to report on*/
char *reportcase;
/*report detail on this case?*/
int	freportthiscase = 0;
/*found the case wanted?*/
int	ffoundcase = 0;
#define NSECTS	64

#define SECT_MISC	0
#define SECT_BASE	1
#define SECT_CURSES	2
#define SECT_HEADERS	3
#define SECT_NET	4
#define SECT_UTIL	5

/*info about the sections*/
struct sect {
	int	expectedareas;
	int	expectedtests;
	int	expecteduntested;
	int	expectednotinuse;
	int	actualareas;
	int	actualtests;
	int	npass;
	int	nfail;
	int	nabort;
	int	nunresolved;
	int	nuninitiated;
	int	nunsupported;
	int	nuntested;
	int	nnotinuse;
	int	nnoresult;
	int	nwarning;
	int	nfip;
	char	name[32];
} sects[NSECTS];

/*index of this section*/
int	thissect = 0;
/*number of sections run*/
int	nsects;

/*name of the current area*/
char areaname[128];
/*name of the current section*/
char sectionname[128] = "Discrete Tests";
/*number of tests in the current area*/
int	expectedtests;
int	actualtests = 0;
/*current filename being build/texted/cleaned*/
char	currentfile[256];

int	fabort=0;

/*message type*/
int	mtype;
/*messages read in here*/
char	linebuf[512];
/*pointer into where we are in the message*/
char	*pline;

/*state of the enterprise*/
int	state;
/*the states */
#define S_START		0
#define S_CONFIG	1
#define	S_IDLE		2
#define	S_BUILD		3
#define	S_EXEC		4
#define	S_CLEAN		5

/*Whether we have printed the header that starts the detial part of the report*/
int	fDetailHeaderPrinted;
/*Whether we have printed the header that starts the current section*/
int	fSectionNamePrinted;
/*Whether we have printed the header that starts the current area*/
int	fAreaNamePrinted;

/*activity counter*/
int	activity = -1;
/*number of contexts active*/
int	ncontexts;
#define NUM_CONTEXTS 16
/*contexts*/
int	contexts[NUM_CONTEXTS];

#define SBLINESTORE 8192
#define SDLINESTORE 8192

/*number of lines in the store for test output*/
int storecnt, storemax = 0;
/*stored line pointers for test output*/
char **lstore = NULL;
/*number of lines in the store for build output*/
int bstorecnt;
/*stored line pointers for build output*/
char *bstore[SBLINESTORE];

/*errors about excess tests purposes in test cases go here*/
/*number of lines in the delay store*/
int dstorecnt;
/*delayed stored line pointers*/
char *dstore[SDLINESTORE];

/*test return values*/
#define R_PASS		0
#define R_FAIL		1
#define R_UNSUPPORTED	2
#define R_UNINITIATED	3
#define R_UNRESOLVED	4
#define R_UNTESTED	5
#define R_NORESULT	6
#define R_NOTINUSE	7
#define R_WARNING	101
#define R_FIP		102
#define R_ABORT		103

int	fFirst520;
int	 lineno;

/*pointer into where we are in the message*/
char	*pline2, *pline3;

/* TET_ROOT */
char	*tet_root;
#ifndef DEFAULT_TET_ROOT
#define DEFAULT_TET_ROOT "."
#endif

/* version */
#ifndef PACKAGE_VERSION
#define PACKAGE_VERSION ""
#endif

static void whatj(void)
{
	DIR	*dirp;
	struct	 dirent	*dp;
	struct	 stat	sbuf;
	char	ttmp[5];
	struct tm mytm;
	time_t	mytime;
	char	starttime[64];
	char	strbuf[64];
	FILE 	*fsort;


	/*find the results directory*/
	sprintf(tmpbuf, "%s/%s/results", tet_root, test_dir);
	if ((dirp = opendir(tmpbuf)) == NULL) {
		perror("cannot open results directory");
		exit(2);
	}
	if ((fsort = popen("sort", "w")) == NULL) {
		perror("Cannot open pipe to sort");
		exit(2);
	}

	printf("                           %s JOURNAL SUMMARY\n\n", test_name);

	/*skip . and ..*/
	dp = readdir(dirp);
	dp = readdir(dirp);

	while ((dp = readdir(dirp)) != NULL) {
		sprintf(tmpbuf, "%s/%s/results/%s", tet_root, test_dir,
			dp->d_name);
#ifdef CDEBUG
fprintf(stderr, "dir: %s\n", tmpbuf);
#endif
		if (stat(tmpbuf, &sbuf) != 0) {
			perror("whatj: no results sub-directories");
			exit(2);
		}

		/*ignore regular files that might sneak in*/
		if (S_ISDIR(sbuf.st_mode) == 0)
			continue;

		strcat(tmpbuf, "/journal");

		/*open the journal file for read*/
		jfile = fopen(tmpbuf, "r");
		if (jfile == NULL) {
			continue;
		}

		fgets(linebuf, sizeof(linebuf), jfile);
#ifdef CDEBUG
fprintf(stderr, "%s", linebuf);
fflush(stderr);
#endif
		/*get the message type number*/
		pline = strtok(&linebuf[0], "|");

		if (atoi(pline) == 0) {
			/*skip tet version*/
			pline = strtok(NULL, " ");
			/*get start time*/
			pline = strtok(NULL, "|");
			strcpy(starttime, pline);
			/*skip "User:*/
			pline = strtok(NULL, " ");
			/*get user*/
			pline3 = strtok(NULL, " ");
			/*get command line*/
			pline = strtok(NULL, ":");
			pline2 = strtok(NULL, "\n");
			pline = strtok(&starttime[0], ":");
			mytm.tm_hour=atoi(pline);
			pline = strtok(NULL, ":");
			mytm.tm_min=atoi(pline);
			pline = strtok(NULL, " ");
			mytm.tm_sec=atoi(pline);
			pline = strtok(NULL, "\0");
			strncpy(ttmp, pline, 4);	
			ttmp[4]= 0;
			mytm.tm_year=atoi(ttmp)-1900;
			strncpy(ttmp, pline+4, 2);	
			ttmp[2]= 0;
			mytm.tm_mon=atoi(ttmp)-1;
			strncpy(ttmp, pline+6, 2);	
			mytm.tm_mday=atoi(ttmp);
			mytm.tm_isdst=-1;
			mytime = mktime(&mytm);
			strftime(strbuf, sizeof(strbuf), "%a %b %d %r", &mytm);
			fprintf(fsort, "%-8s  %s   %-6s   %s\n", dp->d_name, strbuf, pline3, pline2);
		}
	fclose(jfile);

	}
	pclose(fsort);
}

/*save a line for possible printing later*/
static void store_line(char *line, int indent)
{
	char * spaceptr;
	int i;

	/*do not print troubleshooting info in "reasonable detail" mode*/
/*
	if (detail == 1)
		if (strstr(line, "CHECK:") != (char *)NULL)
			return;
*/

	if (storecnt == storemax) {
/*
		fprintf(stderr, "Realloc at %d lines\n", storemax);
*/
		lstore = realloc(lstore, (storemax * sizeof(char *)) + (4096 *sizeof(char *)));
		if (lstore == NULL) {
			fprintf(stderr, "Line store overflow, journal line %d, line %d for this test\n", lineno, storemax+1);
			exit(2);
		}
		storemax += 4096;
	}

	if (strlen(line) == 0)
		return;

	lstore[storecnt] = (char *)malloc(strlen(line)+1+(2*indent));
	if (lstore[storecnt] == NULL) {
		perror("Cannot malloc buffer space for line");
		exit(2);
	}
	spaceptr = lstore[storecnt];
	for (i = 0; i < indent; i++) {
		*spaceptr = ' ';
		spaceptr++;
	}
	strcpy(spaceptr, line);
#ifdef CDEBUG
printf("** Stored #%d (%d): %s\n", storecnt, strlen(line), line);
#endif

	storecnt++;
}

/*print the assertion part of the saved lines*/
static void print_assert(void)
{
int	i;

	if (storecnt == 0)
		return;
	for(i = 0; i < storecnt; i++) {
		if ((strstr(lstore[i], "PREP") == 0) && (strstr(lstore[i], "CLEANUP") == 0) && (strstr(lstore[i], "TEST") == 0) && (strstr(lstore[i], "INFO") == 0)  && (strstr(lstore[i], "ERROR") == 0) && (strstr(lstore[i], "WARNING") == 0) && (strstr(lstore[i], "TRACE") == 0)) 
			printf("%s", lstore[i]);
		else
			return;
	}
}

/*print the saved lines*/
static void print_store(void)
{
int	i;

	if (storecnt == 0)
		return;
	for(i = 0; i < storecnt; i++) {
		printf("%s", lstore[i]);
#ifdef CDEBUG
printf("** Printed #%d (%d): %s\n", i, strlen(lstore[i]), lstore[i]);
#endif
	}
}

/*discard the saved lines*/
static void purge_store(void)
{
int	i;
#ifdef CDEBUG
printf("** Purge %d\n", storecnt);
#endif

	if (storecnt == 0)
		return;

	for(i = 0; i < storecnt; i++)
		free(lstore[i]);

	storecnt = 0;

}

/*save a build line for possible printing later*/
static void store_bline(char *line)
{
	if (bstorecnt == SBLINESTORE) {
		fprintf(stderr, "Bline store overflow, line %d\n", lineno);
		exit(2);
	}

	if (strlen(line) == 0)
		return;

	bstore[bstorecnt] = (char *)malloc(strlen(line)+1);
	if (bstore[bstorecnt] ==  NULL) {
		perror("Cannot malloc buffer space for bline");
		exit(2);
	}
	strcpy(bstore[bstorecnt], line);
#ifdef CDEBUG
printf("** Stored #%d (%d): %s\n", bstorecnt, strlen(line), line);
#endif

	bstorecnt++;
}

/*print the saved build lines*/
static void print_bstore(int range)
{
int	i;

	if (bstorecnt == 0)
		return;
	if (range == -1)
		range = bstorecnt;
	if (range > bstorecnt)
		range = bstorecnt;
	for(i = 0; i < range; i++) {
		printf("%s", bstore[i]);
#ifdef CDEBUG
printf("** Printed #%d (%d): %s\n", i, strlen(bstore[i]), bstore[i]);
#endif
	}
	if (range < bstorecnt)
		printf("Compiler output truncated at %d lines, %d lines produced\n", range, bstorecnt);
}

/*discard the saved build lines*/
static void purge_bstore(void)
{
int	i;
#ifdef CDEBUG
printf("** Purge %d\n", bstorecnt);
#endif

	if (bstorecnt == 0)
		return;

	for(i = 0; i < bstorecnt; i++)
		free(bstore[i]);

	bstorecnt = 0;

}

/*save a line for printing much later*/
static void dstore_line(char *line)
{
	if (dstorecnt == SDLINESTORE) {
		fprintf(stderr, "Dline store overflow, line %d\n", lineno);
		exit(2);
	}

	if (strlen(line) == 0)
		return;

	dstore[dstorecnt] = (char *)malloc(strlen(line)+1);
	if (dstore[dstorecnt] == NULL) {
		perror("Cannot malloc buffer space for dline");
		exit(2);
	}
	strcpy(dstore[dstorecnt], line);
#ifdef CDEBUG
printf("** d-Stored #%d (%d): %s\n", dstorecnt, strlen(line), line);
#endif

	dstorecnt++;
}

/*print the d-saved lines*/
static void print_dstore(void)
{
int	i;

	if (dstorecnt == 0)
		return;
	printf("\n");
	for(i = 0; i < dstorecnt; i++) {
		printf("%s", dstore[i]);
#ifdef CDEBUG
printf("** Printed #%d (%d): %s\n", i, strlen(dstore[i]), dstore[i]);
#endif
	}
}

/* print all detailed report header info not printed yet*/
static void print_header(void)
{
	if (fDetailHeaderPrinted == 0) {
		if (xopen_report != 2) {
/*
		printf("                          %s\n", vendor_name);
*/
		printf("                           %s DETAILED RESULTS REPORT\n\n", test_name);
		fDetailHeaderPrinted = 1;
		}
	}

	if (fSectionNamePrinted == 0) {
		printf("\nSECTION: %s\n", sectionname);
		fSectionNamePrinted = 1;
	}

	if (fAreaNamePrinted == 0) {
		printf("\nTEST CASE: %s\n", areaname);
		fAreaNamePrinted = 1;
	}
}

/* check current activity against expected*/
static void check_activity(int current)
{
/*

	if (current != activity) {
		print_header();
		fprintf(stderr, "Activity number is %d, expected %d, line %d\n", current, activity, lineno);
		exit(2);
	}
*/
}

/*parse messages in the start state*/
/*handles message TCC Start (type 0)*/
static void parseinstart(void)
{
	switch (mtype) {
	/*TCC Start*/
	case 0:
		/*skip tet version*/
		pline = strtok(NULL, " ");
		/*get start time*/
		pline = strtok(NULL, "|");
		strcpy(starttime, pline);
		/*skip "User:*/
		pline = strtok(NULL, " ");
		/*get user*/
		pline = strtok(NULL, " ");
		strcpy(username, pline);
		/*get command line*/
		pline = strtok(NULL, ":");
		pline = strtok(NULL, "\n");
		strcpy(commandline, pline);
		state = S_CONFIG;
		break;
	/*TCM message*/
	case 510:
		if (detail != 2) {
			print_header();
			printf("\nTCM Error\n");
			pline = strtok(NULL, "|");
			pline = strtok(NULL, "\n");
			printf("%s\n", pline);
		}
		ntcmerr++;
		break;
	/*operator abort*/
	case 90:
		print_header();
		printf("\nOperator abort\n");
		state=S_IDLE;
		break;
	/*TCC message*/
	case 50:
		if (detail != 2) {
			print_header();
			printf("\nTCC Error\n");
			printf("%s", &linebuf[4]);
		}
		ntccerr++;
		break;
	default:

		if (mtype == 5) {
			return;
		}

		fprintf(stderr, "Illegal record (type = %d) in START state, line %d\n", mtype, lineno);
		exit(2);
	}
}

/*parse messages in the config state*/
/*handles message types 20, 30, 40)*/
static void parseinconfig(void)
{
	if (mtype == 70) {
		state = S_IDLE;
		parseinidle();
		return;
	}

	/*operator abort*/
	if (mtype == 90) {
		print_header();
		printf("\nOperator abort\n");
		state=S_IDLE;
		return;
	}

	/*TCC message*/
	if (mtype == 50) {
		if (detail != 2) {
			print_header();
			printf("\nTCC Error\n");
			printf("%s", &linebuf[4]);
		}
		ntccerr++;
		return;
	}

	if (mtype == 5) {
		return;
	}

	if ((mtype == 30) && (print_config_vars == 1)) {
		pline = strtok(NULL, "|");
		printf("%s", pline);
	}

	if ((mtype != 20) && (mtype != 30) && (mtype != 40)) {
		fprintf(stderr, "Illegal record (type = %d) in CONFIG state, line %d\n", mtype, lineno);
		exit(2);
	}
}

/*parse messages in the idle state between tests*/
/*handles message types 70, 10, 110, 300, 900)*/
static void parseinidle(void)
{
	int	i;

	switch (mtype) {
	/*TC Start*/
	case 10:
		pline = strtok(NULL, " ");
		activity++;
		check_activity(atoi(pline));
		pline = strtok(NULL, " ");
		strcpy(currentfile, pline);
		state=S_EXEC;
		break;
	/*Build start*/
	case 110:
		pline = strtok(NULL, " ");
		activity++;
		check_activity(atoi(pline));
		pline = strtok(NULL, " ");
		strcpy(currentfile, pline);
		state=S_BUILD;
		purge_bstore();
		break;
	/*Clean start*/
	case 300:
		state=S_CLEAN;
		pline = strtok(NULL, " ");
		activity++;
		check_activity(atoi(pline));
		break;
	/*TCC End*/
	case 900:
		if ((actualtests < expectedtests) && (expectedtests != 0)) {
			if ((xopen_report != 2) && (detail != 2) && (scope < 3) && (freportthiscase == 1))
				print_header();
			if ((xopen_report != 2) && (detail != 3) && (detail != 2) && (scope < 3) && (freportthiscase == 1)) {
				if (expectedtests-actualtests == 1) {
					printf("\nTEST PURPOSE #%d\n", actualtests+1);
					if (fabort == 0)
						printf("%d UNINITIATED\n", actualtests+1);
					else
						printf("%d ABORT\n", actualtests+1);
				}
				else {
					if (fabort == 0)
						printf("\nTEST PURPOSES #%d to #%d UNINITIATED\n", actualtests+1, expectedtests);	
					else
						printf("\nTEST PURPOSES #%d to #%d ABORT\n", actualtests+1, expectedtests);	
				}
			}

			if ((xopen_report != 2) && (detail == 3) && (scope < 3) && (freportthiscase == 1)) {
				for (i = actualtests+1; i<= expectedtests; i++) {
					if (fabort == 0)
						printf("%d UNINITIATED\n", i);
					else
						printf("%d ABORT\n", i);
				}
			}
			for (i = actualtests+1; i<= expectedtests; i++) {
				if (fabort == 0)
					sects[thissect].nuninitiated++;
				else
					sects[thissect].nabort++;
				sects[thissect].actualtests++;
				actualtests++;
			}
			fabort = 0;
		}
		if (actualtests > expectedtests) {
			if (thissect != 0) {
			sprintf(tmpbuf, "ERROR: Test Case %s has %d Test Purposes, should have %d.\n", areaname, actualtests, expectedtests);
			dstore_line(tmpbuf);
			}
		}
	
		state=S_START;
		/*get end time*/
		pline = strtok(NULL, "|");
		strcpy(endtime, pline);
		break;
	/*Scenario message*/
	case 70:
		if (print_config_vars == 1)
			exit(0);
		/*message from scenario file should be one of ours*/
		pline = strtok(NULL, "|");
		if (*pline == '\"')
			pline++;
		pline = strtok(pline, " ");
		if (strcmp(pline, test_flag) != 0) {
			fprintf(stderr, "Illegal record (type = %d) in IDLE state, line %d\n", mtype, lineno);
			fprintf(stderr, "%s\n", pline);
			exit(2);
		}

		if (actualtests < expectedtests) {
			if ((xopen_report != 2) && (detail != 2) && (scope < 3) && (freportthiscase == 1))
				print_header();
			if ((xopen_report != 2) && (detail != 3) && (detail != 2) && (scope < 3) && (freportthiscase == 1)) {
				if (expectedtests-actualtests == 1) {
					printf("\nTEST PURPOSE #%d\n", actualtests+1);
					if (fabort == 0) 
						printf("%d UNINITIATED\n", actualtests+1);
					else
						printf("%d ABORT\n", actualtests+1);
				}
				else {
					if (fabort == 0) 
						printf("\nTEST PURPOSES #%d to #%d UNINITIATED\n", actualtests+1, expectedtests);	
					else
						printf("\nTEST PURPOSES #%d to #%d ABORT\n", actualtests+1, expectedtests);	
				}
			}

			if ((xopen_report != 2) && (detail == 3) && (scope < 3) && (freportthiscase == 1))
				for (i = actualtests+1; i<= expectedtests; i++) {
					if (fabort == 0)
							printf("%d UNINITIATED\n", i);
					else
							printf("%d ABORT\n", i);
				}
			for (i = actualtests+1; i<= expectedtests; i++) {
				if (fabort == 0)
					sects[thissect].nuninitiated++;
				else
					sects[thissect].nabort++;
				sects[thissect].actualtests++;
			}
			fabort = 0;
		}

		if (actualtests > expectedtests) {
			sprintf(tmpbuf, "ERROR: Test Case %s has %d Test Purposes, should have %d.\n", areaname, actualtests, expectedtests);
			dstore_line(tmpbuf);
		}

		/*section start message*/
		pline = strtok(NULL, " ");
		if (strcmp(pline, "SECTION") == 0) {
			fSectionNamePrinted = 0;
			pline = strtok(NULL, " ");
			thissect++;
			strncpy(sects[thissect].name, pline, 7);
			strcpy(sectionname, pline);
			pline = strtok(NULL, " ");
			sects[thissect].expectedareas = atoi(pline);
			pline = strtok(NULL, " ");
			sects[thissect].expectedtests = atoi(pline);
/*
			pline = strtok(NULL, " ");
			sects[thissect].expecteduntested = atoi(pline);
			pline = strtok(NULL, " ");
			sects[thissect].expectednotinuse = atoi(pline);
*/
			nsects++;
			sects[thissect].actualareas = 0;
			sects[thissect].actualtests = 0;
			sects[thissect].npass=0;
			sects[thissect].nfail=0;
			sects[thissect].nabort=0;
			sects[thissect].nunresolved=0;
			sects[thissect].nuninitiated=0;
			sects[thissect].nunsupported=0;
			sects[thissect].nuntested=0;
			sects[thissect].nnotinuse=0;
			sects[thissect].nnoresult=0;
			sects[thissect].nwarning=0;
			sects[thissect].nfip=0;
			actualtests=expectedtests=fabort=0;
			break;
		}

		/*area start message*/
		if (strcmp(pline, special1) == 0) {
			fAreaNamePrinted = fabort  = 0;
			pline = strtok(NULL, " ");
			strcpy(areaname, pline);
			pline = strtok(NULL, " ");
			expectedtests = atoi(pline);
			sects[thissect].actualareas++;
			if (thissect == 0)
				sects[thissect].expectedtests =+ expectedtests;
			actualtests = 0;
			if (freportcase == 1) {
				if (strcmp(areaname, reportcase) == 0) {
					freportthiscase = 1;
					ffoundcase = 1;
				}
				else
					freportthiscase = 0;
			}
			else
				freportthiscase = 1;
			break;
		}

		/*neither of the new message types*/
		fprintf(stderr, "Illegal special 70 record in IDLE state, line %d\n", lineno);
		exit(2);

	/*operator abort*/
	case 90:
		state=S_IDLE;
		print_header();
		printf("\nOperator abort\n");
		break;
	/*TCM message*/
	case 510:
		if (detail != 2) {
			print_header();
			printf("\nTCM Error\n");
			pline = strtok(NULL, "|");
			pline = strtok(NULL, "\n");
			printf("%s\n", pline);
		}
		ntcmerr++;
		break;
	/*TCC message*/
	case 50:
		if (detail != 2) {
			print_header();
			printf("\nTCC Error\n");
			printf("%s", &linebuf[4]);
		}
		ntccerr++;
		break;
	default:
		fprintf(stderr, "Illegal record (type = %d) in IDLE state, line %d\n", mtype, lineno);
		exit(2);
	}
}

/*parse messages in the build state*/
static void parseinbuild(void)
{
	int	buildret;

	switch (mtype) {
	/*captured*/
	case 100:
		pline = strtok(NULL, "|");
		check_activity(atoi(pline));
		pline = strtok(NULL, "\0");
		store_bline(pline);
		break;
	/*build end*/
	case 130:
		pline = strtok(NULL, " ");
		check_activity(atoi(pline));
		pline = strtok(NULL, " ");
		buildret = atoi(pline);
		if (buildret != 0) {
			nbuilderr++;
			if ((xopen_report != 2) && (detail < 2) && (scope < 3) && (freportthiscase == 1)) {
				print_header();
				printf("\nBuild tool error %d on build of file %s\n", buildret, currentfile);
				if (detail == 0)
					print_bstore(-1);
				if (detail == 1)
					print_bstore(10);
			}
			purge_bstore();
		}
		state=S_IDLE;
		break;
	/*operator abort*/
	case 90:
		if ((detail < 2) && (scope < 3) && (freportthiscase == 1)) {
			print_header();
			printf("\nOperator aborted build of file %s\n", currentfile);
		}
		purge_store();
		break;
	/*TCC message*/
	case 50:
		if ((detail < 2) && (scope < 3) && (freportthiscase == 1)) {
			print_header();
			printf("\nTCC Error during build of file %s\n", currentfile);
			printf("%s", &linebuf[4]);
		}
		purge_store();
		ntccerr++;
		break;
	/*TCM message*/
	case 510:
		if ((detail < 2) && (scope < 3) && (freportthiscase == 1)) {
			print_header();
			printf("\nTCM Error during build of file %s\n", currentfile);
			pline = strtok(NULL, "|");
			pline = strtok(NULL, "\n");
			printf("%s\n", pline);
		}
		purge_store();
		ntcmerr++;
		break;
	default:
		fprintf(stderr, "Illegal record (type = %d) in BUILD state, line %d\n", mtype, lineno);
		exit(2);
	}
}

/*parse messages in the clean state*/
static void parseinclean(void)
{
	switch (mtype) {
	/*captured*/
	case 100:
		pline = strtok(NULL, "|");
		check_activity(atoi(pline));
		break;
	/*clean end*/
	case 320:
		state=S_IDLE;
		break;
	/*operator abort*/
	case 90:
		if ((detail < 2) && (scope < 2) && (freportthiscase == 1)) {
			print_header();
			printf("\nOperator aborted clean of file %s\n", currentfile);
		}
		break;
	/*TCC message*/
	case 50:
		if ((detail < 2) && (scope < 2) && (freportthiscase == 1)) {
			print_header();
			printf("\nTCC Error during clean of file %s\n", currentfile);
			printf("%s", &linebuf[4]);
		}
		ntccerr++;
		break;
	/*TCM message*/
	case 510:
		if ((detail < 2) && (scope < 3) && (freportthiscase == 1)) {
			print_header();
			printf("\nTCM Error during clean of file %s\n", currentfile);
			pline = strtok(NULL, "|");
			pline = strtok(NULL, "\n");
			printf("%s\n", pline);
		}
		ntcmerr++;
		break;
	default:
		fprintf(stderr, "Illegal record (type = %d) in CLEAN state, line %d\n", mtype, lineno);
		exit(2);
	}
}

/*parse messages in the exec state*/
static void parseinexec(void)
{
	int	thisresult=0;
	int	thistest, thiscontext, i, finscope;

	switch (mtype) {
	/*TCM start*/
	case 15:
		pline = strtok(NULL, " ");
		check_activity(atoi(pline));
		fFirst520 = 1;
		break;
	/*TC end*/
	case 80:
		pline = strtok(NULL, " ");
		check_activity(atoi(pline));
		state=S_IDLE;
		break;
	/*IC start*/
	case 400:
		pline = strtok(NULL, " ");
		check_activity(atoi(pline));
		break;
	/*IC end*/
	case 410:
		pline = strtok(NULL, " ");
		check_activity(atoi(pline));
		break;
	/*TP start*/
	case 200:
		pline = strtok(NULL, " ");
		check_activity(atoi(pline));
		sects[thissect].actualtests++;
		actualtests++;
		fFirst520 = 1;
		break;
	/*TP result*/
	case 220:
		pline = strtok(NULL, " ");
		check_activity(atoi(pline));
		pline = strtok(NULL, "|");
		pline = strtok(NULL, "\n");
		if (strcmp(pline, "PASS") == 0) {
			if (bstorecnt == 0)  {
				thisresult = R_PASS;
				sects[thissect].npass++;
			}
			else {
				thisresult = R_FIP;
				sects[thissect].nfip++;
				strcpy(pline, "FIP");
			}
		} else
		if (strcmp(pline, "ABORT") == 0) {
			thisresult = R_ABORT;
			sects[thissect].nabort++;
			fabort = 1;
		} else
		if (strcmp(pline, "FAIL") == 0) {
			thisresult = R_FAIL;
			sects[thissect].nfail++;
		} else
		if (strcmp(pline, "UNRESOLVED") == 0) {
			thisresult = R_UNRESOLVED;
			sects[thissect].nunresolved++;
		} else
		if (strcmp(pline, "UNINITIATED") == 0) {
			thisresult = R_UNINITIATED;
			sects[thissect].nuninitiated++;
		} else
		if (strcmp(pline, "UNSUPPORTED") == 0) {
			thisresult = R_UNSUPPORTED;
			sects[thissect].nunsupported++;
		} else
		if (strcmp(pline, "UNTESTED") == 0) {
			thisresult = R_UNTESTED;
			sects[thissect].nuntested++;
		} else
		if (strcmp(pline, "NOTINUSE") == 0) {
			thisresult = R_NOTINUSE;
			sects[thissect].nnotinuse++;
		} else
		if (strcmp(pline, "NORESULT") == 0) {
			thisresult = R_NORESULT;
			sects[thissect].nnoresult++;
			nnoresult++;
		} else
		if (strcmp(pline, "WARNING") == 0) {
			thisresult = R_WARNING;
			sects[thissect].nwarning++;
		} else
		if (strcmp(pline, "FIP") == 0) {
			thisresult = R_FIP;
			sects[thissect].nfip++;
		}

		finscope = 0;
		if (freportthiscase != 0) {
		switch (scope) {

		/*scope: all results*/
		case 0:
			finscope = 1;
			break;

		/*scope: errors, WARNINGs and FIPs*/
		case 1:
			if ((thisresult == R_FAIL) || (thisresult == R_ABORT) || (thisresult == R_UNRESOLVED) || (thisresult == R_UNINITIATED) || (thisresult == R_NORESULT)  || (thisresult == R_WARNING) || (thisresult == R_FIP))
				finscope = 1;
			break;

		/*scope: UNINITIATED*/
		case 2:
			if (thisresult == R_UNINITIATED)
				finscope = 1;
			break;


		/*scope: UNSUPPORTED*/
		case 3:
			if (thisresult == R_UNSUPPORTED)
				finscope = 1;
			break;

		/*scope: WARNING and FIP*/
		case 4:
			if ((thisresult == R_WARNING) ||  (thisresult == R_FIP))
				finscope = 1;
			break;


		/*scope: NOTINUSE*/
		case 5:
			if ((thisresult == R_NOTINUSE))
				finscope = 1;
			break;

		/*scope: UNTESTED*/
		case 6:
			if ((thisresult == R_UNTESTED))
				finscope = 1;
			break;

		/*scope: NORESULT*/
		case 7:
			if ((thisresult == R_NORESULT))
				finscope = 1;
			break;
		}


		if (finscope) {

			switch (detail) {

			case 0:
				/*detail: everything*/
				if (xopen_report == 2) {
					if (thisresult == R_FIP) {
						print_header();
						printf("\nTEST PURPOSE #%d\n", actualtests);
						print_store();
						if (bstorecnt != 0) {
							printf("FIP: Compiler messages were produced\n");
							printf("     Manual analysis is required\n");
							print_bstore(-1);
						}
						printf("%d %s\n", actualtests, pline);
						printf("\n%s", "Test Centre sign-off _____________________________\n");
					}
					break;
				}
				print_header();
				printf("\nTEST PURPOSE #%d\n", actualtests);
				print_store();
				if ((thisresult == R_FIP) && (bstorecnt != 0)) {
					printf("FIP: The following compiler messages were produced\n");
					printf("     Manual analysis is required\n");
					print_bstore(-1);
				}
				printf("%d %s\n", actualtests, pline);
				break;
			case 1:
				/*detail: everything but compiler detail*/
				if (xopen_report == 2) {
					if (thisresult == R_FIP) {
						print_header();
						printf("\nTEST PURPOSE #%d\n", actualtests);
						print_store();
						if (bstorecnt != 0) {
							printf("FIP: Compiler messages were produced\n");
							printf("     Manual analysis is required\n");
							print_bstore(10);
						}
						printf("%d %s\n", actualtests, pline);
						printf("\n%s", "Test Centre sign-off _____________________________\n");
					}
					break;
				}
				print_header();
				printf("\nTEST PURPOSE #%d\n", actualtests);
				print_store();
				if ((thisresult == R_FIP) && (bstorecnt != 0)) {
					printf("FIP: Compiler messages were produced\n");
					printf("     Manual analysis is required\n");
					print_bstore(10);
				}
				printf("%d %s\n", actualtests, pline);
				break;

			case 3:
				/*detail: results*/
				print_header();
				printf("%d %s\n", actualtests, pline);
				break;

			case 4:
				/*detail: results and assertions*/
				print_header();
				printf("\nTEST PURPOSE #%d\n", actualtests);
				print_assert();
				printf("%d %s\n", actualtests, pline);
				break;
			}
		}
		}
		purge_store();
		break;
	/*TC info*/
	case 520:
		pline = strtok(NULL, " ");
		check_activity(atoi(pline));
		if (fFirst520 == 1) {
			pline = strtok(NULL, " ");
			pline = strtok(NULL, " ");
			contexts[0] = atoi(pline);
			ncontexts = 1;
			pline = strtok(NULL, "|");
			pline = strtok(NULL, " ");
			if (strcmp(pline, test_flag) != 0) {
				/* fprintf(stderr, "Output before test for %s ~Purpose %d, journal line %d\n", areaname, actualtests, lineno); */
				return;
			}
			pline = strtok(NULL, " ");
			if (strcmp(pline, special2) != 0) {
				fprintf(stderr, "Special 520 record but not PURPOSE in EXEC state, line %d\n", lineno);
				exit(2);
			}
			pline = strtok(NULL, "\n");
			thistest = atoi(pline);
			if ((thistest != actualtests) && (expectedtests != 0)) {
				if ((xopen_report != 2) && (detail != 2) && (scope < 3) && (freportthiscase == 1))
					print_header();
				if ((xopen_report != 2) && (detail != 3) && (detail != 2) && (scope < 3) && (freportthiscase == 1)) {
					if (thistest-actualtests == 1) {
						printf("\nTEST PURPOSE #%d\n", actualtests);
						if (fabort == 0)
							printf("%d UNINITIATED\n", actualtests);
						else
							printf("%d ABORT\n", actualtests);
					}
					else {
						if (fabort == 0)
							printf("\nTEST PURPOSES #%d to #%d UNINITIATED\n", actualtests, thistest-1);	
						else
							printf("\nTEST PURPOSES #%d to #%d ABORT\n", actualtests, thistest-1);	
					}
				}
	
				if ((xopen_report != 2) && (detail == 3) && (scope < 3) && (freportthiscase == 1)) {
					for (i = actualtests; i< thistest; i++) {
						if (fabort == 0)
							printf("%d UNINITIATED\n", i);
						else
							printf("%d ABORT\n", i);
					}
				}
				for (i = actualtests; i< thistest; i++) {
					if (fabort == 0)
						sects[thissect].nuninitiated++;
					else
						sects[thissect].nabort++;
					sects[thissect].actualtests++;
				}
			}
			actualtests = thistest;
			fFirst520 = 0;
			fabort = 0;
			break;
		}
		pline = strtok(NULL, " ");
		pline = strtok(NULL, " ");
		thiscontext = atoi(pline);
		if (thiscontext != contexts[ncontexts-1]) {
			contexts[ncontexts++] = thiscontext;
			for (i = 0; i < ncontexts; i++) 
				if (thiscontext == contexts[i])
					ncontexts = i+1;
			if (ncontexts > NUM_CONTEXTS) {
				fprintf(stderr, "FATAL ERROR: Too many contexts, line: %d\n", lineno);
				exit(1);
			}
		}
		pline = strtok(NULL, "|");
		pline = strtok(NULL, "\0");
		if (ncontexts > 2)
			store_line(pline, (ncontexts-2)*2);
		else
			store_line(pline, 0);
		break;
	/*operator abort*/
	case 90:
		if ((detail != 2) && (scope < 2) && (freportthiscase == 1)) {
			print_header();
			print_assert();
			printf("\nOperator aborted exec of file %s\n", currentfile);
		}
		purge_store();
		break;
	/*captured*/
	case 100:
		pline = strtok(NULL, "|");
		check_activity(atoi(pline));
		break;
	/*TCM message*/
	case 510:
		if ((detail < 2) && (freportthiscase == 1)) {
			print_header();
			print_store();
			printf("\nTCM Error during exec of file %s\n", currentfile);
			pline = strtok(NULL, "|");
			pline = strtok(NULL, "\n");
			printf("%s\n", pline);
		}
		purge_store();
		ntcmerr++;
		break;
	/*TCC message*/
	case 50:
		if ((detail != 2) && (scope < 2) && (freportthiscase == 1)) {
			print_header();
			printf("\nTCC Error during exec of file %s\n", currentfile);
			printf("%s", &linebuf[4]);
		}
		ntccerr++;
		purge_store();
		break;
	default:
		fprintf(stderr, "Illegal record (type = %d) in EXEC state, line %d\n", mtype, lineno);
		exit(2);
	}
}

/*read and parse a journal file*/
static void parse_file(void)
{
	/*open the journal file for read*/
	jfile = fopen(infile, "r");
	if (jfile == NULL) {
		perror("Cannot open journal file");
		exit(2);
	}

	state = S_START;

	/*parse lines one by one*/
	while (fgets(linebuf, sizeof(linebuf), jfile) != NULL) {
		lineno++;
		if (strlen(linebuf) < 2)
			continue;
#ifdef CDEBUG
fprintf(stderr, "%s", linebuf);
fflush(stderr);
#endif
		/*get the message type number*/
		pline = strtok(&linebuf[0], "|");
		mtype = atoi(linebuf);
#ifdef CDEBUG
fprintf(stderr, "State = %d, type = %d\n", state, mtype);
#endif
		switch (state) {
		case S_START:
			parseinstart();
			break;
		case S_CONFIG:
			parseinconfig();
			break;
		case S_IDLE:
			parseinidle();
			break;
		case S_BUILD:
			parseinbuild();
			break;
		case S_CLEAN:
			parseinclean();
			break;
		case S_EXEC:
			parseinexec();
			break;
		default:
			fprintf(stderr, "Illegal state: %d, line %d\n", state, lineno);
			exit(2);
		}
	}
}

static void print_ecount(int errcnt, char *errstring) 
{
	if (errcnt == 0) ;
	else
		if (errcnt == 1)
			printf("1 %s error occurred\n", errstring);
		else
			printf("%d %s errors occurred\n", errcnt, errstring);
}

/*print the summary report*/
static void print_summary(void)
{

	int	i;
	char	ttmp[5];
	struct tm mytm;
	time_t	mytime;
	char	strbuf[64];

	if (xopen_report == 0) {
	/* printf("\f"); */
/*
	printf("                          %s\n", vendor_name);
*/
	printf("                           %s SUMMARY RESULTS REPORT\n\n", test_name);
	printf("Test suite version: %s", verbuf);
	printf("Specification version: %s", specverbuf);
	printf("Test run by: %s\n", username);

	if (uname(&ouruname) != -1) {
		printf("System: %s %s %s %s %s\n", ouruname.sysname, ouruname.nodename, ouruname.release, ouruname.version, ouruname.machine);
	}
	}
	pline = strtok(&starttime[0], ":");
		if (pline == NULL) {
			fprintf(stderr, "Null pline in %s\n", linebuf);
			exit(2);
		}
	mytm.tm_hour=atoi(pline);
	pline = strtok(NULL, ":");
		if (pline == NULL) {
			fprintf(stderr, "Null pline in %s\n", linebuf);
			exit(2);
		}
	mytm.tm_min=atoi(pline);
	pline = strtok(NULL, " ");
		if (pline == NULL) {
			fprintf(stderr, "Null pline in %s\n", linebuf);
			exit(2);
		}
	mytm.tm_sec=atoi(pline);
	pline = strtok(NULL, "\0");
		if (pline == NULL) {
			fprintf(stderr, "Null pline in %s\n", linebuf);
			exit(2);
		}
	strncpy(ttmp, pline, 4);	
	ttmp[4]= 0;
	mytm.tm_year=atoi(ttmp)-1900;
	strncpy(ttmp, pline+4, 2);	
	ttmp[2]= 0;
	mytm.tm_mon=atoi(ttmp)-1;
	strncpy(ttmp, pline+6, 2);	
	mytm.tm_mday=atoi(ttmp);
	mytm.tm_isdst=-1;
	mytime = mktime(&mytm);
	
	strftime(strbuf, sizeof(strbuf), "%A %B %d, %Y %r", &mytm);
	printf("Test run started: %s\n", strbuf);
	if (strlen(endtime) != 0) {
		pline = strtok(&endtime[0], ":");
		if (pline == NULL) {
			fprintf(stderr, "Null pline in %s\n", linebuf);
			exit(2);
		}
		mytm.tm_hour=atoi(pline);
		pline = strtok(NULL, ":");
		if (pline == NULL) {
			fprintf(stderr, "Null pline in %s\n", linebuf);
			exit(2);
		}
		mytm.tm_min=atoi(pline);
		pline = strtok(NULL, "\0");
		if (pline == NULL) {
			fprintf(stderr, "Null pline in %s\n", linebuf);
			exit(2);
		}
		mytm.tm_sec=atoi(pline);
		mytime = mktime(&mytm);
	
		strftime(strbuf, sizeof(strbuf), "%A %B %d, %Y %r", &mytm);
		printf("Test run ended:   %s\n", strbuf);
	}
	else
		printf("Test run not completed\n");


	printf("Journal file: %s\n", infile);
	printf("TCC command line:%s\n", commandline);
	if (xopen_report == 0) {
	if (freportcase == 1)
		printf("Report type: -d %d -s %d -t %s\n", detail, scope, reportcase);
	else
		printf("Report type: -d %d -s %d \n", detail, scope);
	}
	printf("\n");

	print_ecount(nbuilderr, "build");
	print_ecount(ntccerr, "TCC");
	print_ecount(ntcmerr, "TCM");
	print_ecount(nnoresult, "NORESULT");
	printf("\n");


	if ((freportcase == 1) && (ffoundcase == 0)) {
		printf("Test Case %s not found in %s\n", reportcase, infile);
		exit(0);
	}
	if (nsects == 0) {
		printf("TEST CASES      %4d\n", sects[0].actualareas);
		printf("TEST PURPOSES   %4d\n", sects[0].actualtests);
		printf("GOOD RESULTS\n");
		printf(" PASS           %4d\n", sects[0].npass);
		printf(" UNSUPPORTED    %4d\n", sects[0].nunsupported);
		printf(" UNTESTED       %4d\n", sects[0].nuntested);
		printf(" NOTINUSE       %4d\n", sects[0].nnotinuse);
		printf("ANALYSIS NEEDED\n");
		printf(" WARNING        %4d\n", sects[0].nwarning);
		printf(" FIP            %4d\n", sects[0].nfip);
		printf("ERROR RESULTS\n");
		printf(" FAIL           %4d\n", sects[0].nfail);
		printf(" UNRESOLVED     %4d\n", sects[0].nunresolved);
		printf(" UNINITIATED    %4d\n", sects[0].nuninitiated);
		printf(" ABORT          %4d\n", sects[0].nabort);
	}

	else {
		 printf("        CASES TESTS  PASS UNSUP UNTST NOTIU  WARN   FIP  FAIL UNRES  UNIN ABORT\n\n");

		sects[0].actualareas = 0;
		sects[0].actualtests = 0;
		sects[0].npass = 0;
		sects[0].nunsupported = 0;
		sects[0].nuntested = 0;
		sects[0].nnotinuse = 0;
		sects[0].nfip = 0;
		sects[0].nwarning = 0;
		sects[0].nfail = 0;
		sects[0].nunresolved = 0;
		sects[0].nuninitiated = 0;
		sects[0].nnoresult = 0;

		for (i = 1; i<= thissect; i++) {
			printf("%-7s", sects[i].name);

			printf(" %5d",  sects[i].actualareas);
			sects[0].actualareas += sects[i].actualareas;
			if (sects[i].actualareas != sects[i].expectedareas) {
				sprintf(tmpbuf, "ERROR: %s section has %d Test Cases, should have %d.\n", sects[i].name, sects[i].actualareas, sects[i].expectedareas);
				store_line(tmpbuf, 0);
			}

			printf(" %5d",  sects[i].actualtests);
			sects[0].actualtests += sects[i].actualtests;
			if (sects[i].actualtests != sects[i].expectedtests) {
				sprintf(tmpbuf, "ERROR: %s section has %d Test Purposes, should have %d.\n", sects[i].name, sects[i].actualtests, sects[i].expectedtests);
				store_line(tmpbuf, 0);
			}

			printf(" %5d",  sects[i].npass);
			sects[0].npass += sects[i].npass;
			printf(" %5d",  sects[i].nunsupported);
			sects[0].nunsupported += sects[i].nunsupported;
			printf(" %5d",  sects[i].nuntested);
			sects[0].nuntested += sects[i].nuntested;
			printf(" %5d",  sects[i].nnotinuse);
			sects[0].nnotinuse += sects[i].nnotinuse;
			printf(" %5d",  sects[i].nwarning);
			sects[0].nwarning += sects[i].nwarning;
			printf(" %5d",  sects[i].nfip);
			sects[0].nfip += sects[i].nfip;
			printf(" %5d",  sects[i].nfail);
			sects[0].nfail += sects[i].nfail;
			printf(" %5d",  sects[i].nunresolved);
			sects[0].nunresolved += sects[i].nunresolved;
			printf(" %5d",  sects[i].nuninitiated);
			sects[0].nuninitiated += sects[i].nuninitiated;
			printf(" %5d",  sects[i].nabort);
			sects[0].nabort += sects[i].nabort;
			printf("\n");
		}

		printf("\n");
		printf("%-7s", "TOTAL");
		printf(" %5d",  sects[0].actualareas);
		printf(" %5d",  sects[0].actualtests);
		printf(" %5d",  sects[0].npass);
		printf(" %5d",  sects[0].nunsupported);
		printf(" %5d",  sects[0].nuntested);
		printf(" %5d",  sects[0].nnotinuse);
		printf(" %5d",  sects[0].nwarning);
		printf(" %5d",  sects[0].nfip);
		printf(" %5d",  sects[0].nfail);
		printf(" %5d",  sects[0].nunresolved);
		printf(" %5d",  sects[0].nuninitiated);
		printf(" %5d",  sects[0].nnoresult);
		printf("\n");

	}

	if (strlen(endtime) != 0) {
		print_dstore();
		if (storecnt != 0) 
			printf("\n");
		print_store();
	}
}

extern int optind, opterr, optopt;
extern char *optarg;

/*
 * This is a common report generator use in VSU, VSW, and VSM. It can be
 * invoked as vsurpt (or creport), vswrpt (or xts-report), or vsmrpt, and
 * customizes itself to find the results for the appropriate test suite.
 */
int main(int argc, char * const argv[])
{
	int	optlet;
 	int	errflag = 0;
 	int	fcount = 0;
 	int	fuser = 0;
	int	jfileno = 0;
	DIR	*dirp;
	struct	 dirent	*dp;
	struct	 stat	sbuf;
	time_t	best_time=0;
	uid_t	ouruid=0;
	char	jbuf[5];
	FILE *verfile;
	char *vernum;

	tet_root = getenv("TET_ROOT");
	if (!tet_root)
		tet_root = strdup(DEFAULT_TET_ROOT);

	strcpy(tmpbuf, argv[0]);
	if (strstr(tmpbuf, "/") != NULL)
		bname = basename(tmpbuf);
	else
		bname = tmpbuf;
/*
	printf("%s %d %s %d\n", argv[0], strlen(argv[0]), bname, strlen(bname));
*/
	strcpy(doc_dir, "doc");
	strcpy(special1, "CASE");
	strcpy(special2, "PURPOSE");

	if ((strcmp(bname, "creport") == 0) || (strcmp(bname, "vsurpt") == 0)) {
		strcpy(test_dir, "CAPI");
		strcpy(test_flag, "SPEC1170TESTSUITE");
		strcpy(test_name, "VSU4");
		strcpy(test_prefix, "VSU4");
		strcpy(vendor_name, "THE OPEN GROUP");
		strcpy(special1, "AREA");
		strcpy(special2, "CASE");
		strcpy(doc_dir, "DOC");
	} else {
		if ((strcmp(bname, "vswrpt") == 0) ||
		    (strcmp(bname, "xts-report") == 0)) {
			strcpy(test_dir, "xts5");
			strcpy(test_flag, "VSW5TESTSUITE");
			strcpy(test_name, "VSW5");
			strcpy(vendor_name, "THE OPEN GROUP");
			strcpy(test_prefix, "VSW");
		} else {
			if (strcmp(bname, "vsmrpt")  == 0) {
				strcpy(test_dir, "vsm4");
				strcpy(test_flag, "VSM4TESTSUITE");
				strcpy(test_name, "VSM4");
				strcpy(vendor_name, "THE OPEN GROUP");
				strcpy(test_prefix, "VSM");
			} else {
				fprintf(stderr, "Unknown argv[0] value = %s\n", bname);
				exit(2);
			}
		}
	}
	
	opterr = 1;

	detail = 1;
	scope = 1;

	while ((optlet = getopt(argc, argv, OPTIONS))!= -1) {
		switch (optlet) {
		case 'w':
			whatj();
			exit(0);
		case 'f':
			infile = optarg;
			break;
		case 'd':
			detail = atoi(optarg);
			if ((detail > 4) || (detail < 0)) {
				fprintf(stderr, "Detail value illegal\n");
				errflag++;
			}
			break;
		case 'h':
			errflag++;
			break;
		case 'x':
			xopen_report = atoi(optarg);
			break;
		case 'c':
			print_config_vars = 1;
			break;
		case 'j':
			jfileno = atoi(optarg);
			break;
		case 's':
			scope = atoi(optarg);
			if ((scope > 7) || (scope < 0)) {
				fprintf(stderr, "Scope value illegal\n");
				errflag++;
			}
			break;
		case 't':
			reportcase = optarg;
			freportcase = 1;
			ffoundcase = 0;
			break;
		case 'u':
			fuser++;
			break;
		case 'v':
			fprintf(stderr, "%s Report Generator %s\n",
				test_name, PACKAGE_VERSION);
			exit(0);
		case ':':
			fprintf(stderr, "Option -%c requires an operand\n", optopt);
			errflag++;
			break;
		case '?':
			errflag++;
			break;
		}
	}

	if (errflag) {
		fprintf(stderr, "usage: %s [-f filename] [-j journal] [-d detail] [-s scope] [-t test] [-u] [ -h ] [-v] [-w]\n", bname);
		fprintf(stderr, "      -f journal file name\n");
		fprintf(stderr, "      -j journal file # (default is latest)\n");
		fprintf(stderr, "      -d detail\n");
		fprintf(stderr, "         0 - everything\n");
		fprintf(stderr, "         1 - reasonable detail (default)\n");
		fprintf(stderr, "         2 - nothing\n");
		fprintf(stderr, "         3 - results only\n");
		fprintf(stderr, "         4 - assertions and results only\n");
		fprintf(stderr, "      -s scope of detail\n");
		fprintf(stderr, "         0 - all result codes\n");
		fprintf(stderr, "         1 - errors, WARNING and FIP (default)\n");
		fprintf(stderr, "         2 - UNINITIATED\n");
		fprintf(stderr, "         3 - UNSUPPORTED\n");
		fprintf(stderr, "         4 - WARNING and FIP\n");
		fprintf(stderr, "         5 - NOTINUSE\n");
		fprintf(stderr, "         6 - UNTESTED\n");
		fprintf(stderr, "         7 - NORESULT\n");
		fprintf(stderr, "      -t detail only on specified Test Case\n");
		fprintf(stderr, "      -u use latest journal file for current user\n");
		fprintf(stderr, "      -h display this usage message\n");
		fprintf(stderr, "      -v display program version\n");
		fprintf(stderr, "      -w summarize journals\n");
		exit(2);
	}

	/* -j*/
	if (jfileno != 0) {
		/*make the full number*/
		sprintf(jbuf, "%04d", jfileno);
		jbuf[4] = 0;
		/*find the results directory*/
		sprintf(inbuf, "%s/%s/results", tet_root, test_dir);
		if ((dirp = opendir(inbuf)) == NULL) {
			perror("cannot open results directory");
			exit(2);
		}

		/*skip . and ..*/
		dp = readdir(dirp);
		dp = readdir(dirp);

		/*find a matching results sub-directory, ignoring tcc mode*/
		while ((dp = readdir(dirp)) != NULL) {
			if (strstr(dp->d_name, jbuf) != 0) {
				sprintf(inbuf, "%s/%s/results/%s/journal",
					tet_root, test_dir, dp->d_name);
				infile = inbuf;
				if (access(infile, R_OK) != 0) {
					perror("Cannot access journal file");
					exit(2);
				}
				break;
			}
		}

		if (infile == 0) {
			fprintf(stderr, "Cannot find journal numbered %d\n", jfileno);
			exit(2);
		}
	}


	if (fuser)
		ouruid = getuid();

	/* -u option or no -f or -j*/
	if ((infile == 0) || (fuser)) {
		/*find the results directory*/
		sprintf(tmpbuf, "%s/%s/results", tet_root, test_dir);
		if ((dirp = opendir(tmpbuf)) == NULL) {
			perror("cannot open results directory");
			exit(2);
		}

		/*skip . and ..*/
		dp = readdir(dirp);
		dp = readdir(dirp);

		/*find the most recently modified results sub-directory*/
		while ((dp = readdir(dirp)) != NULL) {
			sprintf(tmpbuf, "%s/%s/results/%s", tet_root,
				test_dir, dp->d_name);
#ifdef CDEBUG
fprintf(stderr, "dir: %s\n", tmpbuf);
#endif
			if (stat(tmpbuf, &sbuf) != 0) {
				if (fcount == 0)
					perror("no results sub-directories");
				else
					perror("cannot stat a results sub-directory");
				exit(2);
			}

			/*ignore regular files that might sneak in*/
			if (S_ISDIR(sbuf.st_mode) == 0)
				continue;

			/*only look at ones we own if -u specified*/
			if (fuser) 
				if (ouruid != sbuf.st_uid)
					continue;

			/*compare times*/
			if (fcount == 0) {
				sprintf(inbuf, "%s", tmpbuf);
				best_time = sbuf.st_mtime;
			}
			else {
				if (difftime(sbuf.st_mtime, best_time) >= 0) {
					sprintf(inbuf, "%s", tmpbuf);
					best_time = sbuf.st_mtime;
				}
			}
			fcount++;
		}

		if (fcount == 0)  {
			if (fuser) {
				fprintf(stderr, "No journal files found for this user.\n");
				exit(2);
			}
			else {
				fprintf(stderr, "No journal files found.\n");
				exit(2);
			}
		}

		/*we'll use that journal file*/
		strcat(inbuf, "/journal");
		infile = inbuf;
		if (access(infile, R_OK) != 0) {
			perror("Cannot access latest journal");
			exit(2);
		}
	}
	/*user defined file*/
	else {
		if (access(infile, R_OK) != 0) {
			perror("Cannot access specified journal file");
			exit(2);
		}
	}

	sprintf(tmpbuf, "%s/%s/%s/%s_RELEASE", tet_root, test_dir, doc_dir,
		test_prefix);

	verfile = fopen(tmpbuf, "r");
	if (verfile == 0) {
		fprintf(stderr, "WARNING: Cannot open file: %s\n", tmpbuf);
		strcpy(verbuf, "Release file not found\n");
	}
	else {
		vernum = fgets(verbuf, sizeof(verbuf), verfile);
		if (vernum == 0)
			fprintf(stderr, "WARNING: Cannot read version\n");
	}
	sprintf(tmpbuf, "%s/%s/%s/%s_SPEC", tet_root, test_dir, doc_dir,
		test_prefix);
	verfile = fopen(tmpbuf, "r");
	if (verfile == 0) {
		fprintf(stderr, "WARNING: Cannot open file: %s\n", tmpbuf);
		strcpy(specverbuf, "Version file not found\n");
	}
	else {
		vernum = fgets(specverbuf, sizeof(specverbuf), verfile);
		if (vernum == 0)
			fprintf(stderr, "WARNING: Cannot read spec version\n");
	}

	parse_file();
	
	if (xopen_report != 2)
		print_summary();

	exit(0);

	return 0;
}
