package Unicode::Debug;

use 5.010;
use strict;
use warnings;
use charnames ':full';
use utf8;

BEGIN
{
	$Unicode::Debug::AUTHORITY = 'cpan:TOBYINK';
	$Unicode::Debug::VERSION   = '0.001';
}

use base 'Exporter';
our @EXPORT    = qw(unidebug);
our @EXPORT_OK = (@EXPORT, qw(unidecode));
our %EXPORT_TAGS = (
	default  => \@EXPORT,
	standard => \@EXPORT,
	all      => \@EXPORT_OK,
	nothing  => [],
	);

our $Whitespace = 0;
our $Names      = 0;

sub unidecode
{
	unless (defined wantarray)
	{
		s/(\r\n|[^\x20-\x7F])/_char($1)/eg for @_;
	}
	
	my @str = map {
		(my $str = $_) =~ s/(\r\n|\\|[^\x20-\x7F])/_char($1)/eg;
		$str;
	} (wantarray ? @_ : $_[0]);
	
	wantarray ? @str : $str[0];
}

sub _char
{
	goto \&_ws if $_[0] ~~ ["\r\n", "\r", "\n", "\t"];
	
	my $chr = shift;
	my $ord = ord $chr;
	
	return "\\\\" if $chr eq "\\"; 

	if ($Names and my $name = charnames::viacode($ord))
	{
		return sprintf('\N{%s}', $name);
	}

	return sprintf('\x{%04x}', $ord);
}

sub _ws
{
	return $_[0] unless $Whitespace;
	
	given ($_[0])
	{
		when ("\r\n")  { return "\\r\\n\n" }
		when ("\n")    { return "\\n\n" }
		when ("\r")    { return "\\r\n" }
		when ("\t")    { return "\\t" }
	}
}

*unidebug = \&unidecode;

require PerlIO::via::UnicodeDebug;

__PACKAGE__
__END__

=encoding utf8

=head1 NAME

Unicode::Debug - debug Unicode strings

=head1 SYNOPSIS

 use 5.010;
 use Unicode::Debug;
 
 say unidebug("Héllò Wörld");

=head1 DESCRIPTION

Makes non-ASCII/non-printable characters in a string blindingly obvious.

=head2 Functions

=head3 unidebug

This function replaces "unusual" characters in strings with a Perl escape
sequence that will have the same effect. The example in the SYNOPSIS
outputs this:

 H\x{00e9}ll\x{00f2} W\x{00f6}rld

Which characters are considered unusual? Everything outside the range
\x20 to \x7F. (The \t, \r and \n characters are handled separately.)

To ensure that unidebug is reversible, backslashes in the input are
doubled in the output.

Called in void context, it modifies the strings passed to it in-place.
For example, the following will output the same as the previous example.

  my @strings = ("Héllò", "Wörld");
  unidebug(@strings);
  say(join " ", @strings);
  
Called in list context, it returns modified versions of the strings
passed to it. Another example:

  my @strings = unidebug("Héllò", "Wörld");
  say(join " ", @strings);

Called in scalar context, it acts the same as in list context, but
only returns the first modified string.

=head3 unidecode

An alias for C<unidebug>, to use as a drop-in replacement for
L<Text::Unidecode>.

=head2 Package Variables

OK, so global variables are perhaps not the best way to configure
things, but we have C<local> so quit complaining.

=head3 C<< $Unicode::Debug::Whitespace >>

If set to true, debugs "\r", "\n" and "\t" as well. They are substituted
as follows:

 "\r\n"    => "\\r\\n\n"
 "\r"      => "\\r\n"
 "\n"      => "\\n\n"
 "\t"      => "\\t"

When false, these whitespace characters are passed through unchanged.
False by default.

=head3 C<< $Unicode::Debug::Names >>

If set to true, will use L<charnames> to show character names for
substituted characters. "Wörld" becomes:

 W\N{LATIN SMALL LETTER O WITH DIAERESIS}rld

False by default.

=head1 BUGS

Please report any bugs to
L<http://rt.cpan.org/Dist/Display.html?Queue=Unicode-Debug>.

=head1 SEE ALSO

L<PerlIO::via::UnicodeDebug>,
L<Devel::Unicode>.

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

