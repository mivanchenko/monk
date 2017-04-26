#!/usr/bin/env perl

use strict;
use warnings;

push my @commands, (
#	'git checkout HEAD -- .',
	'git checkout master',
	'git pull',
#	'chmod 750 *.pl'
#   'cp ../../word/index.html ../',
);

my $command = join( ' 2>&1'."\n", @commands );

my $result = qx( $command );

print "Content-Type: text/plain\n\n";
print "$result\n";

