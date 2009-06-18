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
$Header: /cvs/xtest/xtest/xts5/src/bin/reports/vswrptm.c,v 1.3 2005-11-03 08:42:01 jmichael Exp $
*
* Copyright Applied Testing and Technology Inc. 1994, 1995
* All rights reserved
*
* Project: Common X/Open multi-journal report generator for VSU, VSM, VSW
*
* File: vsurptm.c, vsmrptm.c vswrptm.c
*
* Description:
*	Journal file comparer
*
* Modifications:
*  $Log: vswrptm.c,v $
*  Revision 1.3  2005-11-03 08:42:01  jmichael
*  clean up all vsw5 paths to use xts5 instead.
*
*  Revision 1.2  2005/04/21 09:40:42  ajosey
*  resync to VSW5.1.5
*
*  Revision 8.1  1999/11/09 17:06:26  vsx
*  Release 5.1.1beta
*
*  Revision 8.0  1998/12/23 23:24:20  mar
*  Branch point for Release 5.0.2
*
*  Revision 7.0  1998/10/30 22:42:30  mar
*  Branch point for Release 5.0.2b1
*
*  Revision 6.0  1998/03/02 05:16:46  tbr
*  Branch point for Release 5.0.1
*
*  Revision 5.1  1998/02/05 06:40:42  andy
*  Accomodate record type 5 as produced by TETware.
*
*  Revision 5.0  1998/01/26 03:13:18  tbr
*  Branch point for Release 5.0.1b1
*
*  Revision 1.2  1998/01/12 22:13:48  andy
*  Added casts for return of basename when passed to strcmp
*
*  Revision 1.1  1996/07/10 01:05:49  andy
*  Initial revision
*
* Revision 1.1  1996/07/10  01:04:52  andy
* Initial revision
*
*/

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <unistd.h>
#include <stdio.h>
#include <dirent.h>
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/utsname.h>
#include <pwd.h>
#include <time.h>

static void parseinidle(void);

char	test_dir[16];
char	test_flag[32];
char	vendor_name[64];
char	test_name[16];
char	test_prefix[16];
char	doc_dir[16];
char	special1[16];
char	special2[16];

int lineno = 0;
#define OPTIONS	":t:s:ufah"
char * reportcase;
char * reportsection;
int freportcase = 0;
int freportsection = 0;
int freportunin = 0;
int freportall = 0;
int freportfail = 0;
int finscope;

/*abort missing tests rather than uninitiated since got a real abort
which will zap rest of test case*/
int	fabort = 0;

/* program version*/
char	verbuf[512];

/*number of files*/
int	nfiles;
int	curfile;
char 	*curfilename;

#define NSYS	32
char *fnames[NSYS];

/*file descriptors for files to compare*/
FILE	*files[NSYS];

/*name of the current area*/
char areaname[128];
char sectname[128];

int	nareas;

int hits = 0;

struct	area {
	char	name[64];
	int	firstresult;
	int	nresults;
} areas[1000];

int	results[NSYS][12000];

/*count of messages during build*/
int bstore = 0;

/*info about errors in files*/
struct file_err {
	int	actualareas;
	int	actualtests;
	int	npass;
	int	nfail;
	int	nunresolved;
	int	nuninitiated;
	int	nunsupported;
	int	nuntested;
	int	nnotinuse;
	int	nnoresult;
	int	nwarning;
	int	nfip;
	int	nabort;
} file_errs[NSYS];

int	nextresult = 0;
int	nextfreeresult = 0;
	
/*number of tests in the current area*/
int	expectedtests;
int	actualtests;

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

/*test return values*/
#define R_PASS		0+1
#define R_FAIL		1+1
#define R_UNSUPPORTED	2+1
#define R_UNINITIATED	3+1
#define R_UNRESOLVED	4+1
#define R_UNTESTED	5+1
#define R_NORESULT	6+1
#define R_NOTINUSE	7+1
#define R_WARNING	101+1
#define R_FIP		102+1
#define R_ABORT		103+1

int	fFirst520;

