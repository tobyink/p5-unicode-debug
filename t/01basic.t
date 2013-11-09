=pod

=encoding utf8

=head1 PURPOSE

Tests that L<Unicode::Debug> loads, and provides the expected API.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2012-2013 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

use strict;
use warnings;
use utf8;
use Test::More tests => 3;

use_ok 'Unicode::Debug';
isa_ok 'Unicode::Debug' => 'Exporter';
can_ok 'Unicode::Debug' => qw(unidebug unidecode);
