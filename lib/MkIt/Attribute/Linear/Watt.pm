package MkIt::Attribute::Linear::Watt;
use Moose;
extends 'MkIt::Attribute::Linear';

sub symbol {
  'W';
}

sub uses_metric_prefixes {
  1;
}

sub equivs {
  ();
}

1;
