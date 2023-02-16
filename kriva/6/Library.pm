#!/usr/bin/perl
use Data::Dumper qw(Dumper);
#
# Класс библиотеки с массивом объектов типа книга
#
package Library; {

	sub new {
		my $class = shift;
		my $self = {
			books => (),
		};
		bless $self, $class;
		return $self;
	}

	sub GetBooks {
		my ($self) = @_;
		return $self->{books};
	}

	sub GetBookByIndex {
		my ($self, $index) = @_;
		my @books = @{$self->{books}};
		print($index);
		return @books[$index];
	}

	sub AddBook {
		my ($self, $data) = @_;
		push @{$self->{books}}, $data;
		return 1;
	}

	sub DeleteBookByName {
		my ($self, $target) = @_;
		my @books =  @{$self->{books}};

		local $deleteIndex = -1;

		while (my ($i, $book) = each(@books))
		{
			if ($target eq $book->GetName)
			{
				$deleteIndex = $i;
				last;
			}
		}

		if ($deleteIndex > -1)
		{
			@tmp = @{$self->{books}};
			splice(@tmp, $deleteIndex, 1);
			@{$self->{books}} = @tmp;
			return 1;
		}
		return 0;
	}

	sub SearchByGenre {
		my ($self, $searchWord) = @_;
		my $foundBooks;
		my @books =  @{$self->{books}};

		while (my ($i, $book) = each(@books))
		{
			if ($book->GetGenre =~ /$searchWord/)
			{
				push(@$foundBooks, $book);
			}
		}

		return $foundBooks;
	}

	sub ToStringLabels {
		return "Название\tАвтор\tДата\tЖанр";
	}

	sub Compare {
		my ($a, $b) = @_;
		return $a <=> $b;
	}

	sub ToArrLabels {
		return (
			"Название",
			"Автор",
			"Дата",
			"Жанр",
		);
	}
}

1; # ok!
