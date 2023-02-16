#!/usr/bin/perl

# 3. Строка имеет вид "число+число:число+число". Вычислить соответствующее значение выражения.

$\ = "\n";
my $text = "11+9:3+2";
print($text);

# разбил на [11,9:3,2]
my @arr1 = split("\\+", $text);
my $tmpRes = 0;

foreach my $tmpText (@arr1) {
    # если в элементе есть : на 1 поз, то это - 9:3, считаю их деление
    if (index($tmpText, ':') == 1) {
        my @numbers = split (":", $tmpText);
        $tmpRes = (shift @numbers) / (pop @numbers);
    } else {
        # иначе считаю сумму
        $result += $tmpText;
    }
}

# сумма чисел + рез деления
$result = $result + $tmpRes;

print("Result: " . $result);
