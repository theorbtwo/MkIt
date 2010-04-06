#!/usr/bin/perl
use warnings;
use strict;
use Test::More 'no_plan';
use Test::Exception;

BEGIN {
  use_ok 'MkIt::Attribute::Linear::Ohm';
}

my $exact = MkIt::Attribute::Linear::Ohm->new(min => 1, max => 1);
isa_ok($exact, 'MkIt::Attribute::Linear::Ohm');
is($exact, '1 ohm', 'stringify, simple case');

my $range = MkIt::Attribute::Linear::Ohm->new([1, 5]);
isa_ok($range, 'MkIt::Attribute::Linear::Ohm');
is($range, '1 to 5 ohm');