/*parse messages in the start state*/
/*handles message TCC Start (type 0)*/
static void parseinstart(void)
{
	switch (mtype) {
	/*TCC Start*/
	case 0:
		state = S_CONFIG;
		break;
	/*TCM message*/
	case 510:
		break;
	/*operator abort*/
	case 90:
		break;
	/*TCC message*/
	case 50:
		break;
	default:
		fprintf(stderr, "Illegal record (type = %d) in START state in file %s: line %d\n", mtype, fnames[curfile], lineno);
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
		state=S_IDLE;
		return;
	}

	/*TCC message*/
	if (mtype == 50) {
		return;
	}

	/*TETware system info*/
	if (mtype == 5) {
		return;
	}

	if ((mtype != 20) && (mtype != 30) && (mtype != 40)) {
		fprintf(stderr, "Illegal record (type = %d) in CONFIG state in file %s line %d\n", mtype, fnames[curfile], lineno);
		exit(2);
	}
}

/*parse messages in the idle state between tests*/
/*handles message types 70, 10, 110, 300, 900)*/
static void parseinidle(void)
{
	int	i, j, k, fmatch;

	switch (mtype) {
	/*TC Start*/
	case 10:
		state=S_EXEC;
		break;
	/*Build start*/
	case 110:
		state=S_BUILD;
		bstore=0;
		break;
	/*Clean start*/
	case 300:
		state=S_CLEAN;
		break;
	/*TCC End*/
	case 900:
		if (finscope != 0) {
			if (actualtests < expectedtests) {
				for (i = actualtests+1; i<= expectedtests; i++)  {
					if (fabort) {
					results[curfile][nextresult++] = R_ABORT;
					file_errs[curfile].nabort++;
					}
					else {
					results[curfile][nextresult++] = R_UNINITIATED;
					file_errs[curfile].nuninitiated++;
					}
					file_errs[curfile].actualtests++;
				}
			}
		}
		state=S_START;
		break;
	/*Scenario message*/
	case 70:
		/*message from scenario file should be one of ours*/
		pline = strtok(NULL, "|");
		if (*pline == '\"')
			pline++;
		pline = strtok(pline, " ");
		if (strcmp(pline, test_flag) != 0) {
			fprintf(stderr, "Illegal record (type = %d) in IDLE state in file %s line %d\n", mtype, fnames[curfile], lineno);
			exit(2);
		}

		if (finscope != 0) {
			if (actualtests < expectedtests) {
				for (i = actualtests; i< expectedtests; i++) {
					if (fabort) {
					results[curfile][nextresult++] = R_ABORT;
					file_errs[curfile].nabort++;
					}
					else {
					results[curfile][nextresult++] = R_UNINITIATED;
					file_errs[curfile].nuninitiated++;
					}
					file_errs[curfile].actualtests++;
				}
			}
		}

		/*section start message*/
		pline = strtok(NULL, " ");
		if (strcmp(pline, "SECTION") == 0) {
			pline = strtok(NULL, " ");
			actualtests=expectedtests=0;
			strcpy(sectname, pline);
			if (freportsection == 1) {
				if (strcmp(reportsection, pline) == 0) 
					finscope = 1;
				else
					finscope = 0;
			}
			break;
		}

		/*area start message*/
		if (strcmp(pline, special1) == 0) {
			pline = strtok(NULL, " ");
			strcpy(areaname, sectname);
			strcat(areaname, "/");
			strcat(areaname, pline);
			fabort = 0;
			if (freportcase == 1)  {
				if (strcmp(reportcase, pline) == 0)  
					finscope = 1;
				else {
					finscope = 0;
					break;
				}
			}
			if (finscope == 0)
				break;
			file_errs[curfile].actualareas++;
			fmatch = 0;
#ifdef CDEBUG
printf("CASE %s in file %s\n", pline, fnames[curfile]);
#endif
			for(i = 0; i < nareas; i++)  {
				if (strcmp(areaname, areas[i].name) == 0) {
#ifdef CDEBUG
printf("	MATCH\n");
#endif
					fmatch = 1;
					pline = strtok(NULL, " ");
					expectedtests = atoi(pline);
					/*case where number of tests in an*/
					/*area increases in a later file*/
					if (areas[i].nresults < expectedtests) {
						/*make room, make room*/
						for (j = 0; j < areas[i].nresults; j++)
							for (k = 0; k < NSYS; k++)
								results[k][nextfreeresult+j]=results[k][areas[i].firstresult+j];
						areas[i].firstresult=nextfreeresult;
						areas[i].nresults=expectedtests;
						nextfreeresult = nextfreeresult+expectedtests;
						nextresult = areas[i].firstresult;
					}
					else {
						nextresult = areas[i].firstresult;
					}
					break;
				}
			}
			if (fmatch == 0) {
				strcpy(areas[nareas].name, areaname);
				areas[nareas].firstresult=nextfreeresult;
				pline = strtok(NULL, " ");
				expectedtests = atoi(pline);
				areas[nareas].nresults=expectedtests;
				nextfreeresult = nextfreeresult+expectedtests;
				nextresult = areas[nareas].firstresult;
				nareas++;
#ifdef CDEBUG
printf("	NO MATCH, areas = %d\n", nareas);
#endif
			}
			actualtests = 0;
			break;
		}

		/*neither of the new message types*/
		fprintf(stderr, "Illegal special 70 record in IDLE state in file %s line %d\n", fnames[curfile], lineno);
		exit(2);

	/*operator abort*/
	case 90:
		state=S_IDLE;
		break;
	/*TCM message*/
	case 510:
		break;
	/*TCC message*/
	case 50:
		break;
	default:
		fprintf(stderr, "Illegal record (type = %d) in IDLE state in file %s line %d\n", mtype, fnames[curfile], lineno);
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
		bstore++;
#ifdef CDEBUG
fprintf(stderr, "bstore = %d\n", bstore);
#endif
		break;
	/*build end*/
	case 130:
		pline = strtok(NULL, " ");
		pline = strtok(NULL, " ");
		buildret = atoi(pline);
#ifdef CDEBUG
fprintf(stderr, "buildret = %d\n", buildret);
#endif
		if (buildret != 0) 
			bstore = 0;
		state=S_IDLE;
		break;
	/*operator abort*/
	case 90:
		state=S_IDLE;
		break;
	/*TCC message*/
	case 50:
		break;
	/*TCM message*/
	case 510:
		break;
	default:
		fprintf(stderr, "Illegal record (type = %d) in BUILD state in file %s line %d\n", mtype, fnames[curfile], lineno);
		exit(2);
	}
}

