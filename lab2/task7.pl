#!/bin/perl

my $inFile = "file1";
my $outFile = "result_file7";
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

my @words = $inText =~ m/\w+/g;

for my $i (1 .. $#words)
{
    $outText .= $i . ". " . @words[$i] . "\n";
}

open($fh, '>', $outFile) || die ($fileOpenError);
print($fh $outText);
close($fh);