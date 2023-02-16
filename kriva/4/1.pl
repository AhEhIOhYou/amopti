#!/bin/perl

# 1. Данные о покупателе записаны в виде строки вида "name:Имя Отчество Фамилия, email:name@mail.su, age:27".
#     Напишите программу, которая построит из этой строки соответствующий хеш.

# это либа с функциями для красивой печати массивов и хэшей чисто для дебага
use Data::Dumper qw(Dumper);

$\ = "\n";
my $inFile = "file1";
my $fh;
my %resultHash;
my $index = 0;

open $fh, '<', $inFile || die "error";
while (my $str = <$fh>)
{
    # делю строку по ", " получу [], где 1 элемент - "name:Aaaaa Bbbbb Cccccc", 2 элемент - "email:test@test.ru", 3 элемент - "age:20"
    my @dataParts = split ", ", $str;

    # перебираю эти элементы-строки
    foreach my $data (@dataParts)
    {
        # делю их по ":"
        # получим например [] 1 эл - email, 2 эл - test@test.ru
        my @KeyValue = split ":", $data;
        # хэш это штука с элементами вида 'ключ' = 'значение', где значением может быть другой хэш, массив, строка или число
        # просто выполни эту прогу и увидишь структуру хэша
        # ключами хэша будет глобальный индекс, начинаем с 0, значением - хэш с тремя полями
        # $KeyValue[0] - ключ, там будет name, email или age
        # $KeyValue[1] - значение, ну понятно че там
        $resultHash{$index}{$KeyValue[0]} = $KeyValue[1];
    }
    $index++;
}
close $fh;

print Dumper \%resultHash;