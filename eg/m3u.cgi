#!/usr/bin/perl -w
use strict;
use warnings;
use CGI;
use MP3::M3U::Parser 2.20;

my $cgi = CGI->new;
my $p   = $cgi->url;
my $xml = $cgi->param('xml');

my $encoding      = 'ISO-8859-9'; # http encoding
my $output_format = $xml ? 'xml' : 'html';
my $base_dir      = q{.}; # where are your m3u files?
my $error         = 'Invalid parameter!';

my $OUT;

$cgi->param('m3u') ? m3u() : list();
my $head = $cgi->header(
   -type    => "text/$output_format",
   -charset => $encoding
);
my $pok = print $head . $OUT;
#exit;

sub list {
   opendir DIR, $base_dir;
   my @m3u = readdir DIR;
   closedir DIR;
   my $name;
   $OUT .= q~<p style="font-family:Verdana;font-size:14px;font-weight:bold">M3U List</p><pre>~;
   foreach (sort @m3u) {
      next unless $_ =~ m{ [.] m3u \z }xmsi;
      $name = $_;
      $name =~ s{ [.] m3u \z }{}xmsi;
      $OUT .= qq~[ <a href="$p?m3u=$name">HTML</a> - <a href="$p?m3u=$name&amp;xml=1" target="_blank">XML</a> ] $_\n~;
   }
   $OUT .= q~</pre>~;
   return;
}

sub m3u {
   my $m3u = $cgi->param('m3u') or return $error;
   return $error if $m3u =~ m{ \A A-Z_a-z_0-9 }xms;
   my $file = sprintf q{%s/%s.m3u}, $base_dir, $m3u;
   return $error if ! -e $file;
   my $parser = MP3::M3U::Parser->new(-seconds => 'format');
   $parser->parse($file);
   $parser->export(-encoding => $encoding,
                   -format   => $output_format,
                   -drives   => 'off',
                   -toscalar => \$OUT);
   my $link = qq~<p>[ <a href="$p" style="color:#FFFFFF">M3U List</a>&nbsp;&nbsp;&nbsp; <a href="$p?m3u=$m3u&amp;xml=1" style="color:#FFFFFF" target="_blank">XML</a> ]</p>~;
   $OUT =~ s{<blockquote>}{$link<blockquote>}xms;
   return;
}
