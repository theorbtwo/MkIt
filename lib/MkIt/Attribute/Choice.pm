package MkIt::Attribute::Choice;
use Moose;
use MooseX::StrictConstructor;
use List::Util 'first';
use overload '""' => 'stringify';

# immutability is a generally useful thing, but gets in the way of my
# trigger.  ...or do we hoist this up into BUILDARGS?  It works now.
# Punt the philosophy until later.
has 'value', is => 'rw', isa => 'Str', trigger => sub {
  my ($self, $new_val, $old_val) = @_;
  
  # FIXME: Make it possible for subclasses to have different normalization behaviors?
  my $cannon = first {lc $_ eq lc $new_val} $self->allowed_values;

  if (not defined $cannon) {
    # FIXME: change error message to give type name, and to put "or" before last allowed value.
    die "Cannot set value to $new_val, must be one of ", join(", ", $self->allowed_values);
  }

  if ($new_val eq $cannon) {
    return;
  }

  # FIXME: Change this so it won't needlessly recuruse to check if the newly
  # cannonized value is cannonized.
  $self->value($cannon);
};

sub BUILDARGS {
  my ($self, @rest) = @_;

  if (@rest > 1) {
    return {@rest};
  }

  if (not ref $rest[0]) {
    return {value => $rest[0]};
  }

  return @rest;
}

sub stringify {
  return $_[0]->value;
}

1;
