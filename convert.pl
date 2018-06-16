#!/usr/bin/env perl

use strict;
use warnings;

use Perl6::Slurp;
use Text::MultiMarkdown 'markdown';

my $header = slurp 'tpl/header';
my $footer = slurp 'tpl/footer';

foreach my $file ( <src/*> ) {
	next if -d $file;
	next unless $file =~ m{/(.+).md};
	my $keyword = $1;

	my $md = slurp $file;
	my $body = markdown $md;

	open my $dest_fh, '>', $keyword
		or die "Can't open $keyword for writing: $!";
	print $dest_fh join( "\n", $header, $body, $footer );
	close $dest_fh;
}

# convert pestov

my @sources = qx{ find src/pestov | grep \.md\$ };

foreach my $source ( @sources ) {
	chomp $source;
	my $md = slurp $source;
	my $html_body = markdown $md;
	my $dest = $source;
	$dest =~ s{^src/}{};
	$dest =~ s{index\.md$}{index.html};
	$dest =~ s{\.md$}{};
	open my $dest_fh, '>', $dest
		or die "Can't open $dest for writing: $!";
	print $dest_fh join("\n", $header, $html_body, $footer);
	close $dest_fh;
}
