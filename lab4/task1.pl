#!/bin/perl

use Data::Dumper qw(Dumper);

#todo переделать
sub loadAllText{
    local $inFile = "suppliers.txt";
    local $inText = "";
    local $fileOpenError = "file open error";
    local $fh;

    open($fh, '<', $inFile) || die ($fileOpenError);
    while (local $str = <$fh>)
    {
        $inText .= $str;
    }
    close($fh);

    return $inText;
}
sub getHeadings{
    local $text = loadAllText();
    local @arrData = split(/\n/, $text);
    local @arrHeadings = split(/\s+/, @arrData[0]);
    return @arrHeadings
}
sub getRecords{
    local $text = loadAllText();
    local @arrData = split(/\n/, $text);
    shift @arrData;
    @arrRecords = ();

    for my $i (0 .. $#arrData)
    {
        my @dataParts = split(/\s{2,}/, @arrData[$i]);

        for my $j (0 .. $#dataParts)
        {
            $arrRecords[$i][$j] = $dataParts[$j]
        }
    }

    return @arrRecords;
}
sub printTable {
    local @records = getRecords();
    local @headings = getHeadings();

    foreach my $curprnt (@headings) {
        print $curprnt . "\t";
    }
    print "\n";

    foreach my $string (@records) {
        foreach $curprnt (@$string) {
            print $curprnt . "\t";
        }
        print "\n";
    }
}

#todo сделать
sub addRecord {

}
sub deleteByCompanyName {

}
sub sortByHeadingNum{

}
sub saveToFile {

}
sub search{

}


printTable();