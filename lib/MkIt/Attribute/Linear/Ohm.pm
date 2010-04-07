package MkIt::Attribute::Linear::Ohm;
use Moose;
use Moose::Util::TypeConstraints;
extends 'MkIt::Attribute::Linear';

coerce __PACKAGE__,
  'Value' => sub {__PACKAGE__->new($_)};

sub symbol {
  'ohm';
}

sub uses_metric_prefixes {
  1;
}

sub equivs {
  ();
}

1;
