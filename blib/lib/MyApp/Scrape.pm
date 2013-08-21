package MyApp::Scrape;

use strict;
use warnings;
use Carp qw/croak/;

use MyApp::Net::Req;
use MyApp::Util::fFlag;

sub new {
	my $class = shift;
	my $self = { @_ };

	MyApp::Net::Req->new;
	if( defined $self->{log} ){
		MyApp::Util::fFlag->new(
			logfile => $self->{log},
		);
	} else {
		MyApp::Util::fFlag->new;
	}

	return bless $self, $class;
}

my $get = sub {
	my $self = shift;
	my $url = shift;
	my $filename = shift;
	
	my $ua = LWP::UserAgent->new;
	$ua->referer('http://www.2ch.net/');

	$ua->get(
		$url,
		':content_file' => $filename,
	);

	1;
};

sub Scrape {
	my $self = shift;
	my $url = shift;

	my $imgdir = shift;
	$imgdir //= './scraper_imgs';
	mkdir $imgdir unless -e $imgdir
		or croak "Cannot create img directory:$!";
	chdir $imgdir or 
		croak "Cannnot chdir $imgdir:$!";

	my $imgs = MyApp::Net::Req->imgs( $url );

	foreach( @$imgs ) {
		print "image $_ ... ";

		if( MyApp::Util::fFlag->is_flagged( $_ ) ){
			print "exists";
			next;
		} else {
			MyApp::Util::fFlag->set_flag( $_ );
			print "scraping..." 
		}

		my $hash = sha1_hex( $_ ); 
		m/.+?(jpg|png|jpeg|gif)$/;
		my $filename = substr( $hash, 1, 17 ) . $1;

		$self->get( $_, $filename );
		print "done.\n";
	}

	1;
}
