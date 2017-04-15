package Local::Source::Text; {
use strict;
use warnings;
use parent 'Local::Source';

=encoding utf8
=head1 NAME
Local::Source::Text
=head1 VERSION
Version 1.00
=cut

our $VERSION = '1.00';

=head1 SYNOPSIS
=cut
    sub new {
        my ($class, %params) = @_;
        my $delimiter = $params{delimiter} ? $params{delimiter} : "\n";
        my %h;
        $h{cnt} = 0;
        $h{array} = [split $delimiter, $params{text}];
        my $a = $h{array};
        my @a = @$a;
        $h{n} = scalar @a;
        return bless \%h, $class;
    }

    sub next {
        my ($self) = @_;
        $self->{cnt}++;
        return $self->{array}[$self->{cnt} - 1];
    }
}

1;
