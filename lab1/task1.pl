#!/usr/bin/perl
$\ = "\n";
my $text = "1. Первое предложение
2. Второе предложение
3. Третье предложение
4. Четвертое предложение
";
print($text);

my @arr = split ("\n", $text);
$\ = "%";
foreach $sentence (@arr)
{
    print ($sentence);
}