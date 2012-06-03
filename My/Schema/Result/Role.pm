package My::Schema::Result::Role;
use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components(qw/ InflateColumn::DateTime Ordered TimeStamp PassphraseColumn /);

__PACKAGE__->position_column('rank');

__PACKAGE__->table('roles');

__PACKAGE__->add_columns(
                        role_id =>
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
#                        rank =>
#                          { data_type => 'integer',
#                            size      => 16,
#                            is_nullable => 1,
#                            is_auto_increment => 0,
#                          }
#                       );

__PACKAGE__->set_primary_key('role_id');

=head1 RELATIONS

=head2 user_roles

Type: has_many

Related object: L<MyApp::Schema::Result::UserRole>

=cut

__PACKAGE__->has_many(
    user_roles =>  'MyApp::Schema::Result::UserRole',
    { "foreign.role_id" => "self.id" },
    { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->meta->make_immutable;
1;


# schema 
__PACKAGE__->has_many(map_user_role => 'My::Schema::Result::UserRoles', 'roleid');

1;
