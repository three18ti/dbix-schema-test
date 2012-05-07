package My::Schema;
use Moose;
use v5.14.2;

use strict;
use warnings;

use base qw/DBIx::Class::Schema/;

# load My::Schema::Result::* and their resultset classes
__PACKAGE__->load_namespaces();

1;
