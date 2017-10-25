#!/usr/bin/env perl

use strict;
use warnings;

use Perl6::Slurp;
use Text::MultiMarkdown 'markdown';

my $pages = {
	6 => {},
	anthem => {
		face => 'herb_15_90.png',
	},
	evening => {},
	'from-v' => {},
	'from-kuksha' => {},
	happy => {},
	letter => {
		head => '<div align="center"><a href="http://molytva.at.ua/index/khresna_doroga/0-65"><img src="../img/sts3-12_15_90.jpg" /></a></div>'
	},
	morning => {},
	nation => {
		face => '125502_20_90.jpg',
	},
	serb => {},
	thank => {},
	'ukr-sins' => {},
	wife => {
		face => 'christianmarriage-200x138.jpg',
	},
};

my $head_begin   = '<div align="center"><img src="../img/';
my $face_default = 'sonce.jpg';
my $head_end     = '" /></div>' . "\n\n";

foreach my $keyword ( sort keys %{$pages} ) {
	my $page = $pages->{$keyword};

	my $header = slurp 'tpl/header';
	my $footer = slurp 'tpl/footer';

	my $head;

	if ( $page->{head} ) {
		$head = $page->{head};
	}
	elsif ( $page->{face} ) {
		$head = $head_begin . $page->{face} . $head_end;
	}
	else {
		$head = $head_begin . $face_default . $head_end;
	}

	my $foot = $page->{foot} || '';

	my $md   = slurp "src/$keyword";
	my $body = markdown $md;

	my $dest = $keyword;
	open my $dest_fh, '>', $dest
		or die "Can't open $dest for writing: $!";
	print $dest_fh join( "\n", $header, $head, $body, $foot, $footer );
	close $dest_fh;
}

