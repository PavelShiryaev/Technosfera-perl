package Local::Source::Array; {
use strict;
use warnings;
use parent 'Local::Source';

=encoding utf8
=head1 NAME
Local::Source::Array
=head1 VERSION
Version 1.00
=cut

our $VERSION = '1.00';

=head1 SYNOPSIS
=cut
    sub next {
        my ($self) = @_;
        $self->{cnt}++; 
        return $self->{array}->[$self->{cnt} - 1];
    }
}

1;
