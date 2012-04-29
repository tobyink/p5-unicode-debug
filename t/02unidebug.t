use utf8;
use Test::More tests => 3;
use Unicode::Debug;

is(
	unidebug('Héllò'),
	'H\\x{00e9}ll\\x{00f2}',
	);

$Unicode::Debug::Names = 1;
is(
	unidebug('Héllò'),
	'H\N{LATIN SMALL LETTER E WITH ACUTE}ll\N{LATIN SMALL LETTER O WITH GRAVE}',
	);

$Unicode::Debug::Whitespace = 1;
is(
	unidebug("\tHello\r\n"),
	"\\tHello\\r\\n\n",
	);
