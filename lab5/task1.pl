#!/usr/bin/perl

# /usr/local/share/perl/5.34.0
use lib '/home/ahehiohyou/Desktop/work/4course/perl/lab5';

$\ = "\n";

use Data::Dumper qw(Dumper);
use strict;
use Auto;
use Parking;

my $fileOpenError = "file open error";
my $fh;

my $fileName = "auto.txt";
my $records = ();
my $parking = Parking->new();
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
        $parking->AddCar($cl);
    }
}
sub PrintAllData {
    print "+" . "-"x55 . "+";
    print "|No\t" . Parking::ToStringLabels() . "\t|";
    while (my ($i, $car) = each(@{$parking->GetAllCars}))
    {
        print "|" . $i  ."\t" . Auto::ToString($car) . "\t\t|";
    }
    print "+" . "-"x55 . "+";
}
sub PrintData {
    my $cars = shift;

    print "+" . "-"x55 . "+";
    print "|No\t" . Parking::ToStringLabels() . "\t|";
    while (my ($i, $car) = each(@{$cars}))
    {
        print "|" . $i  ."\t" . Auto::ToString($car) . "\t\t|";
    }
    print "+" . "-"x55 . "+";
}
sub SearchByOwner {
    print "Search by owner: ";
    my $searchText = <>;
    chomp $searchText;

    my $res = $parking->SearchByOwner($searchText);

    print "Result:";
    if (!defined $res)
    {
        print "Nothing found!";
        return;
    }

    PrintData($res);
}

GetFromFile;
LoadObjects;
PrintAllData;
SearchByOwner;