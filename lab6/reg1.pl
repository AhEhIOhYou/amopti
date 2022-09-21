#!/bin/perl

$\ = "\n";
my $inFile = "text";
my $inText = "";
my $fileOpenError = "file open error";
my $fh;
my %resultHash;

open $fh, '<', $inFile || die $fileOpenError;
while (my $str = <$fh>)
{
    $inText .= $str;
}
close $fh;

my @strings = split "\n", $inText;

print "Task 1";
for my $str (@strings) {
    if ((@m = $str =~ /cat/g) == 2)
    {
        print $str;
    }
}

print "Task 2";
for my $str (@strings) {
    if ((@m = $str =~ /cat/g) == 2)
    {
        print $str;
    }
}
