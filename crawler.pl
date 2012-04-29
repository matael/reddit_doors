#!/usr/bin/env perl

# Simple reddit crawler using RSS feeds.

use strict;
use warnings;
use 5.010;
use LWP::Simple;
use RedditRIL;
use YAML;
use File::Slurp;

my $data =read_file("./RedditRIL.conf") or die ("Error with conf. file $!");
my $conf = Load($data);

my $credentials = $conf->{credentials};
my $api = RedditRIL->new(@{$credentials}[0], @{$credentials}[1]);
foreach my $key (keys %{$conf}) {
	next if $key eq "credentials";
    say "--> Now processing /r/$key";
	$api->process($key, $conf->{$key});
}
