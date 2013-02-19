#!/usr/bin/env perl
use lib 'lib';
use My;
use feature qw(say);

my $schema = My->schema;
$schema->deploy({ add_drop_table => 1});

$schema->resultset('Role')->delete();

$schema->resultset('Role')->populate([
    [ qw( id name ) ],
    
    [1, 'Admin' ],
    [2, 'User'  ],
    [3, 'Guest' ],
]);

$schema->resultset('User')->delete();

$schema->resultset('User')->populate([
    [ qw( id name username email password ) ],
    
    [1, 'Test User 1', 'test1', 'test1@example.org', 'foo' ],
    [2, 'Test User 2', 'test2', 'test2@example.org', 'bar' ],
    [3, 'Test User 3', 'test3', 'test3@example.org', 'baz' ],
    [4, 'Test User 4', 'test4', 'test4@example.org', 'stuff' ],
    [5, 'Test User 5', 'test5', 'test5@example.org', 'stuff2' ],
]);

# Passwords will be encrypted automatically
for my $user ($schema->resultset('User')->all) {
    $user->update({ password => 'test123' });
    
    $user->check_password('test123') or die 'Password check failed.';
}

my $user1 = $schema->resultset('User')->single({ id => 1 });

$user1->user_roles->delete();

say "User1 roles: ", join(' ', map { $_->name } $user1->roles->all);

$user1->add_role('User');

say "User1 roles: ", join(' ', map { $_->name } $user1->roles->all);

$user1->add_role('Admin');

say "User1 roles: ", join(' ', map { $_->name } $user1->roles->all);

$user1->remove_role('User');

say "User1 roles: ", join(' ', map { $_->name } $user1->roles->all);

my $users = $schema->resultset('User');

foreach ($users->all) {
    $_->add_role('User');
}

exit 0;

