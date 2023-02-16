#!/bin/perl


# 1. Прочитать из файла слова и записать в другой файл только те из них,
#     которые заканчиваются буквой 'в' в любом регистре.

# кодировка для вывода в консоль
use open qw(:utf8);
binmode STDOUT,':utf8';

$\ = "\n";
# файл с данными
my $inFile = "file1";
# файл для вывода
my $outFile = "result_file1";
# вывод
my $outText = "";
# для чтения строк
my $fh;
# буква "в" нужной кодировке
my $flagLetter = chr(1074);

# открываем чтение файла
open $fh, '<', $inFile || die "error";
while (my $line = <$fh>)
{
    # line - строка из файла, делим по пробелам на слова и заносим в массив words
    my @words = split /\s/, $line;
    # перебираем слова
    foreach my $word (@words)
    {
        # вытягиваем букву из слова с позиции 0, количество 1 (берем одну первую букву)
        my $firstLetter = substr $word, 0, 1;
        # eq - как ==, только для строк и букв
        if ($firstLetter eq $flagLetter)
        {
            # .= конкатенует стркоу в конец строки, чтоб сделать одну строку со всеми вхождениями
            $outText .= $word . "\n";
        }
    }
}
# закрываем чтение файла
close $fh;

print "Done!";
# записывам строку в другой файл
open $fh, '>', $outFile || die "error";
# да принт запишет в файл, fh тут уже для 2 файла
print $fh $outText;
close $fh;