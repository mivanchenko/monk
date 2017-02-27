#!/usr/bin/env perl

use strict;
use warnings;

use Perl6::Slurp;
use Text::MultiMarkdown 'markdown';

foreach my $src_name ( <src/*> ) {
	my @headers = (
		slurp 'tpl/header1',
	);
	my $text   = slurp $src_name;
	my $html   = markdown($text);
	my $footer = slurp 'tpl/footer';

	my $dest_name = $src_name =~ s{^src/}{html/}r;
	open my $dest_name_fh, '>', $dest_name
		or die "Can't open $dest_name for writing: $!";
	print $dest_name_fh join('', @headers) . $html . $footer;
	close $dest_name_fh;
}

