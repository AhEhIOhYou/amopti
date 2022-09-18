#!/bin/perl

$\ = "\n";
my $inFile = "file1";
my $inText = "";
my $fileOpenError = "file open error";
my $fh;

open($fh, '<', $inFile) || die ($fileOpenError);
while (my $line = <$fh>)
{
    $inText .= $line;
}
close($fh);

my $letc = () = ($inText =~ /\w/g);
my $wc = () = ($inText =~ /\w+/g);
my $lc = () = ($inText =~ m/(^.+(?=\n?)|(?<=\n).+)/g);

print "Input file contains:";

print "$letc letters";
print "$wc words";
print "$lc lines";
