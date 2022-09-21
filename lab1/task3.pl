#!/usr/bin/perl
$\ = "\n";
my $text = "11+9:3+2";
print($text);

my @arr1 = split("\\+", $text);

my $tmpRes = 0;
foreach my $tmpText (@arr1) {
    if (index($tmpText, ':') == 1) {
        my @numbers = split (":", $tmpText);
        $tmpRes = (shift @numbers) / (pop @numbers);
    } else {
        $result += $tmpText;
    }
}

$result = $result + $tmpRes;

print("Result: " . $result);
