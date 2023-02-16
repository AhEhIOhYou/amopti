#!/bin/perl

# 3. Для  заданного текстового файла построить ассоциативный массив,
#     ключами которого будут числа, а значениями количество  слов из файла
#         количество букв в которых равно ключу хеша.

use open qw(:utf8);
binmode STDOUT,':utf8';
use Data::Dumper qw(Dumper);

$\ = "\n";
my $inFile = "file3.txt";
my $fh;
my %resultHash;

# аналогичное предыдущей проге строим массив по ключам, если есть - делаем с существуещим что-то, если нет ключа, создаем
open $fh, '<', $inFile || die "error";
while (my $str = <$fh>)
{
    my @words = $str =~ m/\w+/g;
    foreach my $word (@words)
    {
        # понятно что это для слова
        my $wlength = length($word);

        # если нет ключа с такой длиной
        if (!defined($resultHash{$wlength}))
        {
            # создаем ключ и +1 слово (это)
            $resultHash{$wlength} = 1;
        }
        # по существующему ключу +1 слово
        else
        {
            $resultHash{$wlength}++;
        }
    }
}
close $fh;

# print Dumper \%resultHash;

my @keys = keys(%resultHash);

foreach my $key (@keys)
{
    print "$key: $resultHash{$key}";
}
