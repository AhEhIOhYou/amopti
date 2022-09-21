#!/bin/perl

use Data::Dumper qw(Dumper);

my $fileOpenError = "file open error";
my $fh;

my $fileName = "suppliers.txt";
my $headings = ();
my $records = ();

sub GetFromFile {
    local $inText = "";

    open $fh, '<', $fileName || die $fileOpenError;
    while (local $str = <$fh>)
    {
        $inText .= $str;
    }
    close $fh;

    local @arrData = split /\n/, $inText;
    local @arrHeadings = split /\s+/, @arrData[0];
    $headings = \@arrHeadings;

    local @arrRecords = ();
    shift @arrData;

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
sub GetTableFormatText {
    local $text = "";

    foreach $heading (@{$headings})
    {
        $text .= $heading . "\t";
    }
    $text .= "\n";

    foreach $arrRecord (@{$records})
    {
        foreach $recordData (@{$arrRecord})
        {
            $text .= $recordData . "\t";
        }
        $text .= "\n";
    }

    return $text;
}
sub AddRecord {
    local @newData;

    for (my $i = 0; $i < $#{$headings} + 1; $i++)
    {
        print ${$headings}[$i] . ": ";
        local $inputValue = <>;
        chomp $inputValue;
        $newData[$i] = $inputValue;
    }

    push @$records, \@newData;
    print "Successfully added!\n";
}
sub SaveToFile {
    open $fh, '>', $fileName || die $fileOpenError;
    print $fh GetTableFormatText;
    close $fh;
}
sub DeleteRecordByCompanyName {
    print "Company Name: ";
    local $nameSearch = <>;
    chomp $nameSearch;

    local $deleteIndex = -1;

    while (my ($i, $element) = each(@{$records}))
    {
        if (${$element}[0] eq $nameSearch)
        {
            $deleteIndex = $i;
            last;
        }
    }

    if ($deleteIndex > -1)
    {
        print $deleteIndex . "\n";
        splice @{$records}, $deleteIndex, 1;
        print "\"$nameSearch\" successfully deleted";
    }
    else
    {
        print "Error, company \"$nameSearch\" doesn't exist\n";
    }
}
sub Search {
    print "Search: ";
    local $searchText = <>;
    chomp $searchText;

    local @indexFound = ();

    while (my ($i, $arrRecord) = each(@{$records}))
    {
        foreach $recordData (@{$arrRecord})
        {
            if ($recordData =~ /$searchText/)
            {
                push @indexFound, $i;
                last;
            }
        }
    }

    if (@indexFound > 0)
    {
        print "FOUND:\n";

        foreach $heading (@{$headings})
        {
            print $heading . "\t";
        }
        print "\n";

        foreach $index (@indexFound)
        {
            for (my $j = 0; $j < $#{$headings} + 1; $j++)
            {
                print ${$records}[$index][$j] . "\t";
            }
            print "\n";
        }
    }
    else
    {
        print "By request \"$searchText\" nothing found\n";
    }
}

# todo доделать
sub SortByHeading {
    print "Heading: ";
    local $searchHeading = <>;
    chomp $searchHeading;
}

GetFromFile;
print GetTableFormatText;
DeleteRecordByCompanyName;
SaveToFile;