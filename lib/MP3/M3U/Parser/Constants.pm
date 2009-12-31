package MP3::M3U::Parser::Constants;
use strict;
use warnings;
use vars qw( $VERSION @EXPORT @EXPORT_OK %EXPORT_TAGS $OID );

$VERSION = '2.30';

# Data table key map
use constant PATH    => $OID++;
use constant ID3     => $OID++;
use constant LEN     => $OID++;
use constant ARTIST  => $OID++;
use constant SONG    => $OID++;
use constant MAXDATA => $OID; # Maximum index number of the data table

use constant EMPTY_STRING          => q{};
use constant MINIMUM_SEARCH_LENGTH =>   3;

use base qw( Exporter );

BEGIN {
    %EXPORT_TAGS = (
        fields => [qw( PATH ID3 LEN ARTIST SONG MAXDATA   )],
        etc    => [qw( EMPTY_STRING MINIMUM_SEARCH_LENGTH )],
    );
    @EXPORT_OK        = map { @{ $EXPORT_TAGS{$_} } } keys %EXPORT_TAGS;
    $EXPORT_TAGS{all} = \@EXPORT_OK;
    @EXPORT           = @EXPORT_OK;
}

1;

__END__

=pod

=head1 NAME

MP3::M3U::Parser::Constants - Constants for MP3::M3U::Parser

=head1 SYNOPSIS

Private module.

=head1 DESCRIPTION

-

=head1 SEE ALSO

L<MP3::M3U::Parser>.

=cut
