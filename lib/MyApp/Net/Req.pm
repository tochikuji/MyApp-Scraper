package MyApp::Net::Req;

use strict;
use warnings;
use LWP::UserAgent;
use Carp qw/croak/;

sub new {
	my $class = shift;
	my $self = { @_ };

	return bless $self, $class;
}

sub init {
	1;
}

my $body = sub {
	my $self = shift;
	my $url = shift;
	my $ua = LWP::UserAgent->new;

	$ua->timeout(10);
	$ua->agent('Mozilla');

	my $req = HTTP::Request->new(GET => $url);
	$req->referer('http://google.com/');
	my $response = $ua->request($req);

	unless($response->is_success){
		croak $response->status_line;
	}

	return $response->content;
};

sub imgs {
	my $self = shift;
	my $url = shift;
	my $resource = $self->$body( $url );

	my @urls = ();

	my @imgs = $resource =~ m#(?<=tp://)([\w\.\-/;\?\@\&\=\+,]*\.(?:jpg|png|jpeg|gif))#ig;

	@urls = map { $_ = 'http://'.$_; } @imgs;
	return \@urls;
}

1;
