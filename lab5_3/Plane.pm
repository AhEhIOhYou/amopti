#!/usr/bin/perl

#
# Класс самолета
#
package Plane; {

    #
    # Перегруженная операция и соответ. функция
    #
    use overload '<=>'=> \&spaceship;

    sub new {
        my ($class, $plane) = @_;
        my $self;

        #
        # Конструктор с параметрами
        #
        if (defined $plane)
        {
            $self = {
                number      => ${$plane}[0],
                destination => ${$plane}[1],
                time        => ${$plane}[2],
            };
        }
        #
        # Конструктор без параметров
        #
        else
        {
            $self  = {
                number      => 100000,
                destination => 'default',
                time        => '12:00',
            };
        }

        #
        # Благославляем объекто класса! (погугли, это база)
        #
        bless $self, $class;
        return $self;
    }

    sub GetAllData {
        my ($self) = @_;
        return $self;
    }

    sub SetNumber {
        my ($self, $value) = @_;
        $self->{number} = $value;
    }

    sub GetNumber {
        my ($self) = @_;
        return $self->{number};
    }

    sub SetDestination {
        my ($self, $value) = @_;
        $self->{destination} = $value;
    }

    sub GetDestination {
        my ($self) = @_;
        return $self->{destination};
    }

    sub SetTime {
        my ($self, $value) = @_;
        $self->{time} = $value;
    }

    sub GetTime {
        my ($self) = @_;
        return $self->{time};
    }

    #
    # Функция для перегрузки <=>, cmp - эквивалент это штуки, 
    # Вернет 1 - Первое > Второе; 0 - Первое == Второе, -1 - Первое < Второе
    #
    sub spaceship {
        my ($left, $right) = @_;
        my $t1 = join "", split /:/, $left->{time};
        my $t2 = join "", split(/:/, $right->{time});
        my $c = $t1 cmp $t2;
        return $c;
    }

    sub ToString {
        my ($perl) = @_;
        return "$perl->{number}\t$perl->{destination}\t\t$perl->{time}";
    }
}

1; # ok!
