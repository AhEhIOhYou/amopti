#!/bin/perl

use open qw(:utf8);
binmode(STDOUT,':utf8');
$\ = "\n";
my $inFile = "file1";
my $outFile = "result_file7";
my $inText = "";
my $outText = "";
my $fileOpenError = "file open error";
my $fh;

open $fh, '<', $inFile || die $fileOpenError;
while (my $line = <$fh>)
{
    $inText .= $line;
}
close $fh;

my @words = $inText =~ m/\w+/g;

for my $i (0 .. $#words)
{
    $outText .= $i + 1 . ". " . @words[$i] . "\n";
}

print "Done!";

open $fh, '>', $outFile || die $fileOpenError;
print $fh $outText;
close $fh;