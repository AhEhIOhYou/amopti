#!/usr/bin/perl

# В каждой строке заданного файла записаны полные пути к файлам в формате диск:\каталог1\каталог2\...\каталогN\файл. 
# С помощью регулярных выражений составить хеш массивов. Ключи хеша -- полные пути к каталогам, значения -- списки имен 
# файлов соответствующего каталога.

use Data::Dumper qw(Dumper);
use utf8;
use open qw/:std :utf8/;
$\ = "\n";

my $fileOpenError = "file open error";
my $fh;
my $fileName = "text3.txt";

my %resultHash;

open $fh, '<', $fileName || die $fileOpenError;
while (my $str = <$fh>)
{
	my @words = grep /\S/, $str =~ m/(\w:)|([\w\d]*\.?\w+)/g;

	my $key = (join '\\', splice @words, 0, $#words) . '\\';
	my $value = $words[$#words];

	if (!exists $resultHash{$key}) {
		$resultHash{$key} = [$value];
	}
	else {
		push @{$resultHash{$key}}, $value;
	}
}
close $fh;


my @keys = keys(%resultHash);
foreach my $key (@keys)
{
    print "KEY: $key";
	print "VALUES: ". (join ', ', splice @{$resultHash{$key}}) . "\n";
}