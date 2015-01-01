#!/usr/bin/env perl

use strict;
use warnings;

my $keyword = $ENV{'QUERY_STRING'};
$keyword =~ s/\W//g;

# 'pic' is optional
my $map = {
	'6'      => {
		'src' => 'Молитви/Шостопсалміє',
		'pic' => 'vor-monah_25_90.jpg',
	},
	'letter' => {
		'src' => 'Молитви/Лист',
	},
};

if ( ! exists $map->{$keyword} ) {
	print "Location: http://monk.in.ua/\n\n";
	exit;
}

my $header = do { local( @ARGV, $/ ) = '../tpl/header'; <> };
my $body   = do { local( @ARGV, $/ ) = "../src/$map->{$keyword}{'src'}"; <> };
my $footer = do { local( @ARGV, $/ ) = '../tpl/footer'; <> };

$header =~ s/%(\w+)%/$map->{$keyword}{$1}/g;

print "Content-Type: text/html; charset=utf-8\n\n";
print $header.$body.$footer;
