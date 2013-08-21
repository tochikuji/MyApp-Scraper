package MyApp::Util::fFlag;

use strict;
use warnings;
use Carp qw/croak/;

use Digest::SHA1 qw/sha1_hex/;


sub new {
	my $class = shift;
	my $self = { 
		logfile => $ENV{'HOME'}.'/.scraper',
		@_,
	};

	return bless $self, $class;
}

sub logs {
	my $self = shift;
	my @logs = ();
	open FH, '<'.$ENV{'HOME'}.'/.scraper' or croak "Cannot open logfile:$!";

	@logs = <FH>;
	close FH;

	return \@logs;
}

sub is_flagged {
	my $self = shift;
	my $url = shift;

	my $logs = logs;
	my $hash = sha1_hex( $url );

	return grep m/$hash/, @$logs;
}

sub set_flag {
	my $self = shift;
	my $url = shift;
	my $hash = sha1_hex( $url );

	open FH, ">>".$ENV{'HOME'}.'/.scraper' or 
		croak "Cannnot open logfile, it maybe unwritable".$self->{logfile}.$!;

	print FH "$hash\n";
	close FH;

	1;
}

1;
