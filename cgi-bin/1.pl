#!/usr/bin/env perl

use strict;
use warnings;
use v5.10;

print "Content-Type: text/plain\n\n";

foreach my $file ( <../src/*> ) {
	next if -d $file;
	next unless $file =~ m{/(.+).md};
	my $keyword = $1;
	say $file; 
	say $keyword;
}
