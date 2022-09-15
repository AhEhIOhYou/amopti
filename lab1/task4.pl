#!/usr/bin/perl
$\ = "\n";
my $text = "Первое предложение Второе предложение Третье предложениеЧетвертое предложение";
print($text);

my @arr = split (" ", $text);
foreach $sentence (@arr)
{
    print ($sentence);
}