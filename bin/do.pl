#!/usr/bin/env perl

use strict;
use warnings;

my $keyword = $ENV{'QUERY_STRING'};
$keyword =~ s/\W//g;

my $map = {
	'6' => {
		'src' => 'Молитви/Шостопсалміє',
		'pic' => 'vor-monah_25_90.jpg',
	},
	'letter' => {
		'src' => 'Молитви/Лист',
		'pic' => 'sts3-12_15_90.jpg',
	},
	'narod' => {
		'src' => 'Молитви/За народ',
		'pic' => '125502_20_90.jpg',
	}
};

if ( ! exists $map->{$keyword} ) {
	print "Location: http://monk.in.ua/\n\n";
	exit;
}

my $header1 = do { local( @ARGV, $/ ) = '../tpl/header1'; <> };
my $header2 = '';

if ( -r "../tpl/header2/$keyword" ) {
	$header2 = do { local( @ARGV, $/ ) = "../tpl/header2/$keyword"; <> };
}
else {
	$header2 = do { local( @ARGV, $/ ) = "../tpl/header2/default"; <> };
}

my $header3 = do { local( @ARGV, $/ ) = '../tpl/header3'; <> };
my $body    = do { local( @ARGV, $/ ) = "../src/$map->{$keyword}{'src'}"; <> };
my $footer  = do { local( @ARGV, $/ ) = '../tpl/footer'; <> };

my $header = join( "\n", $header1, $header2, $header3 );
$header =~ s/%(\w+)%/$map->{$keyword}{$1}/sg;

print "Content-Type: text/html; charset=utf-8\n\n";
print $header.$body.$footer;
