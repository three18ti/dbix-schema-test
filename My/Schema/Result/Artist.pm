package My::Schema::Result::Artist;
use base qw/DBIx::Class::Core/;

__PACKAGE__->load_components(qw/ Ordered /);
__PACKAGE__->position_column('rank');

__PACKAGE__->table('artist');

__PACKAGE__->add_columns(
                        artistid =>
                          { accessor  => 'artist_id',
                            data_type => 'integer',
                            size      => 16,
                            is_nullable => 0,
                            is_auto_increment => 1,
                          },
                        artist =>
                          { data_type => 'varchar',
                            size      => 256,
                            is_nullable => 0,
                            is_auto_increment => 0,
                          },
                        rank =>
                          { data_type => 'integer',
                            size      => 16,
                            is_nullable => 0,
                            is_auto_increment => 0,
                          }
                       );

__PACKAGE__->set_primary_key('artistid');

# in My::Schema::Result::Artist
__PACKAGE__->has_many('albums', 'My::Schema::Result::Album', 'artistid');

1;
