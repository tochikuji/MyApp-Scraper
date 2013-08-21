use strict;
use warnings;
use MyApp::Scrape;

use Test::More tests => 1;

subtest 'scrape' => sub {
	plan tests => 1;

	my $obj = MyApp::Scrape->new;
	isa_ok $obj, 'MyApp::Scrape';
}
