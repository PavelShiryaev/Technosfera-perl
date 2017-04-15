package Local::Reducer; {
use strict;
use warnings;

=encoding utf8
=head1 NAME
Local::Reducer - base abstract reducer
=head1 VERSION
Version 1.00
=cut

our $VERSION = '1.00';

=head1 SYNOPSIS
=cut
    sub new {
        my ($class, %params) = @_;
        $params{result} = $params{initial_value};
        return bless \%params, $class;
    }

    sub reduce_n {
        my ($self, $n) = @_;
        for (my $i = 0; $i < $n; $i++) {
            $self->reduce();
        }
        return $self->reduced();
    }

    sub reduced {
        my $self = shift;
        return $self->{result};
    }

    sub reduce_all {
        my ($self) = @_;
        while ($self->{source}->{cnt} < $self->{source}->{n}) {
            $self->reduce()
        }
        return $self->reduced();
    }
}

1;