/*parse messages in the clean state*/
static void parseinclean(void)
{
	switch (mtype) {
	/*captured*/
	case 100:
		break;
	/*clean end*/
	case 320:
		state=S_IDLE;
		break;
	/*operator abort*/
	case 90:
		state=S_IDLE;
		break;
	/*TCC message*/
	case 50:
		break;
	/*TCM message*/
	case 510:
		break;
	default:
		fprintf(stderr, "Illegal record (type = %d) in CLEAN state in file %s line %d\n", mtype, fnames[curfile], lineno);
		exit(2);
	}
}

/*parse messages in the exec state*/
static void parseinexec(void)
{
	int	thisresult=0;
	int	thistest, i;

	switch (mtype) {
	/*TCM start*/
	case 15:
		break;
	/*TC end*/
	case 80:
		state=S_IDLE;
		break;
	/*IC start*/
	case 400:
		break;
	/*IC end*/
	case 410:
		break;
	/*TP start*/
	case 200:
		fFirst520 = 1;
		break;
	/*TP result*/
	case 220:
		pline = strtok(NULL, " ");
		pline = strtok(NULL, "|");
		pline = strtok(NULL, "\n");
		if (finscope != 0) {
		if (strcmp(pline, "PASS") == 0) {
			if (bstore == 0)  {
				thisresult = R_PASS;
				file_errs[curfile].npass++;
			}
			else {
				thisresult = R_FIP;
				file_errs[curfile].nfip++;
			}
		}
		if (strcmp(pline, "FAIL") == 0) {
			thisresult = R_FAIL;
			file_errs[curfile].nfail++;
		}
		if (strcmp(pline, "ABORT") == 0) {
			thisresult = R_ABORT;
			file_errs[curfile].nabort++;
			fabort = 1;
		}
		if (strcmp(pline, "UNRESOLVED") == 0) {
			thisresult = R_UNRESOLVED;
			file_errs[curfile].nunresolved++;
		}
		if (strcmp(pline, "UNINITIATED") == 0) {
			thisresult = R_UNINITIATED;
			file_errs[curfile].nuninitiated++;
		}
		if (strcmp(pline, "UNSUPPORTED") == 0) {
			thisresult = R_UNSUPPORTED;
			file_errs[curfile].nunsupported++;
		}
		if (strcmp(pline, "UNTESTED") == 0) {
			thisresult = R_UNTESTED;
			file_errs[curfile].nuntested++;
		}
		if (strcmp(pline, "NOTINUSE") == 0) {
			thisresult = R_NOTINUSE;
			file_errs[curfile].nnotinuse++;
		}
		if (strcmp(pline, "NORESULT") == 0) {
			thisresult = R_NORESULT;
			file_errs[curfile].nnoresult++;
		}
		if (strcmp(pline, "WARNING") == 0) {
			thisresult = R_WARNING;
			file_errs[curfile].nwarning++;
		}
		if (strcmp(pline, "FIP") == 0) {
			thisresult = R_FIP;
			file_errs[curfile].nfip++;
		}
		results[curfile][nextresult++]=thisresult;
		}
		break;

	case 520:
		pline = strtok(NULL, " ");
		if (fFirst520 == 1) {
			fFirst520 = 0;
			pline = strtok(NULL, " ");
			pline = strtok(NULL, " ");
			pline = strtok(NULL, "|");
			pline = strtok(NULL, " ");
			pline = strtok(NULL, " ");
			if (strcmp(pline, special2) != 0) {
				fprintf(stderr, "Special 520 record but not %s in EXEC state file %s line %d\n", special2, fnames[curfile], lineno);
				break;
			}
			if (finscope != 0) {
				pline = strtok(NULL, "\n");
				thistest = atoi(pline);
				if (thistest != actualtests+1) {
					for (i = actualtests+1; i< thistest; i++) {
					if (fabort) {
					results[curfile][nextresult++] = R_ABORT;
					file_errs[curfile].nabort++;
					}
					else {
						results[curfile][nextresult++]= R_UNINITIATED;
						file_errs[curfile].nuninitiated++;
						file_errs[curfile].actualtests++;
					}
					}
				}
				actualtests = thistest;
				file_errs[curfile].actualtests++;
			}
		}
		break;
	/*operator abort*/
	case 90:
		break;
	/*captured*/
	case 100:
		break;
	/*TCM message*/
	case 510:
		break;
	/*TCC message*/
	case 50:
		break;
	default:
		fprintf(stderr, "Illegal record (type = %d) in EXEC state in file %s line %d\n", mtype, fnames[curfile], lineno);
		exit(2);
	}
}

