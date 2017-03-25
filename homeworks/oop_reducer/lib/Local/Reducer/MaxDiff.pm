package Local::Reducer::MaxDiff; {
use strict;
use warnings;
use parent 'Local::Reducer';

=encoding utf8
=head1 NAME
Local::Reducer::MaxDiff
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
        my $val = $self->{row_class}->new(str => $next_elem);
        my $top = $row->get($self->{top});
	my $bottom = $row->get($self->{bottom});
        return undef if ($top == undef || $bottom == undef);
        my $dif = abs($bottom - $top);
        $self->{result} = $dif if ($dif > $self->{result});
        return $self->{result};
    }
}

1;

