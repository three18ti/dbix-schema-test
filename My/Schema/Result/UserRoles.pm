package My::Schema::Result::UserRoles;
use base qw/DBIx::Class::Core/;

__PACKAGE__->load_components(qw/ Ordered /);
#__PACKAGE__->position_column('rank');

__PACKAGE__->table('user_roles');

__PACKAGE__->add_columns(
                    userid =>
                      { 
                        data_type => "integer", 
                        is_foreign_key => 1,
                        is_nullable => 0 
                      },
                    roleid => 
                      { 
                        data_type => "integer", 
                        is_foreign_key => 1, 
                        is_nullable => 0 
                      },
                    );


__PACKAGE__->set_primary_key("userid", "roleid");
#
# Set relationships:


# belongs_to():
#   args:
#     1) Name of relationship, DBIC will create accessor with this name
#     2) Name of the model class referenced by this relationship
#     3) Column name in *this* table
__PACKAGE__->belongs_to(user => 'My::Schema::Result::Users', 'userid');

# belongs_to():
#   args:
#     1) Name of relationship, DBIC will create accessor with this name
#     2) Name of the model class referenced by this relationship
#     3) Column name in *this* table
__PACKAGE__->belongs_to(role => 'My::Schema::Result::Roles', 'roleid');
1;
