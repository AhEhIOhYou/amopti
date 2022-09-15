#!/usr/bin/perl
$\ = "\n";
my $text = "11+9:3+2";
print($text);

my @arr1 = split("\\+", $text);

my $result = (shift @arr1);
my $tmpRes = 0;
foreach my $tmpText (@arr1) {
    if (index($tmpText, ':') == 1) {
        my @numbers = split (":", $tmpText);
        $tmpRes = (shift @numbers) / (pop @numbers);
    }
}
$result = $result + $tmpRes + (pop @arr1);

print("Result: " . $result);
