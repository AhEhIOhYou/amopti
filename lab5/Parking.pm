#!/usr/bin/perl

package Parking; {

    sub new {
        my $class = shift;
        my $self = {
            cars => (),
        };
        bless $self, $class;
        return $self;
    }

    sub GetAllCars {
        my ($self) = @_;
        return $self->{cars};
    }

    sub GetCarByStateNumber {
        my ($self, $targetNumber) = @_;
        my @cars = @{$self->{cars}};

        while (my ($i, $car) = each(@cars))
        {
            if ($targetNumber eq $car->GetStateNumber)
            {
                return $car;
            }
        }

        return;
    }

    sub GetCarsInTheParking {
        my ($self) = @_;
        my $arrCars;
        my @cars =  @{$self->{cars}};

        while (my ($i, $car) = each(@cars))
        {
            if ($car->GetParkingStatus eq "true")
            {
                push @$arrCars, $car;
            }
        }

        return $arrCars;
    }

    sub GetCarsNotInTheParking {
        my ($self) = @_;
        my $arrCars;
        my @cars =  @{$self->{cars}};

        while (my ($i, $car) = each(@cars))
        {
            if ($car->GetParkingStatus eq "false")
            {
                push @$arrCars, $car;
            }
        }

        return $arrCars;
    }

    sub AddCar {
        my ($self, $data) = @_;
        push @{$self->{cars}}, $data;
        return 1;
    }

    sub DeleteCarByStateNumber {
        my ($self, $targetNumber) = @_;
        my @cars =  @{$self->{cars}};

        local $deleteIndex = -1;

        while (my ($i, $car) = each(@cars))
        {
            if ($targetNumber eq $car->GetStateNumber)
            {
                $deleteIndex = $i;
                last;
            }
        }

        if ($deleteIndex > -1)
        {
            print $deleteIndex . "\n";
            @tmp = @{$self->{cars}};
            splice @tmp, $deleteIndex, 1;
            @{$self->{cars}} = @tmp;
            return 1;
        }
        return 0;
    }

    sub ChangeParkingStatus {
        my ($self, $car) = @_;
        !$car;
    }

    sub SearchByOwner {
        my ($self, $searchOwner) = @_;
        my $arrCars;
        my @cars =  @{$self->{cars}};

        while (my ($i, $car) = each(@cars))
        {

            if ($car->GetOwner =~ /$searchOwner/)
            {
                push @$arrCars, $car;
            }
        }

        return $arrCars;
    }

    sub ToStringLabels {
        return "State Number\tColor\tOwner\tIs on parking";
    }

    sub ToArrLabels {
        return (
            "State number",
            "Color",
            "Owner",
            "Is on parking",
            );
    }
}

1; # ok!
