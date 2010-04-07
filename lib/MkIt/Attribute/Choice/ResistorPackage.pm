package MkIt::Attribute::Choice::ResistorPackage;
use Moose;
use Moose::Util::TypeConstraints;
extends 'MkIt::Attribute::Choice';

coerce __PACKAGE__,
  'Value' => sub {__PACKAGE__->new($_)};

sub allowed_values {
  'through hole', '1206';
}

1;
