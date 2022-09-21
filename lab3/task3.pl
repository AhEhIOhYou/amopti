#!/bin/perl

use open qw(:utf8);
binmode STDOUT,':utf8';
use Data::Dumper qw(Dumper);

$\ = "\n";
my $inFile = "file3.txt";
my $inText = "";
my $fileOpenError = "file open error";
my $fh;
my %resultHash;

open $fh, '<', $inFile || die $fileOpenError;
while (my $str = <$fh>)
{
    $inText .= $str;
}
close $fh;

my @words = $inText =~ m/\w+/g;

foreach my $word (@words)
{
    my $wlength = length $word;

    if (!defined($resultHash{$wlength}))
    {
        $resultHash{$wlength} = 1;
    }
    else
    {
        $resultHash{$wlength}++;
    }
}

# print Dumper \%resultHash;

my @keys = keys(%resultHash);

foreach my $key (@keys)
{
    print "$key: $resultHash{$key}";
}