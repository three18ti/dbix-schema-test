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

say "[*] Creating artist and insertng albums";
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
$new_album->update;

say "[*] Searching Database for Artist";
my $rs = $schema->resultset('Artist');
my $res = $rs->search ({ artist => "Pink Floyd" })->single;

say "[*] Printing titles of Albums";
say $_->title foreach $res->albums->all;

say "[*] Creating Roles";
#$schema->populate('Roles', [
#                    [ qw/role rank/,        ],
#                    [ 'Administrator', '-1',],
#                    [ 'Contributor', '2',   ],
#                    [ 'User', '3',          ],
#                ]
#);

#say "[*] Creating Users";
#$schema->populate('Users', [
#                    [ qw/ username password roles/, ],
#                    [ 'test1', 'test1', [ 'Administrator', 'Contributor', 'User',], ],
#                    [ 'test2', 'test2', qw/Administrator/,                  ],
#                    [ 'test3', 'test3', qw/Contributor/,                    ],
#                    [ 'test4', 'test4', qw/User/,                           ],
#                    [ 'test5', 'test5', qw/Contributor User/,               ],
#                ],
#);
