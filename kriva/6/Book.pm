#!/usr/bin/perl

#
# Класс книги
#
package Book; {

	#
	# Перегруженная операция и соответ. функция
	#
	use overload '<=>'=> \&spaceship;

	sub new {
		my ($class, $book) = @_;
		my $self;
		#
		# Конструктор с параметрами
		#
		if (defined $book)
		{
			$self = {
				name	=> ${$book}[0],
				author	=> ${$book}[1],
				date	=> ${$book}[2],
				genre	=> ${$book}[3],
			};
		}
		#
		# Конструктор без параметров
		#
		else
		{
			$self = {
				name	=> 'default',
				author	=> 'default',
				date	=> '1970',
				genre	=> 'default',
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

	sub SetName {
		my ($self, $value) = @_;
		$self->{name} = $value;
	}

	sub GetName {
		my ($self) = @_;
		return $self->{name};
	}

	sub SetAuthor {
		my ($self, $value) = @_;
		$self->{author} = $value;
	}

	sub GetAuthor {
		my ($self) = @_;
		return $self->{author};
	}

	sub SetDate {
		my ($self, $value) = @_;
		$self->{date} = $value;
	}

	sub GetDate {
		my ($self) = @_;
		return $self->{date};
	}

	sub SetGenre {
		my ($self, $value) = @_;
		$self->{genre} = $value;
	}

	sub GetGenre {
		my ($self) = @_;
		return $self->{genre};
	}

	#
	# Функция для перегрузки <=>, cmp - эквивалент это штуки, 
	# Вернет 1 - Первое > Второе; 0 - Первое == Второе, -1 - Первое < Второе
	#
	sub spaceship {
		my ($left, $right) = @_;
		my $t1 = (join "", split(/:/, $left->{date}));
		my $t2 = (join "", split(/:/, $right->{date}));
		my $c = $t1 cmp $t2;
		return $c;
	}

	sub ToString {
		my ($perl) = @_;
		return "$perl->{name}\t\t$perl->{author}\t$perl->{date}\t$perl->{genre}";
	}
}

1; # ok!
