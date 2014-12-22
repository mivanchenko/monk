#!/usr/bin/env perl

use strict;
use warnings;

use CGI;

my $q = CGI->new;
my @keywords = $q->keywords;

print "Content-Type: text/plain\n\n";
print "do.pl\n";
print "@keywords\n";
