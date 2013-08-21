use strict;
use warnings;

use Test::More tests => 1;

use MyApp::Util::fFlag;

subtest 'usage' => sub {
	plan tests => 2;
	
	my $obj = MyApp::Util::fFlag->new;
	isa_ok $obj, 'MyApp::Util::fFlag';
	like $obj->{logfile}, qr/scraper/;
}
