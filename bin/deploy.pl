#!/usr/bin/env perl

use strict;
use warnings;

push my @commands, (
	'git checkout master',
	'git pull',
	'chmod o-rwx ../.*',
);

my $command = join( ' 2>&1'."\n", @commands );

print "Content-Type: text/plain\n\n";

my $result = qx( $command );
print "$result\n";

