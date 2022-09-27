#!/usr/bin/perl

package Auto; {

    use overload '!'=> \&ReverseParkingsStatus;

    sub new {
        my ($class, $car) = @_;
        my $self;

        if (defined $car)
        {
            $self = {
                state_number => ${$car}[0],
                color        => ${$car}[1],
                owner        => ${$car}[2],
                onParking    => ${$car}[3],
            };
        }
        else
        {
            $self  = {
                state_number => 0,
                color        => 'default',
                owner        => 'default',
                onParking    => false,
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

    sub ReverseParkingsStatus {
        my ($car) = @_;
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
