use common::sense;
use FindBin::libs;

use MyApp::Net::Req;

my $obj = MyApp::Net::Req->new;
print $obj->body('http://example.com');
