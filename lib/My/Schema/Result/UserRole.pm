package My::Schema::Result::UserRole;
use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->table('user_role');

__PACKAGE__->add_columns( qw( user_id role_id ) );

__PACKAGE__->set_primary_key("user_id", "role_id");

__PACKAGE__->belongs_to( user => 'My::Schema::Result::User', 'user_id' );
__PACKAGE__->belongs_to( role => 'My::Schema::Result::Role', 'role_id' );

__PACKAGE__->meta->make_immutable;
1;

