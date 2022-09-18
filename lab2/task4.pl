#!/bin/perl

my $inFile = "file4";
my $outFile = "result_file4";
my $inText = "";
my $outText = "";
my $fileOpenError = "file open error";
my $fh;

open($fh, '<', $inFile) || die ($fileOpenError);
while (my $line = <$fh>)
{
    $inText .= $line;
}
close($fh);

my @numbersSrtings = split(/\n/, $inText);

foreach my $str (@numbersSrtings)
{
    my $sum = 0;
    my @numbers = split(/\s+/, $str);
    foreach my $number (@numbers)
    {
        $sum += $number;
    }
    $outText .= "$sum\n";
}

open($fh, '>', $outFile) || die ($fileOpenError);
print($fh $outText);
close($fh);