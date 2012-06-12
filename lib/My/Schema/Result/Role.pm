package My::Schema::Result::Role;
use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'My::Schema::Result';

__PACKAGE__->table('role');

__PACKAGE__->add_columns('name');

__PACKAGE__->add_columns(
    id => { is_auto_increment => 1 },
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->has_many( user_roles => 'My::Schema::Result::UserRole', 'role_id' );

__PACKAGE__->many_to_many( users => 'user_roles', 'user' );

__PACKAGE__->meta->make_immutable;
1;

