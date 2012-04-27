package RedditRIL;
{
	use strict;
	use warnings;
	use 5.010;
	use LWP::Simple;
	use XML::RSS::Parser::Lite;
	use Text::Match::FastAlternatives;

	my $ril_api_key = "5c2A5U01d2f4fR3f3cp5cF7NU6TKLG6b";
	my $ril_login = "";
	my $ril_pass = "";
	my $ril_url = "";

	sub new {
		my $self = shift;
		$ril_login = shift;
		$ril_pass = shift;
		$ril_url = "https://readitlaterlist.com/v2/add?username=$ril_login&password=$ril_pass&apikey=$ril_api_key";
		return $self;
	}

	sub process {
		# Process a subreddit,
		# Get a subreddit name & keywords
		# as argument
		my ($self, $sub, $kws) = @_;
		my $data = XML::RSS::Parser::Lite->new();
		$data->parse(get("http://www.reddit.com/r/$sub/new/.rss?limit=5&t=all&sort=new")) or die ("Erf.. a error occured :\n\t$!");
		my $re  = join "|", @{$kws};
		for (my $i = 0; $i < $data->count(); $i++) {
			my $item = $data->get($i);
			if ($item->{title} =~ $re) {
				$self->add_to_ril($item);
			}
		}
	}

	sub add_to_ril {
		my ($self,$item)  = @_;
		say "+ Adding link $item->{url}";
		get("$ril_url&url=$item->{url}&title=$item->{title}") or die ("Unable to upload link to RIL...\n\t$!");
	}
}
1;
