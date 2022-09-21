#!/bin/perl

use open qw(:utf8);
binmode STDOUT,':utf8';

$\ = "\n";
my $inFile = "file1";
my $inText = "";
my $fileOpenError = "file open error";
my $fh;

open $fh, '<', $inFile || die $fileOpenError;
while (my $line = <$fh>)
{
    $inText .= $line;
}
close $fh;

my @letters = split //, $inText;

my $lines = 0;
my $words = 0;
my $chars = 0;

my $isWorldEnd = 0;

foreach my $letter (@letters)
{
    $chars++;

    if ($letter eq "\n")
    {
        $lines++;
    }

    if ($letter =~ m/\s/)
    {
        if ($isWorldEnd != 0)
        {
            $words++
        }
        $isWorldEnd = 0;
    }
    else
    {
        $isWorldEnd = 1;
    }
}

print "Input file contains:";
print "$chars letters";
print "$words words";
print "$lines lines";