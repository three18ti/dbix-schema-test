package My::Schema::Result::User;
use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->table('user');

__PACKAGE__->load_components( qw( EncodedColumn ) );

__PACKAGE__->add_columns( qw( name username email ) );

__PACKAGE__->add_columns(
    id => { is_auto_increment => 1 },
);

__PACKAGE__->add_columns(   
    password => {
        encode_column       => 1,
        encode_class        => 'Crypt::Eksblowfish::Bcrypt',
        encode_args         => { key_nul => 1, cost => 8 },
        encode_check_method => 'check_password',
    },
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->has_many( user_roles => 'My::Schema::Result::UserRole', 'user_id' );

__PACKAGE__->many_to_many( roles => 'user_roles', 'role' );

__PACKAGE__->meta->make_immutable;
1;

