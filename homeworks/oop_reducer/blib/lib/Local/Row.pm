package Local::Row; {
use strict;
use warnings;

=encoding utf8
=head1 NAME
Local::Row
=head1 VERSION
Version 1.00
=cut

our $VERSION = '1.00';

=head1 SYNOPSIS
=cut
    sub new {
        my ($class, %params) = @_;
        my $r = $class->parse($params{str});
        return undef if (ref $r ne 'HASH');
        return bless $r, $class;
    }

    sub get {
        my ($self, $name, $default) = @_;
        return $default if (!$self->{$name});
        return $self->{$name};
    }
}

1;
