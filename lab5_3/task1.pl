#!/usr/bin/perl

#
# Укажи путь к директории с .pm файлами
#
use lib '/home/ahehiohyou/Desktop/work/4course/perl/lab5_3';

use Data::Dumper qw(Dumper);
use strict;

#
# Классы
#
use Plane;
use Airport;

my $fileOpenError = "file open error";
my $fh;
my $fileName = "planes.txt";

#
# Переменная, куда загружаются данные из файла
#
my $records = ();
#
# Объект главного класса
#
my $aitport = Airport->new;

#
# Получает данные из файла и загружает в переменную
#
sub GetFromFile {
    my $inText = "";
    my @arrRecords = ();

    open $fh, '<', $fileName || die $fileOpenError;
    while (my $str = <$fh>)
    {
        $inText .= $str;
    }
    close $fh;

    my @arrData = split /\n/, $inText;

    for my $i (0 .. $#arrData)
    {
        my @dataParts = split /\s+/, @arrData[$i];

        for my $j (0 .. $#dataParts)
        {
            $arrRecords[$i][$j] = $dataParts[$j];
        }
    }
    $records = \@arrRecords;
}
#
# Сохраняет состояние аэропорта в файл
#
sub SaveToFile {
    my @planes =  @{$aitport->GetAllPlanes};
    open $fh, '>', $fileName || die $fileOpenError;
    foreach my $plane (@planes)
    {
        print $fh Plane::ToString($plane) . "\n";
    }
    close $fh;
    print "Successfully saved!\n";
}
#
# Загружает данные с переменной в классы
#
sub LoadObjects {
    foreach my $arrRecord (@{$records})
    {
        my $cl = Plane->new($arrRecord);
        $aitport->AddPlane($cl);
    }
}
#
# Печатает весь массив самолетов в аэропорту
#
sub PrintAllData {
    my @planes =  @{$aitport->GetAllPlanes};
    $\ = "\n";
    print "+" . "-"x39 . "+";
    print "|No\t" . Airport::ToStringLabels() . "\t|";
    while (my ($i, $plane) = each(@planes))
    {
        print "|" . $i  ."\t" . Plane::ToString($plane) . "\t|";
    }
    print "+" . "-"x39 . "+";
    $\ = "";
}
#
# Печатает массив переданных объектов типа самолет
#
sub PrintData {
    $\ = "\n";
    my $planes = shift;
    print "+" . "-"x39 . "+";
    print "|No\t" . Airport::ToStringLabels() . "\t|";
    while (my ($i, $plane) = each(@{$planes}))
    {
        print "|" . $i  ."\t" . Plane::ToString($plane) . "\t|";
    }
    print "+" . "-"x39 . "+";
    $\ = "";
}
#
# Поиск по пункту назначения
#
sub SearchByDestination {
    print "Search by destination: ";
    my $searchText = <>;
    chomp $searchText;

    my $res = $aitport->SearchByDestination($searchText);

    print "Result:\n";
    if (!defined $res)
    {
        print "Nothing found!\n";
        return;
    }

    PrintData($res);
}
#
# Печатает информациб по Number
#
sub PrintByNumber {
    print "Number: ";
    my $searchText = <>;
    chomp $searchText;

    my $res = $aitport->GetPlaneByNumber($searchText);

    print "Result:\n";
    if (!defined $res)
    {
        print "Nothing found!\n";
        return;
    }

    PrintData($res);
}
#
# Добавляет в аэропорт самолет с переданными полями
#
sub AddNewPlane {
    my $newData;
    my @labels = Airport::ToArrLabels;

    while (my ($i, $heading) = each(@labels))
    {
        print $heading . ": ";
        my $inputValue = <>;
        chomp $inputValue;
        @{$newData}[$i] = $inputValue;
    }

    my $plane = Plane->new($newData);
    $aitport->AddPlane($plane);
    print "Added!\n"
}
#
# Добавляет в аэропорт самолет с конструктором без параметров
#
sub AddDefaultPlane {
    my $plane = Plane->new();
    $aitport->AddPlane($plane);
    print "Added!\n";
}
#
# Удаление самолета из аэропорт по Number
#
sub DeletePlaneByNumber {
    print "Number: ";
    my $targetNumber = <>;
    chomp $targetNumber;

    my $res = $aitport->DeletePlaneByNumber($targetNumber);

    if ($res == 1)
    {
        print "\"$targetNumber\" successfully deleted\n";
        return;
    }

    print "Error, plane with number \"$targetNumber\" doesn't exist\n";
}
#
# Функция сравнения по <=> выбранных по No (не Number) самолетов
#
sub Compare {
    print "Frist No: ";
    my $targetNo1 = <>;
    chomp $targetNo1;

    print "Second No: ";
    my $targetNo2 = <>;
    chomp $targetNo2;

    my @planes =  @{$aitport->GetAllPlanes};

    my $a = @planes[$targetNo1];
    my $b = @planes[$targetNo2];

    if ($a == "" || $b == "") {
        print "Error!\n";
        return;
    }

    print "Compare:\n";
    PrintData([$a,$b]);

    my $res = Airport::Compare($a,$b);

    if ($res == 1){
        print "Result: No " . $targetNo1 . " > No " . $targetNo2 . "\n";
    } elsif ($res == 0) {
        print "Result: No " . $targetNo1 . " == No " . $targetNo2 . "\n";
    } else {
        print "Result: No " . $targetNo1 . " < No " . $targetNo2 . "\n";
    }
}


GetFromFile;
LoadObjects;

my $options = "0 - print all data\n1 - search by destination\n2 - add new plane\n3 - add new default plane\n4 - delete plane by number\n5 - compare\n6 - save to file\n7 - print by number\n8 - exit\nOption: ";
print $options;
while (<>) {
    my $cm = $_;
    chomp($cm);
    if ($cm == 0) {
        PrintAllData;
    }
    if ($cm == 1) {
        SearchByDestination;
    }
    if ($cm == 2) {
        AddNewPlane;
    }
    if ($cm == 3) {
        AddDefaultPlane;
    }
    if ($cm == 4) {
        DeletePlaneByNumber
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
        PrintByNumber;
    }
    if ($cm == 8) {
        exit(100);
    }
    print $options;
}