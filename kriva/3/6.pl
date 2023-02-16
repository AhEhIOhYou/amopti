#!/bin/perl

# 6.(статистика по файлу) Дан файл. Определите сколько в нем букв, слов, строк. Выведите три найденных числа в формате, приведенном в примере.
#
#     Input file contains:
# 108 letters
#     20 words
#     4 lines

use open qw(:utf8);
binmode STDOUT,':utf8';

$\ = "\n";
my $inFile = "file1";
my $inText = "";
my $fh;

open $fh, '<', $inFile || die "error";
while (my $line = <$fh>)
{
    $inText .= $line;
}
close $fh;

# разбил текст на символы
my @letters = split //, $inText;

my $lines = 0;
my $words = 0;
my $chars = 0;

# пробелов может быть много, это для контроля
my $isWorldEnd = 0;

# перебираю символы
foreach my $letter (@letters)
{
    # + символ
    $chars++;

    # если смвол это перевод строки , то + строка
    if ($letter eq "\n")
    {
        $lines++;
    }

    # =~ m это есть ли вхождение по регулярке
    # если символ - пробел, то
    if ($letter =~ m/\s/)
    {
        # может быть конец слова?
        # если пробел после конца слова, то + слово
        if ($isWorldEnd != 0)
        {
            $words++
        }
        # нет, это очередной пробел
        $isWorldEnd = 0;
    }
    # да, конец слова может быть дальше
    else
    {
        $isWorldEnd = 1;
    }
}

print "Input file contains:";
print "$chars letters";
print "$words words";
print "$lines lines";