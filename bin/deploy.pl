#!/usr/bin/env perl

use strict;
use warnings;

push my @commands, (
	'git checkout master',
	'git pull',
	'chmod -R o-rwx ../* ../.*',
	'chmod -R g-rwx ../.git',
	'chmod -R g-w ../* ../.htaccess',
	"chmod 700 $0",
);

my $command = join( ' 2>&1'."\n", @commands );

print "Content-Type: text/plain\n\n";

my $result = qx( $command );
print "$result\n";
