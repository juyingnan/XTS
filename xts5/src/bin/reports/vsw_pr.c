/*
Copyright (c) 2005 X.Org Foundation LLC

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
$Header: /cvs/xtest/xtest/xts5/src/bin/reports/vsw_pr.c,v 1.1 2005-02-12 14:37:14 anderson Exp $
*
* Copyright Applied Testing and Technology Inc. 1994, 1995
* All rights reserved
*
* Project: VSW5
*
* File: vsw_pr.c
*
* Description:
*	Report print formatter used by xreport
*
* Modifications:
*  $Log: vsw_pr.c,v $
*  Revision 1.1  2005-02-12 14:37:14  anderson
*  Initial revision
*
*  Revision 8.0  1998/12/23 23:24:18  mar
*  Branch point for Release 5.0.2
*
*  Revision 7.0  1998/10/30 22:42:28  mar
*  Branch point for Release 5.0.2b1
*
*  Revision 6.0  1998/03/02 05:16:44  tbr
*  Branch point for Release 5.0.1
*
*  Revision 5.0  1998/01/26 03:13:17  tbr
*  Branch point for Release 5.0.1b1
*
*  Revision 4.0  1995/12/18 02:58:07  tbr
*  Branch point for release 5.0.0.
*
* Revision 1.4  1995/12/18  02:56:47  tbr
* changed main() from void to int
*
* Revision 1.3  1995/12/15  01:09:09  andy
* Prepare for GA Release
*
*/

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <time.h>

#define OPTIONS ":s:o:l:"

extern int optind, opterr, optopt;
extern char *optarg;

int main(char, char * const []);

int main(char argc, char * const argv[])
{
	int     optlet, lines=54, nchar, mchar;
	char	*theorg="", *thesystem="";
	char	thedate[128];
	time_t	thetime;
	char	foot1[80];
	char	foot2[80];
	int	linecount=0;
	int	i, j, k;
	char	linebuf[1024];
	int	storecnt = 0;
	char 	*linestore[66*500];
	char	*lptr;
	int	pagecount=0, pagetotal=0;

	opterr = 1;

	while ((optlet = getopt(argc, argv, OPTIONS))!= -1) {
		switch (optlet) {
		case 'o':
			theorg = optarg;
			break;
		case 's':
			thesystem=optarg;
			break;
		case 'l':
			lines=atoi(optarg);
			break;
		case ':':
			fprintf(stderr, "vsu_pr: option -%c requires an operand\n", optopt);
			exit(1);
		}
	}

#ifdef CDEBUG
printf("org = %s\n", theorg);
printf("system = %s\n", thesystem);
printf("lines = %d\n", lines);
#endif
	if (lines < 40) {
		fprintf(stderr, "vsu_pr: lines per page must be at least 40, is %d\n", lines);
		exit(1);
	}
	time(&thetime);
	strftime(thedate, sizeof(thedate), "%b %d, %Y", localtime(&thetime));
#ifdef CDEBUG
printf("date = %s\n", thedate);
#endif

	memset(foot1, ' ', sizeof(foot1));
	memset(foot2, ' ', sizeof(foot1));

	i = strlen(thedate)+1;
	j = strlen(thesystem)+strlen("System: ");
	if (j > (80 - i)) {
		fprintf(stderr, "xreport: too many characters in system name\n");
		exit(1);
	}
	sprintf(foot1, "System: %s", thesystem);
	foot1[j] = ' ';
	sprintf(&foot1[80-i], "%s", thedate);

	k = strlen(theorg) + strlen("Organization: ");
	j = strlen("Page  of  ")+3+3+1;
	if (j > (80 - k)) {
		fprintf(stderr, "xreport: too many characters in organization name\n");
		exit(1);
	}
	sprintf(foot2, "Organization: %s", theorg);
	foot2[k] = ' ';

	/*first count the number of pages while storing and breaking up lines*/
	while (fgets(linebuf, sizeof(linebuf), stdin) != 0) {
		nchar = strlen(linebuf);
		lptr = linebuf;
		while (nchar > 0) {
			mchar = (nchar < 80) ? nchar : 80;
			linestore[storecnt] = (char *)malloc(mchar +2);
			if (linestore[storecnt] == 0) {
				fprintf(stderr, "xreport: malloc failed");
				exit(1);
			}
			strncpy(linestore[storecnt], lptr, mchar);
			if (linestore[storecnt][mchar-1] != '\n') {
				linestore[storecnt][mchar] = '\n';
				linestore[storecnt][mchar+1] = 0;
			}
			else
				linestore[storecnt][mchar] = 0;
			nchar -= 80;
			lptr += 80;
			if (linebuf[0] == 0xc) {
				pagetotal++;
				linecount = 0;
			}
			else {
				linecount++;
				if (linecount == (lines -5)) {
					pagetotal++;
					linecount = 0;
				}
			}
			storecnt++;
			if (storecnt == (sizeof(linestore)/sizeof(char *))) {
				fprintf(stderr, "xreport: sorry, cannot handle a report this large");
				exit(1);
			}
		}
	}
	pagetotal++;

	/*now spew em out*/
	linecount = 0;
	pagecount = 1;
	for (i = 0; i < storecnt; i++) {
		if (*linestore[i] == 0xc) {
			for (j = 0; j < (lines-linecount-5); j++)
				printf("\n");
			printf("\n\n%s\n", foot1);
			sprintf(linebuf, "Page %d of %d", pagecount, pagetotal);
			strcpy(&foot2[80-strlen(linebuf)-1], linebuf);
			printf("%s\n\f", foot2);
			pagecount++;
			linecount = 0;
			continue;
		}
		printf("%s", linestore[i]);
		linecount++;
		if (linecount == lines-5) {
			printf("\n\n%s\n", foot1);
			sprintf(linebuf, "Page %d of %d", pagecount, pagetotal);
			strcpy(&foot2[80-strlen(linebuf)-1], linebuf);
			printf("%s\n\f", foot2);
			pagecount++;
			linecount = 0;
		}
	}
	for (j = 0; j < (lines-linecount-5); j++)
		printf("\n");
	printf("\n\n%s\n", foot1);
	sprintf(linebuf, "Page %d of %d", pagecount, pagetotal);
	strcpy(&foot2[80-strlen(linebuf)-1], linebuf);
	printf("%s\n", foot2);
	pagecount++;
	linecount = 0;
}
