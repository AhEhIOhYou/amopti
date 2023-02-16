#!/bin/perl

# 2. Вывести в файл таблицу умножения чисел от 1 до 9 в виде:
#
# 1	2	3	4	...9
# 2	4	6	8	...18
#     ...
# 9	18			...81

$\ = "\n";
my $outFile = "result_file2";
my $outText = "";
my $fh;

# $fNum - элемент текущий, перебираем все числа от 1 до 9
foreach my $fNum (1..9)
{
    # и ещё раз, для sNum (second num)
    foreach my $sNum (1..9)
    {
        # считаем их произведение и табуляцию в конец добавляем, вносим все в  строчку выходную
        $outText .= ($fNum * $sNum) . "\t\t";
    }
    # строка кончилась, дальше след цифра, докидываем перевод на новую строку в выходную
    $outText .= "\n";
}

print "Done!";

open $fh, '>', $outFile || die "error";
print $fh $outText;
close $fh;