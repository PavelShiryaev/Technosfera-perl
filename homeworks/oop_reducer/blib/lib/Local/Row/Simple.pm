package Local::Row::Simple; {
use strict;
use warnings;
use parent 'Local::Row';

=encoding utf8
=head1 NAME
Local::Row:Simple
=head1 VERSION
Version 1.00
=cut

our $VERSION = '1.00';

=head1 SYNOPSIS
=cut
    sub parse {
        my $self = shift;
        my $str = shift;
        my %struct;
        for (split ',', $str) {
            my $k = 0;
            for my $i (0..length($_) - 1) {
                $k++ if (substr($_, $i, 1) eq ':');
            }
            return undef if ($k != 1);
            if (/^\s*(\w+)\s*:\s*(.*)\s*$/) {
                $struct{$1} = $2;
            } else {
                return undef;
            }
        }
        return \%struct;
    }
}

1;
