#!/bin/perl

use Data::Dumper qw(Dumper);

$\ = "\n";
my $inFile = "file1";
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

my @dataBuyers = split "\n", $inText;

for my $i (0 .. $#dataBuyers)
{
    my @dataParts = split ", ", @dataBuyers[$i];

    foreach my $data (@dataParts)
    {
        my @KeyValue = split ":", $data;
        $resultHash{$i}{$KeyValue[0]} = $KeyValue[1];
    }
}

print Dumper \%resultHash;