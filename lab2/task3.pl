#!/bin/perl

$" = "\n";
my $inFile = "file3";
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

my @paragraphs = split /\n\s{4}/, $inText;
my @resParagraphs;

for my $i (2 .. $#paragraphs)
{
    if ($i % 2 == 0)
    {
        push(@resParagraphs, (@paragraphs[$i]));
    }
}

print "@resParagraphs";
print "\n";