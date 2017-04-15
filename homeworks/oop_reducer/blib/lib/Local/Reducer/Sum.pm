package Local::Reducer::Sum; {
use strict;
use warnings;
use parent 'Local::Reducer';

=encoding utf8
=head1 NAME
Local::Reducer::Sum
=head1 VERSION
Version 1.00
=cut

our $VERSION = '1.00';

=head1 SYNOPSIS
=cut
    sub reduce {
        my($self) = @_;
        my $next_elem = $self->{source}->next();
       
        
        my $ncl = $self->{row_class}->new(str => $next_elem);
        my $val;
        if (!defined $ncl) {
            $val = 0;
        } else {
            $val = $ncl->get($self->{field});
        }
        $val = 0 if (!$val || $val =~ /[^0-9]/);
        $self->{result} += $val;
    }
}

1;
