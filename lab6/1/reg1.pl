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

print "\nTask 1";
for my $str (@strings) {
    if ((@m = $str =~ /cat/g) == 2)
    {
        print $str;
    }
}

print "\nTask 2";
for my $str (@strings) {
    if ($str =~ /z.{3}z/)
    {
        print $str;
    }
}

print "\nTask 3";
for my $str (@strings) {
    if ($str =~ /[xyz].{5,17}[xyz]/)
    {
        print $str;
    }
}

print "\nTask 4";
for my $str (@strings) {
    if ($str =~ /[0-9]/)
    {
        print $str;
    }
}

print "\nTask 5";
for my $str (@strings) {
    if ($str =~ /\\/)
    {
        print $str;
    }
}

print "\nTask 6";
for my $str (@strings) {
    if ($str =~ /\(\w+\)/)
    {
        print $str;
    }
}

print "\nTask 7";
for my $str (@strings) {
    # if ($str !~ /^\s|\s$/)
    {
        print $str;
    }
}

print "\nTask 8";
for my $str (@strings) {
    if ($str !~ /^\s|\s$/)
    {
        print $str;
    }
}
