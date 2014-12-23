#!/usr/bin/env perl

use strict;
use warnings;

use CGI;

my $q = CGI->new;
my ($keyword) = $q->keywords;

my $map = {
	'6' => 'Молитви/Шостопсалміє',
};

exit unless exists $map->{$keyword};

my $header = do '../tpl/header';
my $body   = '';
my $footer = do '../tpl/footer';

my $path = "../src/$map->{$keyword}";
open my $fh, '<', $path
	or die "Can't open $path: [$!]";
while ( my $line = <$fh> ) {
	chomp $line;
	$body .= "<p>$line</p>";
}
close $fh;

print "Content-Type: text/html; charset=utf-8\n\n";
print $header.$body.$footer;
