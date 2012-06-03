package My::Schema::Result::Users;

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components(qw/ InflateColumn::DateTime Ordered TimeStamp PassphraseColumn /);
__PACKAGE__->position_column('userid');

__PACKAGE__->table('users');

__PACKAGE__->add_columns(
                        user_id =>
                          { accessor  => 'userid',
                            data_type => 'integer',
                            size      => 16,
                            is_nullable => 0,
                            is_auto_increment => 1,
                          },
                        username =>
                          { accessor  => 'username',
                            data_type => 'varchar',
                            size      => 256,
                            is_nullable => 0,
                            is_auto_increment => 0,
                          },
                        password =>
                          { data_type => 'varchar', 
                            size      => 256,
                            is_nullable => 0,
                            is_auto_increment => 0,
                          },
                        email_address =>
                          { data_type   => "varchar",
                            size        => 256,
                            is_nullable => 1,
                          },
                        last_name   =>
                          { data_type   => "varchar",
                            size        => 100,
                            is_nullable => 1,
                          },
                        active      =>
                          { data_type   => "integer",
                            size        => 1,
                            is_nullable => 1,
                          },
                       );

__PACKAGE__->set_primary_key('user_id');

__PACKAGE__->has_many(
    user_roles  => 'My::Schema::Result::UserRole',
    { "foreign.user_id" => "self.id" },
    { cascade_copy => 0, cascade_delete => 0 },
);

# many_to_many():
#   args:
#     1) Name of relationship, DBIC will create accessor with this name
#     2) Name of has_many() relationship this many_to_many() is shortcut for
#     3) Name of belongs_to() relationship in model class of has_many() above
#   You must already have the has_many() defined to use a many_to_many().
__PACKAGE__->many_to_many(roles => 'user_roles', 'role');

# Have the 'password' column use a SHA-1 hash and 20-byte salt
# with RFC 2307 encoding; Generate the 'check_password" method
__PACKAGE__->add_columns(
    'password' => {
        passphrase       => 'rfc2307',
        passphrase_class => 'SaltedDigest',
        passphrase_args  => {
            algorithm   => 'SHA-1',
            salt_random => 20.
        },
        passphrase_check_method => 'check_password',
    },
);

=head2 has_role

Check if a user has the specified role

=cut

use Perl6::Junction qw/any/;
sub has_role {
    my ($self, $role) = @_;

    # Does this user posses the required role?
    return any(map { $_->role } $self->roles) eq $role;
}

__PACKAGE__->meta->make_immutable;
1;
__END__
# in My::Schema::Result::Artist

# has_many():
#   args:
#     1) Name of relationship, DBIC will create accessor with this name
#     2) Name of the model class referenced by this relationship
#     3) Column name in *foreign* table (aka, foreign key in peer table)
#__PACKAGE__->has_many(map_user_role => 'My::Schema::Result::UserRoles', 'userid');

# many_to_many():
#   args:
#     1) Name of relationship, DBIC will create accessor with this name
#     2) Name of has_many() relationship this many_to_many() is shortcut for
#     3) Name of belongs_to() relationship in model class of has_many() above
#   You must already have the has_many() defined to use a many_to_many().
#__PACKAGE__->many_to_many(roles => 'map_user_role', 'role');

#__PACKAGE__->has_many('permissions', 'My::Schema::Result::Permissions', 'userid');



1;
