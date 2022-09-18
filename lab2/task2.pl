#!/bin/perl
my $outFile = "result_file2";
my $outText = "";
my $fileOpenError = "file open error";
my $fh;

foreach my $fNum (1..9)
{
    foreach my $sNum (1..9)
    {
        $outText .= ($fNum * $sNum) . "\t\t";
    }
    $outText .= "\n";
}

open($fh, '>', $outFile) || die ($fileOpenError);
print($fh $outText);
close($fh);