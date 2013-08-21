use common::sense;
use FindBin::libs;

use MyApp::Scrape;

my ($url, $dir, $log) = @ARGV;
my $obj;

if( defined $log ){
	$obj = MyApp::Scrape->new( $log );
} else {
	$obj = MyApp::Scrape->new;
}

$obj->Scrape( $url, $dir );

1;
