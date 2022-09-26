#!/bin/perl

use Data::Dumper qw(Dumper);

my $inFile = "text2.txt";
my $inText = "";
my $fileOpenError = "file open error";
my $fh;

open $fh, '<', $inFile || die $fileOpenError;
while (my $str = <$fh>)
{
    $inText .= $str;
}
close $fh;


# ^(  [1]?[\d]?[\d]  |  [2][0-4][\d]  |  [2][5][0-6]  )$

my @arrDigits = $inText =~ m/\d+/g;

my @filteredNumbers = grep /^([1]?[\d]?[\d]|[2][0-4][\d]|[2][5][0-6])$/, @arrDigits;

my $sum = 0;

print "[";
foreach my $digit (@filteredNumbers)
{
    print " ". $digit;
    $sum += $digit;
}
print " ] = " . $sum . "\n";