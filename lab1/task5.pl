#!/usr/bin/perl
$\ = "\n";
my $text = "Herrscher of Sentience";
print($text);

print(join ("_", split('', $text)));