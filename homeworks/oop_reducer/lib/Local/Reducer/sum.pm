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
        my $next_elem;
        if ($self->{source}->next() == undef) {
            return undef;
        } else {
            $next_elem = $self->{source}->next();
        }
        my $val = $self->{row_class}->new(str => $next_elem)->get($self->{field});
        return undef if ($val == undef);
        $self->{result} += $val;
        return $self->{result};
    }
}

1;
