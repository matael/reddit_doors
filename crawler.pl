#!/usr/bin/env perl

# Simple reddit crawler using RSS feeds.

use strict;
use warnings;
use 5.010;
use LWP::Simple;
use RedditRIL;
use YAML;
use File::Slurp;

my $raw_config =read_file("./RedditRIL.conf") or die ("Error with conf. file $!");
my $config = Load($raw_config);

my $credentials = $config->{credentials};
my $api = RedditRIL->new(@{$credentials}[0], @{$credentials}[1]);
foreach my $subreddit (keys %{$config}) {
	next if $subreddit eq "credentials";
    say "--> Now processing /r/$subreddit";
	$api->process_subreddit($subreddit, $config->{$subreddit});
}
