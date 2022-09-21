#!/usr/bin/perl

use Data::Dumper qw(Dumper);
use strict;
use Auto;
use Parking;

my $fileOpenError = "file open error";
my $fh;

my $fileName = "auto.txt";
my $records = ();
my $parking = ();
sub GetFromFile {
    my $inText = "";
    my @arrRecords = ();

    open $fh, '<', $fileName || die $fileOpenError;
    while (my $str = <$fh>)
    {
        $inText .= $str;
    }
    close $fh;

    my @arrData = split /\n/, $inText;

    for my $i (0 .. $#arrData)
    {
        my @dataParts = split /\s/, @arrData[$i];

        for my $j (0 .. $#dataParts)
        {
            $arrRecords[$i][$j] = $dataParts[$j];
        }
    }
    $records = \@arrRecords;
}
sub LoadObjects {
    foreach my $arrRecord (@{$records})
    {
        my $cl = Auto->new(
            ${$arrRecord}[0],
            ${$arrRecord}[1],
            ${$arrRecord}[2],
            ${$arrRecord}[3],
        );
        push(@$parking, $cl);
    }
}

GetFromFile;
LoadObjects;

print Dumper $parking;