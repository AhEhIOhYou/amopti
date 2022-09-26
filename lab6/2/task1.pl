#!/bin/perl

use Data::Dumper qw(Dumper);

$\ = "\n";
my $inFile = "text1.txt";
my $inText = "";
my $fileOpenError = "file open error";
my $fh;

open $fh, '<', $inFile || die $fileOpenError;
while (my $str = <$fh>)
{
    $inText .= $str;
}
close $fh;

print $inText;

print "Sentence count: " . scalar(@arrSentence = $inText =~ m/[\s\S]*?[\.!?] /g);
