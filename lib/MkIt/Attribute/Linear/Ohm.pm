package MkIt::Attribute::Linear::Ohm;
use Moose;
extends 'MkIt::Attribute::Linear';

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
