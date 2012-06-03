package My::Schema::Result::UserRole;

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components(qw/ Ordered InflateColumn::DateTime TimeStamp PassphraseColumn /);

=head1 NAME

MyApp::Schema::Result::UserRole

=cut

__PACKAGE__->table('user_role');

__PACKAGE__->add_columns(
                    user_id =>
                      { 
                        data_type => "integer", 
                        is_foreign_key => 1,
                        is_nullable => 0 
                      },
                    role_id => 
                      { 
                        data_type => "integer", 
                        is_foreign_key => 1, 
                        is_nullable => 0 
                      },
                    );


__PACKAGE__->set_primary_key("user_id", "role_id");
#
# Set relationships:

=head1 RELATIONS

=head2 role

Type: belongs_to

Related object: L<MyApp::Schema::Result::Role>

=cut

__PACKAGE__->belongs_to(
    role => 'MyApp::Schema::Result::Role',
    { id => "role_id" },
    { 
        is_deferrable => 1, 
        on_delete => "CASCADE", 
        on_update => "CASCADE" 
    },
);

=head2 user

Type: belongs_to

Related object: L<MyApp::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
    user => 'MyApp::Schema::Result::User',
    { id => "user_id" },
    { 
        is_deferrable => 1, 
        on_delete => "CASCADE", 
        on_update => "CASCADE" 
    },
);




1;
__END__
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
