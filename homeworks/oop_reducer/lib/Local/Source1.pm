package Local::Source; {
use strict;
use warnings;

=encoding utf8
=head1 NAME
Local::Source
=head1 VERSION
Version 1.00
=cut

our $VERSION = '1.00';

=head1 SYNOPSIS
=cut
    sub new {
        my ($class, %params) = @_;
        $params{cnt} = 0;
        return bless \%params, $class;
    }
}

1;
