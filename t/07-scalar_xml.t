#!/usr/bin/env perl -w
use strict;
use warnings;
use Test::More qw(no_plan);
use IO::File;
use Carp qw( croak );
use MP3::M3U::Parser;

my $output = q{};
my $parser = MP3::M3U::Parser->new(-seconds => 'format');
   $parser->parse('test.m3u');
   $parser->export( -format  => 'xml', -toscalar => \$output );

my $fh = IO::File->new;
$fh->open( '07_scalar_xml.xml', '>' ) or croak 'I can not open file';
my $pok = print {$fh} $output;
$fh->close;

ok(1, 'Some test');