/*read and parse a journal file*/
static void parse_file(FILE *jfile)
{
	state = S_START;

	/*parse lines one by one*/
	while (fgets(linebuf, sizeof(linebuf), jfile) != NULL) {
		lineno++;
/*
#ifdef CDEBUG
fprintf(stderr, "%s", linebuf);
fflush(stderr);
#endif
*/
		/*get the message type number*/
		pline = strtok(&linebuf[0], "|");
		mtype = atoi(linebuf);
/*
#ifdef CDEBUG
fprintf(stderr, "State = %d, type = %d\n", state, mtype);
#endif
*/
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
			fprintf(stderr, "Illegal state: %d in file %s line %d\n", state, fnames[curfile], lineno);
			exit(2);
		}
	}
}

/*print the summary report*/
static void print_summary(void)
{

	int	i,j, k, n, mismatch, hack;

	if ((freportcase == 1) && (nareas == 0)) {
		printf("Test Case %s not found\n", reportcase);
		exit(0);
	}

	printf("TEST SECTION/CASE                     PURPOSE ");
	for (i = 0; i< nfiles; i++)
		printf(" FILE %d", i+1);
	printf("\n\n");


/*
	for (i = 0; i< nareas; i++) {
		printf("CASE = %s, first = %d, n = %d\n", areas[i].name, areas[i].firstresult, areas[i].nresults);
		n=0;
		for (j = areas[i].firstresult; j < areas[i].firstresult+ areas[i].nresults; j++ ) {
			printf("Result %d:", ++n);
			for (k = 0; k < nfiles; k++)
				printf("	%d", results[k][j]);
			printf("\n");
		}
	}
*/

	for (i = 0; i< nareas; i++) {

		n = 0;

		for (j = areas[i].firstresult; j < areas[i].firstresult+ areas[i].nresults; j++ ) {
			n++;
			hack = 0;
			for (k = 0; k < nfiles; k++)
				hack = hack + results[k][j];
			if (freportall == 1)
				mismatch = 1;
			else {
				mismatch = 0;
				for (k = 0; k < nfiles; k++) {
					if (hack/nfiles !=  results[k][j] ) {
						mismatch++;
					}
				}
				if (mismatch != 0)
					hits++;
				if ((freportunin == 1) && (mismatch == 0)){
					for (k = 0; k < nfiles; k++) {
						if (results[k][j]  == R_UNINITIATED)
							mismatch++;
					}
					if (mismatch != nfiles)
						mismatch = 0;
				}
				if ((freportfail == 1) && (mismatch == 0)){
					for (k = 0; k < nfiles; k++) {
						if (results[k][j]  == R_UNINITIATED)
							mismatch++;
						if (results[k][j]  == R_FIP)
							mismatch++;
						if (results[k][j]  == R_UNRESOLVED)
							mismatch++;
						if (results[k][j]  == R_FAIL)
							mismatch++;
						if (results[k][j]  == R_ABORT)
							mismatch++;
					}
				}
			}

			if (mismatch != 0) {
				printf("%-36s    %-5d  ", areas[i].name, n);

				for (k = 0; k < nfiles; k++) {
					if (results[k][j] == 0)
						printf("%-7s", "NTRUN");	
					else
					if (results[k][j] == R_PASS)
						printf("%-7s", "pass");	
					else
					if (results[k][j] == R_FAIL)
						printf("%-7s","FAIL");	
					else
					if (results[k][j] == R_ABORT)
						printf("%-7s","ABORT");	
					else
					if (results[k][j] == R_UNSUPPORTED)
						printf("%-7s", "unsup");	
					else
					if (results[k][j] == R_UNINITIATED)
						printf("%-7s", "UNINI");	
					else
					if (results[k][j] == R_NOTINUSE)
						printf("%-7s", "ntinu");	
					else
					if (results[k][j] == R_UNRESOLVED)
						printf("%-7s", "UNRES");	
					else
					if (results[k][j] == R_UNTESTED)
						printf("%-7s", "untst");	
					else
					if (results[k][j] == R_NORESULT)
						printf("%-7s", "NORES");	
					else
					if (results[k][j] == R_WARNING)
						printf("%-7s", "WARN");	
					else
					if (results[k][j] == R_FIP)
						printf("%-7s", "FIP");	
				}
				printf("\n");
			}
		}
	}

if (freportall == 0)
	if (hits == 1)
		printf("\n%d variance found\n", hits);
	else
		printf("\n%d variances found\n", hits);

	printf("\n");

	printf("%-39s      ", "TEST CASES");	
	for (i = 0; i<nfiles; i++) 
		printf("%7d", file_errs[i].actualareas);
	printf("\n");

	printf("%-39s      ", "TEST PURPOSES");	
	for (i = 0; i<nfiles; i++) 
		printf("%7d", file_errs[i].actualtests);
	printf("\n");

	printf("GOOD RESULTS\n");
	printf("%-39s      ", "  PASS");	
	for (i = 0; i<nfiles; i++) 
		printf("%7d", file_errs[i].npass);
	printf("\n");

	printf("%-39s      ", "  UNSUPPORTED");	
	for (i = 0; i<nfiles; i++) 
		printf("%7d", file_errs[i].nunsupported);
	printf("\n");

	printf("%-39s      ", "  UNTESTED");	
	for (i = 0; i<nfiles; i++) 
		printf("%7d", file_errs[i].nuntested);
	printf("\n");

	printf("%-39s      ", "  NOTINUSE");	
	for (i = 0; i<nfiles; i++) 
		printf("%7d", file_errs[i].nnotinuse);
	printf("\n");

	printf("ANALYSIS NEEDED\n");
	printf("%-39s      ", "  WARNING");	
	for (i = 0; i<nfiles; i++) 
		printf("%7d", file_errs[i].nwarning);
	printf("\n");

	printf("%-39s      ", "  FIP");	
	for (i = 0; i<nfiles; i++) 
		printf("%7d", file_errs[i].nfip);
	printf("\n");

	printf("ERROR RESULTS\n");
	printf("%-39s      ", "  FAIL");	
	for (i = 0; i<nfiles; i++) 
		printf("%7d", file_errs[i].nfail);
	printf("\n");

	printf("%-39s      ", "  ABORT");	
	for (i = 0; i<nfiles; i++) 
		printf("%7d", file_errs[i].nabort);
	printf("\n");

	printf("%-39s      ", "  UNRESOLVED");	
	for (i = 0; i<nfiles; i++) 
		printf("%7d", file_errs[i].nunresolved);
	printf("\n");

	printf("%-39s      ", "  UNINITIATED");	
	for (i = 0; i<nfiles; i++) 
		printf("%7d", file_errs[i].nuninitiated);
	printf("\n");

	printf("%-39s      ", "  NORESULT");	
	for (i = 0; i<nfiles; i++) 
		printf("%7d", file_errs[i].nnoresult);
	printf("\n");
}		

