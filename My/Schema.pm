package My::Schema;
use Moose;
use common::sense;

use base qw/DBIx::Class::Schema/;

# load My::Schema::Result::* and their resultset classes
__PACKAGE__->load_namespaces();

1;
