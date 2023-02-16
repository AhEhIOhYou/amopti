#!/bin/perl

# 4. В файле записаны числа, отделенные друг от друга символом табуляции по строкам, отделенными символом '\n'. Запишите построчные суммы чисел в отдельный файл.

$\ = "\n";
my $inFile = "file4";
my $outFile = "result_file4";
my $outText = "";
my $fh;

open $fh, '<', $inFile || die "error";
while (my $str = <$fh>)
{
    # разбиваю строку по пробелам, чтоб заполнить массив чисел
    my @numbers = split /\s+/, $str;
    # сумма на линии
    my $lineSum = 0;
    # перебираю числа и считаю их сумму, вношу в выходную строку
    foreach my $number (@numbers)
    {
        $lineSum += $number;
    }
    $outText .= "$lineSum\n";
}
close $fh;

print "Done!";

open $fh, '>', $outFile || die "error";
print $fh $outText;
close $fh;