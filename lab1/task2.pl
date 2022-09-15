#!/usr/bin/perl
$\ = "\n";
my $text = "12+22+31+44+87+7";
print($text);

my @arr = split ("\\+", $text);
my $sum = 0;
foreach $number (@arr)
{
    $sum += $number;
}
print("Sum: " . $sum);
