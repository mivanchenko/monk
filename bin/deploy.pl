#!/usr/bin/env perl

use strict;
use warnings;

push my @commands, (
	'git checkout HEAD -- .',
	'git pull',
	'chmod 750 bin/*.pl'
);

my $command = join( ' 2>&1'."\n", @commands );

my $result = qx( $command );

print "Content-Type: text/plain\n\n";
print "$result\n";

