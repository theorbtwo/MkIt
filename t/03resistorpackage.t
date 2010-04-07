#!/usr/bin/perl
use warnings;
use strict;
use Test::More 'no_plan';
use Test::Exception;
use MkIt::Attribute::Choice::ResistorPackage;

my $pack = MkIt::Attribute::Choice::ResistorPackage->new('through hole');
isa_ok($pack, 'MkIt::Attribute::Choice::ResistorPackage');
is($pack, 'through hole');

$pack = MkIt::Attribute::Choice::ResistorPackage->new('1206');
isa_ok($pack, 'MkIt::Attribute::Choice::ResistorPackage');
is($pack, '1206');

$@ = '';
eval {
  $pack = MkIt::Attribute::Choice::ResistorPackage->new('your mother');
};
ok($@, 'cannot set package to your mother');
like($@, qr/your mother/, 'error message mentions what we attempted to set to');
like($@, qr/through hole, 1206/, 'error message gives allowed values');

$pack = MkIt::Attribute::Choice::ResistorPackage->new('Through Hole');
is($pack, 'through hole', 'normalizes case');
