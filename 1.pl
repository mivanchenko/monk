#!/usr/bin/env perl

use strict;
use warnings;

use Perl6::Slurp;
use Text::MultiMarkdown 'markdown';

my $pages = {
#	'6' => {
#		src => 'Молитви/Шостопсалміє',
#	},
#	'narod' => {
#		src => 'Молитви/За народ',
#		pic => '125502_20_90.jpg',
#	},
#	'himn' => {
#		src => 'anthem',
#		pic => 'herb_15_90.png',
#	},
#	'shukai' => {
#		src => 'Цитати/Шукайте',
#	},
#	'wife' => {
#		src => 'Жінка',
#		pic => 'christianmarriage-200x138.jpg',
#	},
#	'diaka' => {
#		src => 'Молитви/Дяка',
#	},
#	'dumky' => {
#		src => 'Думки',
#	},
#	lyst => {
#		src => 'Молитви/Лист',
#		head => '<div align="center"><a href="http://molytva.at.ua/index/khresna_doroga/0-65"><img src="img/sts3-12_15_90.jpg" alt="Монах в Україні" /></a></div>'
#	},
#	'spovid' => {
#		src => 'Цитати/Сповідь',
#		head => '<div align="center"><a href="http://www.cerkva.info/uk/publications/articles/5873-pronyzylyva-spovid-divchyny-z-rukhu-qza-yedynu-pomisnu-tserkvuq.html" title='Пронизлива сповідь дівчини з руху "За Єдину Помісну Церкву"' target=_blank><img src="img/upc_50_90.jpg" alt="Церква.info: Офіційний веб-сайт УПЦ Київського Патріархату" border="0" /></a></div>'
#	},
	happy => {},
};

my $head_default = '<div align="center"><img src="../img/vor-monah_25_90.jpg"'
                 . "/></div>\n\n";
my $foot_default = '';

foreach my $src ( sort keys %{$pages} ) {
	my $page = $pages->{$src};

	my $header = slurp 'tpl/header';
	my $footer = slurp 'tpl/footer';

	my $head = $page->{head} || $head_default;
	my $foot = $page->{foot} || $foot_default;

	my $md   = slurp "src/$src";
	my $body = markdown $md;

	my $dest = "html/$src";
	open my $dest_fh, '>', $dest
		or die "Can't open $dest for writing: $!";
	print $dest_fh join( "\n", $header, $head, $body, $foot, $footer );
	close $dest_fh;
}

