/*
Copyright (c) Open Text SA and/or Open Text ULC

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

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <libgen.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include "xtest.h"
#include "xtestlib.h"

/*
 * outfile takes a bare filename and returns a path to that file in the results
 * directory. The caller should not free the return value (it will be freed
 * automatically when tpcleanup is called at the end of each test).
 */
const char *
outfile(const char *fn)
{
	char *out;
	const char *path;
	char *resfile = getenv("TET_RESFILE");
	if (!resfile)
		return fn;

	resfile = strdup(resfile);
	if (!resfile)
		return fn;

	path = dirname(resfile);
	out = malloc(strlen(path) + strlen(fn) + 2);
	if (!out) {
		out = (char *)fn;
		goto done;
	}
	regid(NULL, (union regtypes *)&out, REG_MALLOC);

	sprintf(out, "%s/%s", path, fn);

done:
	free(resfile);
	return out;
}
