use strict;
use warnings;
use utf8;
use Test::More tests => 3;

use_ok 'Unicode::Debug';
isa_ok 'Unicode::Debug' => 'Exporter';
can_ok 'Unicode::Debug' => qw(unidebug unidecode);
