package MouseX::Types::DateTime;

use strict;
use warnings;
use 5.8.1;
use DateTime ();
use DateTime::Duration ();
use DateTime::TimeZone ();
use DateTime::Locale ();
use DateTime::Locale::root ();
use DateTimeX::Easy ();
use Time::Duration::Parse qw(parse_duration);
use Scalar::Util qw(looks_like_number);
use Mouse::TypeRegistry;
use MouseX::Types::Mouse qw(Str HashRef);
use namespace::clean;

use MouseX::Types
    -declare => [qw(DateTime Duration TimeZone Locale)]; # export Types
require Mouse; # for Mouse::TypeRegistry (Mouse::load_class)

our $VERSION = '0.01';

class_type 'DateTime'           => { class => 'DateTime' };
class_type 'DateTime::Duration' => { class => 'DateTime::Duration' };
class_type 'DateTime::TimeZone' => { class => 'DateTime::TimeZone' };
class_type 'DateTime::Locale'   => { class => 'DateTime::Locale::root' };

subtype DateTime, as 'DateTime';
subtype Duration, as 'DateTime::Duration';
subtype TimeZone, as 'DateTime::TimeZone';
subtype Locale,   as 'DateTime::Locale';

for my $type ( 'DateTime', DateTime ) {
    coerce $type,
        from Str, via {
            looks_like_number($_)
                ? 'DateTime'->from_epoch(epoch => $_)
                : DateTimeX::Easy->new($_);
        },
        from HashRef, via { 'DateTime'->new(%$_) };
}

for my $type ( 'DateTime::Duration', Duration ) {
    coerce $type,
        from Str, via {
            DateTime::Duration->new(
                seconds => looks_like_number($_) ? $_ : parse_duration($_)
            );
        },
        from HashRef, via { DateTime::Duration->new(%$_) };
}

for my $type ( 'DateTime::TimeZone', TimeZone ) {
    coerce $type,
        from Str, via { DateTime::TimeZone->new(name => $_) };
}

for my $type ( 'DateTime::Locale', Locale ) {
    coerce $type,
        from Str, via { DateTime::Locale->load($_) };
}

1;

=head1 NAME

MouseX::Types::DateTime - A DateTime type library for Mouse

=head1 SYNOPSIS

    package MyApp;
    use Mouse;
    use MouseX::Types::DateTime;

=head1 DESCRIPTION

MouseX::Types::DateTime is

=head1 AUTHOR

NAKAGAWA Masaki E<lt>masaki@cpan.orgE<gt>

=head1 THANKS TO

Yuval Kogman, John Napiorkowski, L<MooseX::Types::DateTime/AUTHOR>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Mouse>, L<Mouse::TypeRegistry>,

L<DateTime>, L<DateTimeX::Easy>,

L<MooseX::Types::DateTime>, L<MooseX::Types::DateTimeX>

=cut
