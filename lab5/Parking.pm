#!/usr/bin/perl

package Parking; {
    use Data::Dumper qw(Dumper);

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

    sub GetCarByStateNumber() {
        my ($self, $targetNumber) = @_;

        while (my ($i, $car) = each(@{$self->{cars}}))
        {
            if ($targetNumber eq $car->GetStateNumber)
            {
                return $car;
            }
        }

        return 0;
    }

    sub GetCarByPlaceNumber() {
        my ($self, $targetNumber) = @_;
        return $self->{cars}[$targetNumber];
    }

    sub GetCarsInTheParking() {
        my ($self) = @_;
        my $arrCars;

        while (my ($i, $car) = each(@{$self->{cars}}))
        {
            if ($car->GetParkingStatus eq "true")
            {
                push @$arrCars, $car;
            }
        }

        return $arrCars;
    }

    sub GetCarsNotInTheParking() {
        my ($self) = @_;
        my $arrCars;

        while (my ($i, $car) = each(@{$self->{cars}}))
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

    sub DeleteCarByStateNumber() {
        my ($self, $targetNumber) = @_;

        local $deleteIndex = -1;

        while (my ($i, $car) = each(@{$self->{cars}}))
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
            splice @{$self->{cars}}, $deleteIndex, 1;
            return 1;
            # print "\"$targetNumber\" successfully deleted";
            # print "Error, car \"$targetNumber\" doesn't exist\n";
        }
        return 0;
    }

    sub ChangeParkingStatus() {
        my ($self, $car) = @_;
        !$car;
    }

    sub SearchByOwner {
        my ($self, $searchOwner) = @_;
        my $arrCars;

        while (my ($i, $car) = each(@{$self->{cars}}))
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
}

1; # ok!
