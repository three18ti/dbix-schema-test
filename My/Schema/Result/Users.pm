package My::Schema::Result::Users;
use base qw/DBIx::Class::Core/;

__PACKAGE__->load_components(qw/ Ordered /);
__PACKAGE__->position_column('userid');

__PACKAGE__->table('users');

__PACKAGE__->add_columns(
                        userid =>
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
                          }
                       );

__PACKAGE__->set_primary_key('userid');

# in My::Schema::Result::Artist

# has_many():
#   args:
#     1) Name of relationship, DBIC will create accessor with this name
#     2) Name of the model class referenced by this relationship
#     3) Column name in *foreign* table (aka, foreign key in peer table)
__PACKAGE__->has_many(map_user_role => 'My::Schema::Result::UserRoles', 'userid');

# many_to_many():
#   args:
#     1) Name of relationship, DBIC will create accessor with this name
#     2) Name of has_many() relationship this many_to_many() is shortcut for
#     3) Name of belongs_to() relationship in model class of has_many() above
#   You must already have the has_many() defined to use a many_to_many().
__PACKAGE__->many_to_many(roles => 'map_user_role', 'role');

#__PACKAGE__->has_many('permissions', 'My::Schema::Result::Permissions', 'userid');

1;
