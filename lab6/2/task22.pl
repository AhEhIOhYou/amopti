#!/usr/bin/perl

# Выбрать слова из текста, содержащие только звонкие согласные. 

use Data::Dumper qw(Dumper);
use utf8;
use open qw/:std :utf8/;
$\ = "\n";

my $text = "Как найти слова с де-фисом а, да все-таки баа. Ха-ха можно, как-будто нельзя!";
my @words = $text =~ m/[а-яА-Я]+[-]?[а-яА-Я]*/g;

my $count;
my @result;

for my $word (@words) {
	$tmp_word = $word;
	$count = ($word =~ m/[пфктшсхцчщПФКТШСХЦЧЩ]/);
	if (!$count) {
		push @result, $tmp_word;
	}
}

print "words: ". (join ', ', splice @result);

# ауоыэяюёиебвгджзлмнрйАУОЫЭЯЮЁИЕБВГДЖЗЛМНРЙ