#!/usr/bin/env perl

use strict;
use warnings;

push my @commands, (
	'git checkout HEAD -- .',
	'git pull',
);

my $command = join( ' 2>&1'."\n", @commands );

my $result = qx( $command );

print "Content-Type: text/html\n\n";
print "<html><body>\n";
print "<pre>$result</pre>\n";
print "</body></html>\n";

