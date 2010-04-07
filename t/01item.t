#!/usr/bin/perl
use warnings;
use strict;
use Test::More 'no_plan';
use Test::Exception;

BEGIN {
  use_ok 'MkIt::Item';
}

dies_ok(sub {my $bad = MkIt::Item::Base->new(aosidfj => 0xDEADBEEF)},
        'MkIt::Item::Base->new does not allow random garbage in the attribute slot.  (Yes, I do need to actually test this.)');

my $resistor = MkIt::Item::Base->new(name => 'resistor');
isa_ok($resistor, 'MkIt::Item');
is($resistor->name, 'resistor', 'resistor->name eq resistor');
is($resistor->module_namespace, 'MkIt::Item::Base::Resistor', 'module_namespace');

my $r0 = $resistor->specialize();
pass('can specialize with no attributes');

my $r0andahalf = $resistor->specialize(package => 'through hole');

my $r1 = $resistor->specialize(package => '1206', resistance =>'1k8', power=>[.25, undef]);
isa_ok($r1, 'MkIt::Item');
isa_ok($r1, 'MkIt::Item::Resistor');

isa_ok($r1->package, 'MkIt::Item::Attribute::Choice');
is($r1->package, '1206', 'choice is correct');

isa_ok($r1->resistance, 'MkIt::Item::Attribute::Linear');
is($r1->attr('resistance'), "1800 ohm", 'attr accessor, text');
is($r1->resistance, 1800, 'shortcut accessor, numeric');
is($r1->resistance->unit, 'ohm', 'shortcut accessor, unit attribute');
is($r1->extra_text, 'marked 182', 'extra_text special method');
