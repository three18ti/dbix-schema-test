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
        My->config->{'My::Schema'}->{dsn},
        My->config->{'My::Schema'}->{user},
        My->config->{'My::Schema'}->{password},
    );
    
    return $schema;
}
    
1;

