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

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: xts/Xt3/DataTypes.m
>># 
>># Description:
>>#	Tests for Intrinsics datatypes
>># 
>># Modifications:
>># $Log: dttyps.m,v $
>># Revision 1.1  2005-02-12 14:37:59  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:04  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:58:52  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:17  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:23:50  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:15:10  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:18:41  andy
>># Prepare for GA Release
>>#
>>EXTERN
int bits_per_char = 0;
void get_bits_per_char()
{
	unsigned char testVar;
	testVar = 1;
	while (testVar != 0) {
		testVar = testVar << 1;
		bits_per_char++;
	}
}
>>TITLE DataTypes Xt3
>>ASSERTION Good A
The data type Boolean shall be able to hold a zero or non-zero value.
>>CODE
	Boolean testVar;

	tet_infoline("TEST: Size of Boolean");
	if (sizeof(testVar) < 1) {
		sprintf(ebuf, "ERROR: Size of Boolean is %d, expected at least 1", sizeof(testVar));
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
The data type Cardinal shall be an unsigned datum with
a minimum range of 0 through 2**16-1.
>>CODE
	Cardinal testVar;

	get_bits_per_char();
	tet_infoline("TEST: Size of Cardinal");
	if (sizeof(testVar) < 16/bits_per_char) {
		sprintf(ebuf, "ERROR: Size of Cardinal is %d bits, expected at least 16", sizeof(testVar)*bits_per_char);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Cardinal is unsigned");
	testVar = -1;
	if (testVar < 0) {
		tet_infoline("ERROR: Cardinal was signed");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
The data type Dimension shall be an unsigned datum with
a minimum range of 0 through 2**16-1.
>>CODE
	Dimension testVar;

	get_bits_per_char();
	tet_infoline("TEST: Size of Dimension");
	if (sizeof(testVar) < 16/bits_per_char) {
		sprintf(ebuf, "ERROR: Size of Dimension is %d bits, expected at least 16", sizeof(testVar)*bits_per_char);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Dimension is unsigned");
	testVar = -1;
	if (testVar < 0) {
		tet_infoline("ERROR: Dimension is signed");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
The data type Position shall be a signed datum with
a minimum range of -2**15 through 2**15-1.
>>CODE
	Position testVar;

	get_bits_per_char();
	tet_infoline("TEST: Size of Position");
	if (sizeof(testVar) < 16/bits_per_char) {
		sprintf(ebuf, "ERROR: Size of Position is %d bits, expected at least 16", sizeof(testVar)*bits_per_char);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Position is signed");
	testVar = -1;
	if (testVar > 0) {
		tet_infoline("ERROR: Position is unsigned");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
The data type XtPointer shall be a datum large enough
to contain the largest of a char*, int*, function
pointer, structure pointer, or long value.
>>CODE
XtPointer testVar;
char *ptestChar;
int *ptestInt;
long testLong;	
int (*pfunc)();
struct {int temp;} *ptestStruct;

	tet_infoline("TEST: Size of XtPointer");
	if (sizeof(testVar) < sizeof(ptestChar)) {
		sprintf(ebuf, "ERROR: Size of XtPointer(%d) is less than that of *char(%d)", sizeof(testVar), sizeof(ptestChar));
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (sizeof(testVar) < sizeof(ptestInt)) {
		sprintf(ebuf, "ERROR: Size of XtPointer(%d) is less than that of *int(%d)", sizeof(testVar), sizeof(ptestInt));
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (sizeof(testVar) < sizeof(testLong)) {
		sprintf(ebuf, "ERROR: Size of XtPointer(%d) is less than that of *long(%d)", sizeof(testVar), sizeof(testLong));
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (sizeof(testVar) < sizeof(ptestStruct)) {
		sprintf(ebuf, "ERROR: Size of XtPointer(%d) is less than that of *struct(%d)", sizeof(testVar), sizeof(ptestStruct));
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (sizeof(testVar) < sizeof(pfunc)) {
		sprintf(ebuf, "ERROR: Size of Pointer(%d) is less than that of *function(%d)", sizeof(testVar), sizeof(pfunc));
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
A pointer to any type or function or a long value may be converted to
an XtPointer and back again and the results will compare equal to the
original value.
>>CODE
char testChar, *ptestChar;
int testInt, *ptestInt;
long testLong;	
struct {int temp;} testStruct, *ptestStruct;

	tet_infoline("TEST: Values can be cooerced to XtPointer without change");
	ptestChar = &testChar;
	if ((XtPointer)(ptestChar) != &testChar) {
		sprintf(ebuf, "ERROR: *char changed value when cooerced to XtPointer");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	ptestInt = &testInt;
	if ((XtPointer)(ptestInt) != &testInt) {
		sprintf(ebuf, "ERROR: *int changed value when cooerced to XtPointer");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	ptestStruct = &testStruct;
	if ((XtPointer)(ptestStruct) != &testStruct) {
		sprintf(ebuf, "ERROR: *struct changed value when cooerced to XtPointer");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	testLong = (long)&testStruct;
	if ((XtPointer)(testLong) != &testStruct) {
		sprintf(ebuf, "ERROR: long changed value when cooerced to XtPointer");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
The data type XtArgVal shall be a datum large enough to contain an
XtPointer, Cardinal, Dimension or Position value.
>>CODE
XtArgVal testVar;
XtPointer testPoint;
Cardinal testCard;
Dimension testDim;
Position testPos;

	tet_infoline("TEST: Size of XtArgVal");
	if (sizeof(testVar) < sizeof(testPoint)) {
		sprintf(ebuf, "ERROR: Size of XtArgVal(%d) is less than that of XtPointerchar(%d)", sizeof(testVar), sizeof(testPoint));
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (sizeof(testVar) < sizeof(testCard)) {
		sprintf(ebuf, "ERROR: Size of XtArgVal(%d) is less than that of Cardinal(%d)", sizeof(testVar), sizeof(testCard));
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (sizeof(testVar) < sizeof(testDim)) {
		sprintf(ebuf, "ERROR: Size of XtArgVal(%d) is less than that of Dimension(%d)", sizeof(testVar), sizeof(testDim));
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (sizeof(testVar) < sizeof(testPos)) {
		sprintf(ebuf, "ERROR: Size of XtArgVal(%d) is less than that of Position(%d)", sizeof(testVar), sizeof(testPos));
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
The data type XtEnum shall be able to hold least 128 distinct values, two
of which are the symbolic values True and False.
>>CODE
	XtEnum testVar;

	get_bits_per_char();
	tet_infoline("TEST: Size of XtEnum");
	if (sizeof(testVar)*bits_per_char < 7) {
		sprintf(ebuf, "ERROR: Size of XtEnum is %d bits, expected at least 7", sizeof(testVar)*bits_per_char);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: True and False fit in XtEnum");
	testVar = True;
	if (testVar != True) {
		tet_infoline("ERROR: True does not fit in XtEnum");
		tet_result(TET_FAIL);
	}
	testVar = False;
	if (testVar != False) {
		tet_infoline("ERROR: False does not fit in XtEnum");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
The symbols TRUE and FALSE shall be equal to True and False, respectively.
>>CODE

	if (TRUE != True) {
		sprintf(ebuf, "ERROR: TRUE(%d) not equal to True(%d)", TRUE, True);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (FALSE != False) {
		sprintf(ebuf, "ERROR: FALSE(%d) not equal to False(%d)", FALSE, False);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
