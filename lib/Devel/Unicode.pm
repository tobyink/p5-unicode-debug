package Devel::Unicode;

use Unicode::Debug;

BEGIN
{
	$Devel::Unicode::AUTHORITY = 'cpan:TOBYINK';
	$Devel::Unicode::VERSION   = '0.001';
}

sub DB::DB { 1 }

sub import {
	my $class = shift;
	my $args  = join q(,), @_;
	
	$Unicode::Debug::Names      = 1 if $args =~ /name/i;
	$Unicode::Debug::Whitespace = 1 if $args =~ /ws|white/i;
	
	binmode STDOUT, ':via(UnicodeDebug)' or die $!;
}

__PACKAGE__
__END__

=head1 NAME

Devel::Unicode - sugar for setting STDOUT to use PerlIO::via::UnicodeDebug

=head1 SYNOPSIS

 perl -d:Unicode myscript.pl

 perl -d:Unicode=names myscript.pl

=head1 BUGS

Please report any bugs to
L<http://rt.cpan.org/Dist/Display.html?Queue=Unicode-Debug>.

=head1 SEE ALSO

L<PerlIO::via::UnicodeDebug>,
L<Unicode::Debug>.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2012 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 DISCLAIMER OF WARRANTIES

THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
