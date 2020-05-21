use strict;
use warnings;

use library;

my $app = library->apply_default_middlewares(library->psgi_app);
$app;

