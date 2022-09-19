#!/bin/perl

use Data::Dumper qw(Dumper);

my $fileOpenError = "file open error";
my $fh;

my $data = {
    fileName => "",
    text     => "",
    headings => (),
    records  => (),
    colCount => 0,
    rowCount => 0,
};

sub loadData {
    local $inFile = "suppliers.txt";
    local $inText = "";

    open($fh, '<', $inFile) || die($fileOpenError);
    while (local $str = <$fh>) {
        $inText .= $str;
    }
    close($fh);

    local @arrData = split(/\n/, $inText);
    local @arrHeadings = split(/\s+/, @arrData[0]);

    shift @arrData;
    local @arrRecords = ();

    for my $i (0 .. $#arrData) {
        my @dataParts = split(/\s+/, @arrData[$i]);

        for my $j (0 .. $#dataParts) {
            $arrRecords[$i][$j] = $dataParts[$j];
        }
    }

    $data->{fileName} = $inFile;
    $data->{text} = $inText;
    $data->{headings} = \@arrHeadings;
    $data->{records} = \@arrRecords;
    $data->{colCount} = scalar(@arrHeadings);
    $data->{rowCount} = scalar(@arrRecords);
}
sub printTable {
    local $headings = $data->{headings};
    local $records = $data->{records};
    local $text = "";

    for (my $i = 0; $i < $data->{colCount}; $i++)
    {
        $text .= ${$headings}[$i] . "\t";
    }
    $text .= "\n";

    for (my $i = 0; $i < $data->{rowCount}; $i++)
    {
        for (my $j = 0; $j < $data->{colCount}; $j++)
        {
            $text .= ${$records}[$i][$j] . "\t";
        }
        $text .= "\n";
    }

    return $text;
}
sub addRecord {
    local $headings = $data->{headings};
    local $records = $data->{records};
    local @newValues;
    for (my $i = 0; $i < $data->{colCount}; $i++)
    {
        print ${$headings}[$i] . ": ";
        local $inputValue = <>;
        chomp($inputValue);
        $newValues[$i] = $inputValue;
    }
    push(@$records, \@newValues);
    $data->{rowCount}++;
}
sub saveToFile {
    local $fileName = $data->{fileName};
    open($fh, '>', $fileName) || die($fileOpenError);
    print $fh printTable();
    close($fh);
}
sub getRecordIndexByName {
    local $nameToSearch = shift;
    local $records = $data->{records};
    local $index = -1;

    for (my $i = 0; $i < $data->{rowCount}; $i++)
    {
        if (${$records}[$i][0] eq $nameToSearch)
        {
            $index = $i;
            last;
        }
    }

    return $index;
}
sub deleteByCompanyName {
    local $nameSearch = shift;
    local $deleteIndex = getRecordIndexByName($nameSearch);
    if ($deleteIndex > -1) {
        splice(@{$data->{lines}}, $deleteIndex, 1);
    }
    else {
        print "Error, compant $nameSearch doesn't exist";
    }
}
sub search {
    local $searchText = shift;
    local $resultText = "";
    local @indexFound = ();
    local $headings = $data->{headings};
    local $records = $data->{records};

    for (my $i = 0; $i < $data->{rowCount}; $i++) {
        for (my $j = 0; $j < $data->{colCount}; $j++) {
            if (${$records}[$i][$j] =~ /$searchText/) {
                push(@indexFound, $i);
                last;
            }
        }
    }

    if (@indexFound > 0) {
        $resultText .= "FOUND:\n";

        for (my $i = 0; $i < $data->{colCount}; $i++) {
            $resultText .= ${$headings}[$i] . "\t";
        }
        $resultText .= "\n";

        for (my $i = 0; $i < @indexFound; $i++) {
            local $index = ${indexFound}[$i];
            for (my $j = 0; $j < $data->{colCount}; $j++) {
                $resultText .= ${$records}[$index][$j] . "\t";
            }
            $resultText .= "\n";
        }
    }
    else {
        $resultText .= "By request \"$searchText\" nothing found\n";
    }

    return $resultText;
}

# todo доделать
sub sortByHeadingNum {
    local $colNum = shift;
    local $headings = $data->{headings};
    local $records = $data->{records};
}

loadData();
print printTable();
addRecord();
saveToFile();
