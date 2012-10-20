package RedditRIL;
use strict;
use warnings;
use 5.010;
use LWP::Simple;
use XML::RSS::Parser::Lite;
use Text::Match::FastAlternatives;

my $ril_api_key = "5c2A5U01d2f4fR3f3cp5cF7NU6TKLG6b"; #Application's API key for RIL/Pocket service;
my $ril_login; #Initializing variables to be available package-wide;
my $ril_pass;
my $ril_url;

sub new {
    my $self = shift;
    $ril_login = shift;
    $ril_pass = shift;
    $ril_url = "https://readitlaterlist.com/v2/add?username=$ril_login&password=$ril_pass&apikey=$ril_api_key";
    return $self;
}

sub process_subreddit {
    # Process a subreddit,
    # Get a subreddit name & keywords
    # as argument
    my ($self, $sub, $keywords) = @_; #unpack variables from function caller;
    my $parser = XML::RSS::Parser::Lite->new(); #Create new parser;
    $parser->parse(get("http://www.reddit.com/r/$sub/new/.rss?limit=5&t=all&sort=new")) or die ("Erf.. a error occured :\n\t$!");
    my $search_terms  = join "|", @{$keywords}; #Stitch together easy list of keywords;
    my $nothing = 1; # just for cosmetic purpose ;)
    for (my $i = 0; $i < $parser->count(); $i++) {
        my $item = $parser->get($i);
        if ($item->{title} =~ $search_terms) {
            $self->add_to_ril($item);
            $nothing = 0;
        }
    }
    say "\tNothing to do here..." if $nothing;
}

sub add_to_ril { #Submit link to RIL/Pocket service;
    my ($self,$item)  = @_; #Unpack variables from function caller;
    say "+ Adding link $item->{url}\n\t[$item->{title}]"; #Provide feedback;
    get("$ril_url&url=$item->{url}&title=$item->{title}") or die ("Unable to upload link to RIL...\n\t$!");
    say("\t=> Done uploading !"); #Announce that we're finished here;
}
1;
