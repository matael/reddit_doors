#!/usr/bin/env perl

# Simple reddit crawler using RSS feeds.

use strict;
use warnings;
use 5.010;
use LWP::Simple;
use XML::RSS::Parser::Lite;

my $data = XML::RSS::Parser::Lite->new();
$data->parse(get("http://www.reddit.com/r/vim/new/.rss?limit=5&t=all&sort=new"));

for (my $i = 0; $i < $data->count(); $i++) {
	my $cur = $data->get($i);
	say "Link $i\n\t+-> Title:: $cur->{title}\n\t+-> URL:: $cur->{url}\n";
}
