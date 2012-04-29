use Test::More tests => 3;
BEGIN { use_ok('Unicode::Debug') };

isa_ok 'Unicode::Debug' => 'Exporter';
can_ok 'Unicode::Debug' => qw(unidebug unidecode);
