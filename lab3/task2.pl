#!/bin/perl

use open qw(:utf8);
binmode STDOUT,':utf8';

$\ = "\n";
my $inFile = "file2";
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

# my @words = split /\s+/, $inText;
my @words = $inText =~ m/\w+/g;


foreach my $word (@words)
{
    my $first = lc substr($word, 0, 1);

    if (!exists $resultHash{$first})
    {
        $resultHash{$first} = $word;
    }
    else
    {
        $resultHash{$first} .= " $word";
    }
}

my @keys = keys(%resultHash);

foreach my $key (@keys)
{
    print "$key: $resultHash{$key}";
}