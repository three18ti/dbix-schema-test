#!/usr/bin/env perl
use ExtUtils::MakeMaker;

WriteMakefile(
    PREREQ_PM => {
        'DBIx::Class::EncodedColumn' => 0,
        'Crypt::Eksblowfish::Bcrypt' => 0,
        'List::MoreUtils'            => 0,
    },
);

