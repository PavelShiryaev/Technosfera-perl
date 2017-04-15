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
        my $next_elem = $self->{source}->next();

        my $ncl = $self->{row_class}->new(str => $next_elem);
        
        return if (!$ncl);
        my $top = $ncl->get($self->{top});
        my $bottom = $ncl->get($self->{bottom});
        return if (!$bottom || $bottom =~ /[^0-9]/ || !$top || $top =~ /[^0-9]/);
        my $dif = abs($bottom - $top);
        $self->{result} = $dif if ($dif > $self->{result});
    }  
    
}

1;

