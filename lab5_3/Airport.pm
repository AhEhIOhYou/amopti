#!/usr/bin/perl

#
# Класс аэропорта с массивом объектов типа самолет
#
package Airport; {

    sub new {
        my $class = shift;
        my $self = {
            planes => (),
        };
        bless $self, $class;
        return $self;
    }

    sub GetAllPlanes {
        my ($self) = @_;
        return $self->{planes};
    }

    sub GetPlaneByNumber {
        my ($self, $targetNumber) = @_;
        my @planes = @{$self->{planes}};

        while (my ($i, $plane) = each(@planes))
        {
            if ($targetNumber eq $plane->GetNumber)
            {
                return [$plane];
            }
        }

        return;
    }

    sub AddPlane {
        my ($self, $data) = @_;
        push @{$self->{planes}}, $data;
        return 1;
    }

    sub DeletePlaneByNumber {
        my ($self, $targetNumber) = @_;
        my @planes =  @{$self->{planes}};

        local $deleteIndex = -1;

        while (my ($i, $plane) = each(@planes))
        {
            if ($targetNumber eq $plane->GetNumber)
            {
                $deleteIndex = $i;
                last;
            }
        }

        if ($deleteIndex > -1)
        {
            @tmp = @{$self->{planes}};
            splice @tmp, $deleteIndex, 1;
            @{$self->{planes}} = @tmp;
            return 1;
        }
        return 0;
    }

    sub SearchByDestination {
        my ($self, $searchDestination) = @_;
        my $arrPlanes;
        my @planes =  @{$self->{planes}};

        while (my ($i, $plane) = each(@planes))
        {

            if ($plane->GetDestination =~ /$searchDestination/)
            {
                push @$arrPlanes, $plane;
            }
        }

        return $arrPlanes;
    }

    sub ToStringLabels {
        return "Number\tDestination\tTime";
    }

    sub Compare {
        my ($a, $b) = @_;
        return $a <=> $b;
    }

    sub ToArrLabels {
        return (
            "Number",
            "Destination",
            "Time",
            );
    }
}

1; # ok!
