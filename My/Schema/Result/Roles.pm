package My::Schema::Result::Roles;
use base qw/DBIx::Class::Core/;

__PACKAGE__->load_components(qw/ Ordered /);
__PACKAGE__->position_column('rank');

__PACKAGE__->table('roles');

__PACKAGE__->add_columns(
                        roleid =>
                          { 
                            data_type => 'integer',
                            size      => 16,
                            is_nullable => 0,
                            is_auto_increment => 1,
                          },
                        role  =>
                          { data_type => 'varchar',
                            size      => 256,
                            is_nullable => 0,
                            is_auto_increment => 0,
                          },
                        rank =>
                          { data_type => 'integer',
                            size      => 16,
                            is_nullable => 1,
                            is_auto_increment => 0,
                          }
                       );

__PACKAGE__->set_primary_key('roleid');

# schema 
__PACKAGE__->has_many(map_user_role => 'My::Schema::Result::UserRoles', 'roleid');

1;
