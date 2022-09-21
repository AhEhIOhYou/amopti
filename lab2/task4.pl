#!/bin/perl

$\ = "\n";
my $inFile = "file4";
my $outFile = "result_file4";
my $inText = "";
my $outText = "";
my $fileOpenError = "file open error";
my $fh;

open $fh, '<', $inFile || die $fileOpenError;
while (my $str = <$fh>)
{
    $inText .= $str;
}
close $fh;

my @numbersSrtings = split /\n/, $inText;

foreach my $str (@numbersSrtings)
{
    my $sum = 0;
    my @numbers = split /\s+/, $str;
    foreach my $number (@numbers)
    {
        $sum += $number;
    }
    $outText .= "$sum\n";
}

print "Done!";

open $fh, '>', $outFile || die $fileOpenError;
print $fh $outText;
close $fh;