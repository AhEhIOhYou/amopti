#!/bin/perl

# 5. Найти в файле все слова, состоящие из не более 5 букв. Вывести их в файл и на экран.

use open qw(:utf8);
binmode STDOUT,':utf8';

my $inFile = "file1";
my $outFile = "result_file5";
my $outText = "";
my $fh;

open $fh, '<', $inFile || die "error";
while (my $line = <$fh>)
{
    # каждую строку разбиваю по пробелам на массив слова
    my @words = split /\s+/, $line;
    # перебираю слова строки
    foreach my $word (@words)
    {
        # чекаю длину
        if (length($word) <= 5)
        {
            $outText .= "$word\n";
        }
    }
}
close $fh;

print $outText;

open $fh, '>', $outFile || die "error";
print $fh $outText;
close $fh;