package My::Schema::Result::Album;
use base qw/DBIx::Class::Core/;

__PACKAGE__->load_components(qw/ Ordered /);
__PACKAGE__->position_column('rank');

__PACKAGE__->table('album');

__PACKAGE__->add_columns(albumid =>
                          { accessor  => 'album',
                            data_type => 'integer',
                            size      => 16,
                            is_nullable => 0,
                            is_auto_increment => 1,
                          },
                        artistid =>
                          { data_type => 'integer',
                            size      => 16,
                            is_nullable => 0,
                            is_auto_increment => 0,
                          },
                        title  =>
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

__PACKAGE__->set_primary_key('albumid');

# in My::Schema::Result::Artist
#__PACKAGE__->has_many('albums', 'My::Schema::Result::Album', 'artist');
__PACKAGE__->belongs_to( artist => 'My::Schema::Result::Artist', 'artistid' );

1;
