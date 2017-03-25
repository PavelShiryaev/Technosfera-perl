package Local::Row::JSON; {
use strict;
use warnings;
use parent 'Local::Row';
use JSON::XS;

=encoding utf8
=head1 NAME
Local::Row:JSON
=head1 VERSION
Version 1.00
=cut

our $VERSION = '1.00';

=head1 SYNOPSIS
=cut
    sub parse {
        my $self = shift;
        my $str = shift;
        return JSON::XS->new->utf8->decode($str);}
    }

1;
