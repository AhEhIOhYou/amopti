#!/bin/perl

use open qw(:utf8);
binmode STDOUT,':utf8';

$\ = "\n";
my $inFile = "file1";
my $outFile = "result_file1";
my $inText = "";
my $outText = "";
my $fileOpenError = "file open error";
my $fh;
my $flagLetter = chr(1074);

open $fh, '<', $inFile || die $fileOpenError;
while (my $line = <$fh>)
{
    $inText .= $line;
}
close $fh;

my @words = split /\s/, $inText;

foreach my $word (@words)
{
    my $firstLetter = substr $word, 0, 1;
    if ($firstLetter eq $flagLetter)
    {
        $outText .= $word . "\n";
    }
}

print "Done!";

open $fh, '>', $outFile || die $fileOpenError;
print $fh $outText;
close $fh;