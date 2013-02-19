#/usr/bin/perl
use v5.14.2;
use strict;
use warnings;

use Data::Dumper;

use lib './lib';
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

say "[*] Creating Roles";
$schema->populate('Role', [
                    [ qw/name/,        ],
                    [ 'Administrator',],
                    [ 'Contributor',  ],
                    [ 'User',      ],
                ]
);


say "[*] Creating Users";
#$schema->create({passphrase => 'plain'});
#$schema->populate('User', [
#                    [ qw/ username password user_roles/, ],
#                    [ 'test1', 'test1', [ 'Administrator', 'Contributor', 'User',], ],
#                    [ 'test2', 'test2', qw/Administrator/,                  ],
#                    [ 'test3', 'test3', qw/Contributor/,                    ],
#                    [ 'test4', 'test4', qw/User/,                           ],
#                    [ 'test5', 'test5', qw/Contributor User/,               ],
#                ],
#);

$schema->resultset("User")->populate([
    { username => 'test1', password => 'foobar', 
        user_roles => { {role => 'Administrator'}, {role => 'Contributor'}, },
    },
]);
