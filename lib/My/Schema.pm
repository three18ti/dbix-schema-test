package My::Schema;
use Moose;
BEGIN { extends 'DBIx::Class::Schema' }

__PACKAGE__->load_namespaces();

1;

