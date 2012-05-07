#/usr/bin/perl
use v5.14.2;
use strict;
use warnings;

use Data::Dumper;

use DBIx::Class;
use My::Schema;

use Config::Any;

# set config file and load it
my $config_file = './config.yml' ;
# retreives information from first entry in array.
my $cfg = Config::Any->load_files({ files => [$config_file], use_ext => 1 })->[0]->{$config_file};

# load db_config 
my $db_config = $cfg->{'Database'};
my $db_name     = $db_config->{'db_name'};
my $db_driver   = $db_config->{'db_driver'};
my $user_name   = $db_config->{'user_name'};
my $password    = $db_config->{'password'};
my $db_host     = $db_config->{'db_host'} || 'localhost';

#create dsn
my $dsn = $db_config->{'dsn'} || "dbi:$db_driver:dbname=$db_name;host=$db_host";
$dsn .= ';port=' . $db_config->{'port'} if $db_config->{'port'};

# deploy Schema
my $schema = My::Schema->connect($dsn, $user_name, $password);
$schema->deploy({ add_drop_table => 1});

# add new row
my $new_album = $schema->resultset('Artist')->create(
    {
        artist => 'Pink Floyd',
        albums => [
            { title => 'Wish You Were Here', rank => '2',   },
            { title => 'The Wall', rank => '3',             },
            { title => 'Dark Side of the Moon', rank => '1',},
        ],
    },
);

# Attempt 1, not very useful, but it works
#my $album = $schema->resultset('Album')->find(1);
# also, don't understand why I have to call $album->artist->artist
#say "Printing Artist from Album: " . $album->artist->artist . "\n";

# Attempt 2, execute failed: ERROR:  column "artist" does not exist
#my $rs = $schema->resultset('Album')->search( {artist => 'Pink Floyd'});
#my $album = $rs->first;

# Attempt 3, Can't locate object method "title" via package "My::Schema::Result::Artist" at deploy.pl line 59.
# This makes sense because My::Schema::Result::Artist doesn't have a column named title, but album does
#my $rs = $schema->resultset('Artist')->search( {artist => 'Pink Floyd'} );
#my $album = $rs->first;
#say "Printing Album title from Artist table: " . $album->title ;

my $rs = $schema->resultset('Artist');
my $res = $rs->search ({ artist => "Pink Floyd" })->single;
say $_->title foreach $res->albums->all;
