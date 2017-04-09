package VFS;
use utf8;
use strict;
use warnings;
use 5.010;
use File::Basename;
use File::Spec::Functions qw{catdir};
use JSON::XS;
no warnings 'experimental::smartmatch';
use Encode qw(decode encode);
use Digest::SHA1 qw(sha1 sha1_hex sha1_base64);

my $ind = 0;

sub mode2s {
    my $n = shift;
    my %h;
    my %h_o;
    if (($n & 1) == 1) {
        $h_o{'execute'} = JSON::XS::true;
    } else {
        $h_o{'execute'} = JSON::XS::false;
    }
    if (($n & 2) == 2) {
        $h_o{'write'} = JSON::XS::true;
    } else {
        $h_o{'write'} = JSON::XS::false;
    }
    if (($n & 4) == 4) {
        $h_o{'read'} = JSON::XS::true;
    } else {
        $h_o{'read'} = JSON::XS::false;
    }
    $h{'other'} = \%h_o;
    

    my %h_g;
    if (($n & 8) == 8) {
        $h_g{'execute'} = JSON::XS::true;
    } else {
        $h_g{'execute'} = JSON::XS::false;
    }
    if (($n & 16) == 16) {
        $h_g{'write'} = JSON::XS::true;
    } else {
        $h_g{'write'} = JSON::XS::false;
    }
    if (($n & 32) == 32) {
        $h_g{'read'} = JSON::XS::true;
    } else {
        $h_g{'read'} = JSON::XS::false;
    }
    $h{'group'} = \%h_g;


    my %h_u;
    if (($n & 64) == 64) {
        $h_u{'execute'} = JSON::XS::true;
    } else {
        $h_u{'execute'} = JSON::XS::false;
    }
    if (($n & 128) == 128) {
        $h_u{'write'} = JSON::XS::true;
    } else {
        $h_u{'write'} = JSON::XS::false;
    }
    if (($n & 256) == 256) {
        $h_u{'read'} = JSON::XS::true;
    } else {
        $h_u{'read'} = JSON::XS::false;
    }
    $h{'user'} = \%h_u;
    return \%h;
}

sub getnum {
    my $ans = 0;
    for my $var(@_) {
        $ans <<= 8;
        $ans += ord($var);
    }
    return $ans;
}

sub parse {
    my $buf = shift;
    my %h;
    
    return \%h if (substr($buf, 0, 1) eq 'Z');
    die "The blob should start from 'D' or 'Z'" if (substr($buf, $ind, 1) ne 'D');
    die "Garbage ae the end of the buffer" if (substr($buf, length($buf) - 1, 1) ne 'Z');
    $ind++;
    $h{'type'} = 'directory';
    my $len_name = getnum(substr($buf, $ind, 1), substr($buf, $ind + 1, 1));
    $ind += 2; 
    $h{'name'} = decode("UTF-8", substr($buf, $ind, $len_name));
    $ind += $len_name;
    my $mode = getnum(substr($buf, $ind, 1), substr($buf, $ind + 1, 1));
    $ind += 3;
    $h{'mode'} = mode2s($mode);
    my @a;
    while (substr($buf, $ind, 1) ne 'U') {
        if (substr($buf, $ind, 1) eq 'D') {
            push @a, parse($buf, $ind);
        } elsif (substr($buf, $ind, 1) eq 'F') {
            $ind++;
            my %hf;
            $hf{'type'} = 'file';
            my $len_name_f = getnum(substr($buf, $ind, 1), substr($buf, $ind + 1, 1));
            $ind += 2;
            $hf{'name'} = decode("UTF-8", substr($buf, $ind, $len_name_f));
            $ind += $len_name_f;
            my $mode = getnum(substr($buf, $ind, 1), substr($buf, $ind + 1, 1));
            $ind += 2;
            $hf{'mode'} = mode2s($mode);
            my $size = getnum(substr($buf, $ind, 1), substr($buf, $ind + 1, 1), substr($buf, $ind + 2, 1), substr($buf, $ind + 3, 1));
            $ind += 4;
            $hf{'size'} = $size;
            $hf{'hash'} = sha1(substr($buf, $ind, 20));
            $ind += 20;
            push @a, \%hf;
        }
    }
    $ind++;
    $h{'list'} = \@a;
    return \%h;
}

1;
