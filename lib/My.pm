package My;
use Moose;
use Config::Tiny;
use My::Schema;

my $config;
my $schema;

sub config {
    my ($self) = @_;
    
    $config ||= Config::Tiny->read('./my.conf');
    
    return $config;
}

sub schema {
    my ($self) = @_;
    
    $schema ||= My::Schema->connect(
        My->build_dsn,
        My->config->{'My::Schema'}->{user},
        My->config->{'My::Schema'}->{password},
    );
    
    return $schema;
}


sub build_dsn {
    my $self = shift;

    my $dsn = My->config->{'My::Schema'}->{dsn} ||
        'dbi:' 
        . My->config->{'My::Schema'}->{db_driver} . ':'
        . 'host=' . My->config->{'My::Schema'}->{db_host} . ';'
        . 'database=' . My->config->{'My::Schema'}->{db_name}
}
1;

