#!/bin/perl

my $inFile = "file1";
my $outFile = "result_file5";
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

my @words = split(/\s+/, $inText);

foreach my $word (@words)
{
    if (length($word) <= 5)
    {
        $outText .= "$word\n";
    }
}

print($outText);

open($fh, '>', $outFile) || die ($fileOpenError);
print($fh $outText);
close($fh);