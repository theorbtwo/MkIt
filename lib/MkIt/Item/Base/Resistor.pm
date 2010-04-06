package MkIt::Item::Base::Resistor;
use Moose;
use MooseX::StrictConstructor;
use MkIt::Attribute::Linear;
use MkIt::Attribute::Choice;

extends 'MkIt::Item::Base';

has 'resistance', is => 'ro', isa => 'MkIt::Attribute::Linear[ohm]';
has 'power', is => 'ro', isa => 'MkIt::Attribute::Linear[watt]';
has 'package', is => 'ro', isa => 'MkIt::Attribute::Choice';
has '+name', default => sub {
  my ($self) = @_;
  
  join " ", $self->resistance, $self->power, $self->package, 'resistor';
};

#MkIt::Attribute::Linear[watt]
#ArrayRef[Num]

1;

