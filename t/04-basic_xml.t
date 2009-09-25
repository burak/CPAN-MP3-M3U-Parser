#!/usr/bin/env perl -w
use strict;
use warnings;
use Test::More qw(no_plan);
use MP3::M3U::Parser;

my $parser = MP3::M3U::Parser->new(
    -parse_path => 'asis',
    -seconds    => 'format',
    -search     => q{},
    -overwrite  => 1,
    -encoding   => 'ISO-8859-9',
    -expformat  => 'xml',
);

is(ref $parser, 'MP3::M3U::Parser'        , 'Parser' );
is(    $parser, $parser->parse('test.m3u'), 'Parser' );
my $result = $parser->result;
is(ref $result,                                      'ARRAY', 'Parser');
is(    $parser, $parser->export(-file => '04_basic_xml.xml'), 'Parser');
my %info = $parser->info;
is( ref $info{drive}, 'ARRAY'       , 'Parser' );
is( $parser         , $parser->reset, 'Parser' );
