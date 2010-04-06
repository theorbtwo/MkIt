package MkIt::Item::Base;
use Moose;
use MooseX::StrictConstructor;

extends 'MkIt::Item';

has 'name',
  (
   is => 'ro',
   isa => 'Str',
   required => 1,
   # name shouldn't be allowed to be one that we have a module in this namespace
   # that isn't really a base item type for.  IE, name => 'Base'.
  );


sub module_namespace {
  my ($self) = @_;

  die "WTF: module_namespace on base item with no name" if !$self->name;

  my $ns = join '', map {ucfirst} split / /, $self->name;
  $ns = "MkIt::Item::Base::$ns";
  return $ns;  
}

sub specialize {
  my ($base, %attributes) = @_;


  # if base module already exists, use it.
  # if not, we must create it.
  # create it out of the database.
  # make an empty class.
  # isa MkIt::Item.
  # create the attributes upon it.
  # if there is a file on-disk, load it.
  
  # instanciate, setting the values of the attributes.


  #my $module_m = Moose::Meta::Class->new;
  #$module_m->extends('MkIt::Item');
  #$module_m->has('base', is => 'ro', isa => 'Class');
  #$module_m->base($base);
  #for my $attr ($base->attributes) {
  #  $module_m->has($attr->name, is => 'ro', isa => 'MkIt::Attribute::'.ucfirst($attr->unit));
  #}

  
  my $base_module = $base->module_namespace;
  if (eval {
    Class::MOP::load_class($base_module);
    1;
  }) {
    return $base_module->new(%attributes);
  } else {
    if ($@ !~ m/Can't locate/) {
      die "$@ while loading $base_module";
    } else {
      warn "specialize: $@";
    }
  }


  MkIt::Item::Specialized->new(base => $base, attributes => \%attributes);
}

1;
