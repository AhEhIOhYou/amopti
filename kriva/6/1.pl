#!/usr/bin/perl

# В рамках класса реализовать конструктор с параметрами и без параметров.
# Описать метод для получения состояния объекта.
# Исходные данные для массива объектов считываются из файла.
# Предусмотреть возможность добавления и удаления данных из массива объектов.
# (используйте для выполнения этого задания свои алгоритмы работы с табличными
# данными из предыдущего задания)

# Вариант 5. Описать класс "книга", содержащий следующие закрытые поля: автор, год
# издания, жанр.
# Предусмотреть свойства для получения состояния объекта.
# Описать класс "домашняя библиотека". Обеспечить следующие возможности:
# • вывод информации о книге по номеру с помощью индекса;
# • поиска книг по какому-либо признаку (по автору, по году издания или жанру),
# • перегруженную операцию сравнения, выполняющую сравнение книг по году издания
# Написать программу, демонстрирующую все разработанные элементы класса.

#
# Укажи путь к директории с .pm файлами
#
use lib '/home/ahehiohyou/Desktop/work/4course/perl/6/';

use Data::Dumper qw(Dumper);
use strict;

#
# Классы
#
use Book;
use Library;

my $fh;
my $fileName = "books.txt";

#
# Переменная, куда загружаются данные из файла
#
my $records = ();
#
# Объект главного класса
#
my $library = Library->new;

#
# Получает данные из файла и загружает в переменную
#
sub LoadDataFromFile {
	my $inText = "";
	my @arrRecords = ();

	open($fh, '<', $fileName || die "error");
	while (my $str = <$fh>)
	{
		$inText .= $str;
	}
	close($fh);

	my @arrData =(split /\n/, $inText);

	for my $i (0 .. $#arrData)
	{
		my @dataParts =(split /\s+/, @arrData[$i]);

		for my $j (0 .. $#dataParts)
		{
			$arrRecords[$i][$j] = $dataParts[$j];
		}
	}
	$records = \@arrRecords;
}
#
# Сохраняет состояние книг в библиотеке из переменной в файл
#
sub SaveToFile {
	my @books =  @{$library->GetBooks};
	open($fh, '>', $fileName || die "error");
	foreach my $book (@books)
	{
		print($fh Book::ToString($book) . "\n");
	}
	close($fh);
	print("Сохранено\n");
}
#
# Загружает данные с переменной в классы
#
sub LoadObjects {
	foreach my $arrRecord (@{$records})
	{
		my $newBook = Book->new($arrRecord);
		$library->AddBook($newBook);
	}
}
#
# Печатает весь массив книг в библиотеке
#
sub PrintAllData {
	my @books =  @{$library->GetBooks};
	$\ = "\n";
	print("+" . "-"x47 . "+");
	print("|No\t" . Library::ToStringLabels() . "\t|");
	while (my ($i, $book) = each(@books))
	{
		print("|" . $i  ."\t" . Book::ToString($book) . "\t|");
	}
	print("+" . "-"x47 . "+");
	$\ = "";
}
#
# Печатает массив переданных объектов типа книга
#
sub PrintData {
	$\ = "\n";
	my $books = shift;
	print("+" . "-"x47 . "+");
	print("|No\t" . Library::ToStringLabels() . "\t|");
	while (my ($i, $book) = each(@{$books}))
	{
		print("|" . $i  ."\t" . Book::ToString($book) . "\t|");
	}
	print("+" . "-"x47 . "+");
	$\ = "";
}
#
# Поиск по жанру
#
sub SearchByGenre {
	print("Найти по жанру: ");
	my $genre = <>;
	chomp($genre);

	my $result = $library->SearchByGenre($genre);

	print("Результат:\n");
	if (!defined($result))
	{
		print("Не найдено\n");
		return;
	}

	PrintData($result);
}
#
# Печатает информациб по индексу
#
sub PrintByIndex {
	print("Индекс: ");
	my $index = <>;
	chomp($index);

	my $result = $library->GetBookByIndex($index);

	print("Результат:\n");
	if (!defined($result))
	{
		print("Не найдено\n");
		return;
	}

	PrintData($result);
}
#
# Добавляет в библиотеку новую книгу
#
sub AddNewBook {
	my $newBookData;
	my @labels = Library::ToArrLabels;

	while (my ($i, $heading) = each(@labels))
	{
		print($heading . ": ");
		my $val = <>;
		chomp($val);
		@{$newBookData}[$i] = $val;
	}

	my $newBook = Book->new($newBookData);
	$library->AddBook($newBook);
	print("Успешно добавлено!\n");
}
#
# Добавляет в библиотеку книги с конструктором без параметров
#
sub AddDefaultBook {
	my $newBook = Book->new();
	$library->AddBook($newBook);
	print("Успешно добавлено!\n");
}
#
# Удаление книги из библиотеки по названию
#
sub DeleteBookByName {
	print("Название: ");
	my $target = <>;
	chomp($target);

	my $result = $library->DeleteBookByName($target);

	if ($result == 1)
	{
		print("\"$target\" удалена\n");
		return;
	}

	print("Книги с названием \"$target\" - нет в библиотеке\n");
}
#
# Функция сравнения по <=> выбранных по No (не Number) самолетов
#
sub Compare {
	print("Номер первой: ");
	my $targetNo1 = <>;
	chomp($targetNo1);

	print("Номер второй: ");
	my $targetNo2 = <>;
	chomp($targetNo2);

	my @books =  @{$library->GetBooks};

	my $book1 = @books[$targetNo1];
	my $book2 = @books[$targetNo2];

	if ($book1 == "" || $book2 == "") {
		print("Ошибка в номерах\n");
		return;
	}

	print("Сравнение дат выпуска:\n");

	my $res = Library::Compare($book1,$book2);

	if ($res == 1){
		print("Номер " . $targetNo1 . " > Номер " . $targetNo2 . "\n");
	} elsif ($res == 0) {
		print("Номер " . $targetNo1 . " == Номер " . $targetNo2 . "\n");
	} else {
		print("Номер " . $targetNo1 . " < Номер " . $targetNo2 . "\n");
	}
}


LoadDataFromFile;
LoadObjects;

my $options = "
0 - Напечатать библиотеку
1 - Найти по жанру
2 - Добавить книгу
3 - Добавить пустую книгу
4 - Удалить по названию
5 - Сравнить
6 - Выгрузить в файл
7 - Напечатать по индексу
8 - Выход
Опция: ";
print($options);
while (<>) {
	my $cm = $_;
	chomp($cm);
	if ($cm == 0) {
		PrintAllData;
	}
	if ($cm == 1) {
		SearchByGenre;
	}
	if ($cm == 2) {
		AddNewBook;
	}
	if ($cm == 3) {
		AddDefaultBook;
	}
	if ($cm == 4) {
		DeleteBookByName
	}
	if ($cm == 5) {
		Compare;
	}
	if ($cm == 6)
	{
		SaveToFile;
	}
	if ($cm == 7)
	{
		PrintByIndex;
	}
	if ($cm == 8) {
		exit(418);
	}
	print($options);
}