#!/usr/bin/env perl -w
use strict;
use warnings;
use Test::More qw(no_plan);
use MP3::M3U::Parser;
use IO::File;
use Carp qw( croak );

my $output = q{};
my $parser = MP3::M3U::Parser->new(-seconds => 'format');
   $parser->parse('test.m3u');
   $parser->export( -format  => 'html', -toscalar => \$output );

my $fh = IO::File->new;
$fh->open( '08_scalar_html.html', '>' ) or croak 'I can not open file';
my $pok = print {$fh} $output;
$fh->close;

ok(1, 'Some test');
