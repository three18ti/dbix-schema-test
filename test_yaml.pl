#/usr/bin/perl
use v5.14.2;
use strict;
use warnings;

use Data::Dumper;

use DBIx::Class;
#use My::Schema;

use Config::Any;

use lib './lib';

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


say "$db_name, $db_driver, $user_name, $password $db_host";
