#!/bin/perl

# 7. Переписать слова из файла в другой файл, нумеруя их.

use open qw(:utf8);
binmode(STDOUT,':utf8');
$\ = "\n";
my $inFile = "file1";
my $outFile = "result_file7";
my $outText = "";
my $fh;
my $index = 0;

open $fh, '<', $inFile || die "error";
while (my $line = <$fh>)
{
    # строку на массив слов
    my @words = split /\s+/, $line;
    # каждое слово в вывод
    for my $i (0 .. $#words)
    {
        # индекс точка слово
        $outText .= $index . ". " . @words[$i] . "\n";
        # увеличиваю глобальный индекс, чтоб в след строке из файла продолжить с него
        $index++;
    }
}
close $fh;

print "Done!";

open $fh, '>', $outFile || die "error";
print $fh $outText;
close $fh;