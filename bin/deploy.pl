#!/usr/bin/env perl

use strict;
use warnings;

push my @commands, (
	'git checkout master',
	'git pull',
	'chmod 750 *.pl'
);

my $command = join( ' 2>&1'."\n", @commands );

print "Content-Type: text/plain\n\n";

my $result = qx( $command );
print "$result\n";

