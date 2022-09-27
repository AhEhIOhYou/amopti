#!/usr/bin/perl

package Auto; {

    use Data::Dumper qw(Dumper);
    use overload '!'=> \&ReverseParkingsStatus;

    sub new {
        my $class = shift;
        my $self;
        if (@_ > 0)
        {
            $self = {
                state_number => shift,
                color        => shift,
                owner        => shift,
                onParking    => shift,
            };
        }
        else
        {
            $self  = {
                state_number => 0,
                color        => 'default',
                owner        => 'default',
                onParking    => 0,
            };
        }

        bless $self, $class;
        return $self;
    }

    sub GetAllData {
        my ($self) = @_;
        return $self;
    }

    sub SetStateNumber {
        my ($self, $value) = @_;
        $self->{state_number} = $value;
    }

    sub GetStateNumber {
        my ($self) = @_;
        return $self->{state_number};
    }

    sub SetColor {
        my ($self, $value) = @_;
        $self->{color} = $value;
    }

    sub GetColor {
        my ($self) = @_;
        return $self->{color};
    }

    sub SetOwner {
        my ($self, $value) = @_;
        $self->{owner} = $value;
    }

    sub GetOwner {
        my ($self) = @_;
        return $self->{owner};
    }

    sub SetParkingStatus {
        my ($self, $value) = @_;
        $self->{onParking} = $value;
    }

    sub GetParkingStatus{
        my ($self) = @_;
        return $self->{onParking};
    }

    sub ReverseParkingsStatus()
    {
        my ($car) = @_;
        print $car->{onParking};
        if ($car->{onParking} eq "true")
        {
            $car->{onParking} = "false";
        }
        else
        {
            $car->{onParking} = "true";
        }
    }

    sub ToString {
        my ($car) = @_;
        return "$car->{state_number}\t\t$car->{color}\t$car->{owner}\t$car->{onParking}";
    }
}

1; # ok!
