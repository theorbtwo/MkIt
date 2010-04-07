package MkIt::Item::Base::Resistor;
use Moose;
use MooseX::StrictConstructor;
use MkIt::Attribute::Linear::Ohm;
use MkIt::Attribute::Linear::Watt;
use MkIt::Attribute::Choice::ResistorPackage;

extends 'MkIt::Item::Base';

has 'resistance', is => 'ro', isa => 'MkIt::Attribute::Linear::Ohm', coerce => 1;
has 'power', is => 'ro', isa => 'MkIt::Attribute::Linear::Watt', coerce => 1;
has 'package', is => 'ro', isa => 'MkIt::Attribute::Choice::ResistorPackage', coerce => 1;
has '+name', default => sub {
  my ($self) = @_;
  
  join " ", grep {$_} ($self->resistance, $self->power, $self->package, 'resistor');
};

#MkIt::Attribute::Linear[watt]
#ArrayRef[Num]

1;

