#!/usr/bin/perl

use lib '/home/ahehiohyou/Desktop/work/4course/perl/lab5';

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
        my @dataParts = split /\s+/, @arrData[$i];

        for my $j (0 .. $#dataParts)
        {
            $arrRecords[$i][$j] = $dataParts[$j];
        }
    }
    $records = \@arrRecords;
}
sub SaveToFile {
    my @cars =  @{$parking->GetAllCars};
    open $fh, '>', $fileName || die $fileOpenError;
    foreach my $car (@cars)
    {
        print $fh Auto::ToString($car) . "\n";
    }
    close $fh;
    print "Successfully saved!\n";
}
sub LoadObjects {
    foreach my $arrRecord (@{$records})
    {
        my $cl = Auto->new($arrRecord);
        $parking->AddCar($cl);
    }
}
sub PrintAllData {
    my @cars =  @{$parking->GetAllCars};
    $\ = "\n";
    print "+" . "-"x55 . "+";
    print "|No\t" . Parking::ToStringLabels() . "\t|";
    while (my ($i, $car) = each(@cars))
    {
        print "|" . $i  ."\t" . Auto::ToString($car) . "\t\t|";
    }
    print "+" . "-"x55 . "+";
    $\ = "";
}
sub PrintData {
    $\ = "\n";
    my $cars = shift;
    print "+" . "-"x55 . "+";
    print "|No\t" . Parking::ToStringLabels() . "\t|";
    while (my ($i, $car) = each(@{$cars}))
    {
        print "|" . $i  ."\t" . Auto::ToString($car) . "\t\t|";
    }
    print "+" . "-"x55 . "+";
    $\ = "";
}
sub SearchByOwner {
    print "Search by owner: ";
    my $searchText = <>;
    chomp $searchText;

    my $res = $parking->SearchByOwner($searchText);

    print "Result:\n";
    if (!defined $res)
    {
        print "Nothing found!\n";
        return;
    }

    PrintData($res);
}
sub AddNewCar {
    my $newData;
    my @labels = Parking::ToArrLabels;

    while (my ($i, $heading) = each(@labels))
    {
        print $heading . ": ";
        my $inputValue = <>;
        chomp $inputValue;
        @{$newData}[$i] = $inputValue;
    }

    my $auto = Auto->new($newData);
    $parking->AddCar($auto);
    print "Added!\n"
}
sub AddDefaultCar {
    my $auto = Auto->new();
    $parking->AddCar($auto);
    print "Added!\n";
}
sub DeleteCarByStateNumber {
    print "State number: ";
    my $targetNumber = <>;
    chomp $targetNumber;

    my $res = $parking->DeleteCarByStateNumber($targetNumber);

    if ($res == 1)
    {
        print "\"$targetNumber\" successfully deleted\n";
        return;
    }

    print "Error, car with state number \"$targetNumber\" doesn't exist\n";
}
sub GetParkingInfo {
    my $present = $parking->GetCarsInTheParking;
    my $notPresent = $parking->GetCarsNotInTheParking;

    print "Parking info\n";
    print "In the parking:\n";
    PrintData($present);
    print "Not in the parking:\n";
    PrintData($notPresent);
}
sub ChangeParkingStatus {
    print "State number: ";
    my $targetNumber = <>;
    chomp $targetNumber;
    my $targetCar = $parking->GetCarByStateNumber($targetNumber);

    if (defined $targetCar)
    {
        $parking->ChangeParkingStatus($targetCar);
        print "Changed!\n";
        return;
    }
    print "Error car not found!\n";
}


GetFromFile;
LoadObjects;

my $options = "0 - print all data\n1 - print parking status\n2 - search by owner\n3 - add new car\n4 - add new default car\n5 - delete car by state number\n6 - change parking status\n7 - save to file\n8 - exit\nOption: ";
print $options;
while (<>) {
    my $cm = $_;
    chomp($cm);
    if ($cm == 0) {
        PrintAllData;
    }
    if ($cm == 1) {
        GetParkingInfo;
    }
    if ($cm == 2) {
        SearchByOwner;
    }
    if ($cm == 3) {
        AddNewCar;
    }
    if ($cm == 4) {
        AddDefaultCar;
    }
    if ($cm == 5) {
        DeleteCarByStateNumber;
    }
    if ($cm == 6) {
        ChangeParkingStatus
    }
    if ($cm == 7)
    {
        SaveToFile;
    }
    if ($cm == 8) {
        exit(100);
    }
    print $options;
}