extern int optind, opterr, optopt;
extern char *optarg;

int main(char, char * const []);

int main(char argc, char * const argv[])
{
	int	optlet;
	int	errflag = 0;
	struct tm *thetime;
	time_t thetimet;
	char timebuf[512];
	FILE *verfile;
	char *vernum;

/*this is a common report generator use in VSU, VSW, and VSM*/
/*it can be invoked as vsurpt (or creport), vswrpt, or vsmrpt*/
/*and customizes itself to find the results for the appropriate*/
/*test suite*/

	strcpy(doc_dir, "doc");
	strcpy(special1, "CASE");
	strcpy(special2, "PURPOSE");

	if ((strcmp((const char *)basename(argv[0]), "creport") == 0) || (strcmp((const char *)basename(argv[0]), "vsurptm") == 0)) {
		strcpy(test_dir, "CAPI");
		strcpy(test_flag, "SPEC1170TESTSUITE");
		strcpy(test_name, "VSU4");
		strcpy(test_prefix, "VSU4");
		strcpy(vendor_name, "THE OPEN GROUP");
		strcpy(special1, "AREA");
		strcpy(special2, "CASE");
		strcpy(doc_dir, "DOC");
	} else {
		if (strcmp((const char *)basename(argv[0]), "vswrptm") == 0) {
			strcpy(test_dir, "xts5");
			strcpy(test_flag, "VSW5TESTSUITE");
			strcpy(test_name, "VSW5");
			strcpy(vendor_name, "THE OPEN GROUP");
			strcpy(test_prefix, "VSW");
		} else {
			if (strcmp((const char *)basename(argv[0]), "vsmrptm")  == 0) {
				strcpy(test_dir, "vsm4");
				strcpy(test_flag, "VSM4TESTSUITE");
				strcpy(test_name, "VSM4");
				strcpy(vendor_name, "THE OPEN GROUP");
				strcpy(test_prefix, "VSM");
			} else {
				fprintf(stderr, "Unknown argv[0] value = %s\n", basename(argv[0]));
				exit(2);
			}
		}
	}
	while ((optlet = getopt(argc, argv, OPTIONS))!= -1) {
		switch (optlet) {
		case 's':
			reportsection = optarg;
			freportsection = 1;
			freportcase = 0;
			break;
		case 't':
			reportcase = optarg;
			freportcase = 1;
			break;
		case 'f':
			freportfail = 1;
			break;
		case 'u':
			freportunin = 1;
			break;
		case 'a':
			freportall = 1;
			break;
		case 'h':
			errflag++;
			break;
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
		fprintf(stderr, "usage: %s [-s section] [-t test] [-a] [-h] [-u] [-f] journal1 journal2 [journal3] [journal4] [journal5] [journal6]\n", argv[0]);
		fprintf(stderr, "      -a show all results (not just variations)\n");
		fprintf(stderr, "      -h print this message\n");
		fprintf(stderr, "      -s report only on specified Section\n");
		fprintf(stderr, "      -t report only on specified Test Case\n");
		fprintf(stderr, "      -u show variations and Test Purposes UNINITIATED in all reports \n");
		fprintf(stderr, "      -f show variations and failures in any report \n");
		exit(2);
	}

	if ((freportcase == 1) && (freportsection == 1)) {
		freportsection = 0;
	}
	if ((freportall == 1) && (freportunin == 1)) {
		freportunin = 0;
	}
	if ((freportall == 1) && (freportfail == 1)) {
		freportfail = 0;
	}
	if ((argc - optind)  < 2) {
		fprintf(stderr, "Must specify at least two files\n");
		exit(2);
	}

	if ((argc  - optind) > NSYS) {
		fprintf(stderr, "Can specify at most %d files\n", NSYS);
		exit(2);
	}

	if ((freportcase == 1) || (freportsection == 1))
		finscope = 0;
	else
		finscope = 1;

	nfiles = argc-optind;
	
	for ( curfile = 0; curfile < nfiles; curfile++) {

		fnames[curfile] = argv[optind++];
		fprintf(stderr, "Processing file %s\n", fnames[curfile]);
		/*open the journal file for read*/
		files[curfile] = fopen(fnames[curfile], "r");
		if (files[curfile] == NULL) {
			fprintf(stderr, "Cannot open journal file %s\n", fnames[curfile]);
			perror("");
			exit(2);
		}
		lineno = 0;
		parse_file(files[curfile]);
	}

	printf("                        %s JOURNAL FILE COMPARISON REPORT\n", test_name);

	sprintf(verbuf, "%s/%s/%s/%s_RELEASE", getenv("TET_ROOT"), test_dir, doc_dir, test_prefix);

	verfile = fopen(verbuf, "r");
	if (verfile == 0) {
		fprintf(stderr, "WARNING: Cannot open RELEASE file: %s\n", verbuf);
	}
	else {
		vernum = fgets(verbuf, sizeof(verbuf), verfile);
		if (vernum == 0)
			fprintf(stderr, "WARNING: Cannot read version\n");
	}
	printf("                                 VERSION %s\n\n", verbuf);

	thetimet = time(0);
	thetime=localtime(&thetimet);
	strftime(timebuf, sizeof(timebuf), "%x %X", thetime);
	printf("Report generated: %s\n\n", timebuf);

	for ( curfile = 0; curfile < nfiles; curfile++) 
		printf("FILE %d = %s\n", curfile+1, fnames[curfile]);
	printf("\n");

	if (freportall) {
		if (freportcase == 1)
			printf("All results for Test Case: %s\n", reportcase);
		else if (freportsection == 1)
			printf("All results for Section: %s\n", reportsection);
		else
			printf("All results for all Sections and Test Cases\n");
	} else 
	if (freportfail) {
		if (freportcase == 1)
			printf("Variances and all failures for Test Case: %s\n", reportcase);
		else if (freportsection == 1)
			printf("Variances and all failures for Section: %s\n", reportsection);
		else
			printf("Variances and all failures for all Sections and Test Cases\n");
	} else 
	if (freportunin) {
		if (freportcase == 1)
			printf("Variances and UNINITIATED everywhere for Test Case: %s\n", reportcase);
		else if (freportsection == 1)
			printf("Variances and UNINITIATED everywhere for Section: %s\n", reportsection);
		else
			printf("Variances and UNINITIATED everywhere for all Sections and Test Cases\n");
	} else {
		if (freportcase == 1)
			printf("Variances for Test Case: %s\n", reportcase);
		else if (freportsection == 1)
			printf("Variance for Section: %s\n", reportsection);
		else
			printf("Variance for all Sections and Test Cases\n");
	}
	printf("\n");

	print_summary();

	exit(0);
}
