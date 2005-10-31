#!/usr/bin/perl
#SCCS:	@(#)make_tcm.pl	1.2 (96/10/21) TETware release 3.3

#make_tcm.pl - create tcm.pl from template.pl

$TET_ROOT=$ENV{TET_ROOT};

open(TEMPLATE,"<template.pl") || die("Can't open template.pl");
@template=<TEMPLATE>;
close(TEMPLATE);

$OS=`uname`;
chop($OS);
if ($OS eq "") {
	die "Can't determine O/S name.\n";
}
$_=$OS;
if (/Windows_NT/ || /Windows_95/) {
	# no signal handling on Windows
	$SIGS="NONE";
}
elsif (/SunOS/) {
	$OS_VERSION=`uname -r`;
	chop($OS_VERSION);
	$_=$OS_VERSION;
	if (/5\./) {
		$SIGS="NONE HUP INT QUIT ILL TRAP IOT EMT FPE KILL BUS SEGV SYS PIPE ALRM TERM USR1 USR2 CHLD PWR WINCH URG POLL STOP TSTP CONT TTIN TTOU VTALRM PROF XCPU XFSZ WAITING LWP";
	}
	else {
		$SIGS="NONE HUP INT QUIT ILL TRAP IOT EMT FPE KILL BUS SEGV SYS PIPE ALRM TERM URG STOP TSTP CONT CHLD TTIN TTOU IO XCPU XFSZ VTALRM PROF WINCH LOST USR1 USR2";
	}
} 
else {
	stat("sig");
	if (! -f _ || ! -r _ || ! -x _) {
		die "Can't find executable ./sig.\n";
	}

	$SIGS=`./sig`;
	chop($SIGS);
	if ($SIGS eq "") {
		$SIGS="NONE HUP INT QUIT ILL TRAP IOT EMT FPE KILL BUS SEGV SYS PIPE ALRM TERM";
	}
}

$COMMA_SIGS=$SIGS;
$COMMA_SIGS =~ s/ /,/g;
@sig_list = split(/ /,$SIGS);
$NSIG=$#sig_list+1;
grep(s/__NSIG__/$NSIG/,@template);
grep(s/__SIGNAMES__/$COMMA_SIGS/,@template);
open(TCM,">tcm.pl") || die("Can't open tcm.pl for output");
print TCM @template;
close(TCM);

