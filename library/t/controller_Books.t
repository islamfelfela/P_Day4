use strict;
use warnings;
use Test::More;


use Catalyst::Test 'library';
use library::Controller::Books;

ok( request('/books')->is_success, 'Request should succeed' );
done_testing();
