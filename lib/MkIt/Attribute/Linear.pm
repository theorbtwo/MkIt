package MkIt::Attribute::Linear;
use Moose;
use Moose::Util::TypeConstraints;
use Data::Dump::Streamer 'Dump';
use overload 
  ('+0' => \&number,
   '""' => \&string);

# extends 'Moose::Meta::TypeConstraint::Parameterizable';
# Moose::Util::TypeConstraints::add_parameterizable_type(__PACKAGE__);

has 'min', is => 'ro', isa => 'Maybe[Num]';
has 'max', is => 'ro', isa => 'Maybe[Num]';

# coerce(__PACKAGE__,
#        ArrayRef => sub {
#          Dump \@_;
#          
#          __PACKAGE__->new(min => $_->[0], max => $_->[1]);
#        },
#        Num => sub {
#          __PACKAGE__->new(min => $_, max => $_);
#        }
#       );

# FIXME: This seems to duplicate coerce.  How do I avoid that?
sub BUILDARGS {
  my ($class, @rest) = @_;
  warn "BUILDARGS for $class: @rest";
  warn "wantarray: ".wantarray;
  # We only want the case of a single argument which isn't blessed.  Let normal moose
  # mechanisms handle weird stuff.
  if (@rest == 0 or blessed $rest[0]) {
    warn "bypassing";
    return @rest;
  }
  # We must handle multiple args ourselves; BUILDARGS is called in scalar context and must return a hash*ref*
  if (@rest > 1) {
    return {@rest};
  }
  # We have already filtered out blessed ones.  ref() is fine.
  if (ref $rest[0] eq 'ARRAY') {
    return {min => $rest[0][0], max => $rest[0][1]};
  }
  if (!ref $rest[0]) {
    return {min => $rest[0], max => $rest[0]};
  }
  die "Don't know how to deal with only argument to new of $rest[0]";
}

sub symbol {
  my ($self) = @_;
  die "Attempt to use a linear without overridden symbol: $self";
}

sub string {
  my ($self) = @_;

  # Fixme: prefixes.
  if (!defined $self->min and !defined $self->max) {
    return undef;

  } elsif (not defined $self->min and defined $self->max) {
    return "at most ".$self->max." ".$self->symbol;
  } elsif (defined $self->min and not defined $self->max) {
    return "at least ".$self->min." ".$self->symbol;

  } elsif ($self->min == $self->max) {
    return $self->min." ".$self->symbol;

  } else {
    # What do I do when I sing out of tune.
    # ...or when min and max have different prefixes.
    return $self->min." to ".$self->max." ".$self->symbol;
  }
}

sub number {
  die "Can't nummify Linears";
}

1;

# 1k8 user
# 1800 database
# 1.8 kohm

# .3 to 3000 user
# .3 to 3000 database
# .3 to 3 kohm
# .3 ohm to 3 kohm

# 1 to 2
# 1 ohm to 2 ohm

