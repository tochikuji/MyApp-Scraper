use Test::More tests => 1;

use warnings;
use strict;
use MyApp::Net::Req;

subtest 'requests' => sub{
	plan tests => 2;
	my $obj = MyApp::Net::Req->new();

	isa_ok $obj, 'MyApp::Net::Req';
	ok $obj->imgs('http://google.com');
}
