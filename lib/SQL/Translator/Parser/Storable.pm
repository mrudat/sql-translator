package SQL::Translator::Parser::Storable;

# -------------------------------------------------------------------
# $Id: Storable.pm,v 1.4 2003-10-15 16:52:04 kycl4rk Exp $
# -------------------------------------------------------------------
# Copyright (C) 2003 Paul Harrington <harringp@deshaw.com>.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; version 2.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
# 02111-1307  USA
# -------------------------------------------------------------------

=head1 NAME

SQL::Translator::Parser::Storable - parser for Schema objects serialized
    with the Storable module

=head1 SYNOPSIS

  use SQL::Translator;

  my $translator = SQL::Translator->new;
  $translator->parser('Storable');

=head1 DESCRIPTION

Slurps in a Schema from a Storable file on disk.  You can then turn
the data into a database tables or graphs.

=cut

use strict;
use vars qw($DEBUG $VERSION @EXPORT_OK);
$DEBUG = 0 unless defined $DEBUG;
$VERSION = sprintf "%d.%02d", q$Revision: 1.4 $ =~ /(\d+)\.(\d+)/;

use Storable;
use Exporter;
use SQL::Translator::Utils qw(debug normalize_name);

use base qw(Exporter);

@EXPORT_OK = qw(parse);

sub parse {
    my ($translator, $data) = @_;

    if (defined($data)) {
        $translator->{'schema'} = Storable::thaw($data);
        return 1;
    } elsif (defined($translator->filename)) {
        $translator->{'schema'} = Storable::retrieve($translator->filename);
        return 1;
    }

    return 0;
}

1;

# -------------------------------------------------------------------

=pod

=head1 SEE ALSO

SQL::Translator.

=head1 AUTHOR

Paul Harrington E<lt>harringp@deshaw.comE<gt>.

=cut