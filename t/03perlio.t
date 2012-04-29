use utf8;
use Test::More tests => 1;
use Unicode::Debug;

open my $fh, '>:via(UnicodeDebug)', \(my $file);
print $fh 'Héllò';

is(
	$file,
	'H\\x{00e9}ll\\x{00f2}',
	);
