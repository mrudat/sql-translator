package SQL::Translator::Producer::Storable;

# -------------------------------------------------------------------
# $Id: Storable.pm,v 1.4 2003-10-15 19:13:23 kycl4rk Exp $
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

SQL::Translator::Producer::Storable - serializes the SQL::Translator::Schema 
    object via the Storable module

=head1 SYNOPSIS

  use SQL::Translator;

  my $translator = SQL::Translator->new;
  $translator->producer('Storable');

=head1 DESCRIPTION

This module uses Storable to serialize a schema to a string so that it
can be saved to disk.  Serializing a schema and then calling producers
on the stored can realize significant performance gains when parsing
takes a long time.

=cut

use strict;
use vars qw($DEBUG $VERSION @EXPORT_OK);
$DEBUG = 0 unless defined $DEBUG;
$VERSION = sprintf "%d.%02d", q$Revision: 1.4 $ =~ /(\d+)\.(\d+)/;

use Storable;
use Exporter;
use base qw(Exporter);

@EXPORT_OK = qw(produce);

sub produce {
    my $t           = shift;
    my $args        = $t->producer_args;
    my $schema      = $t->schema;
    my $serialized  = Storable::nfreeze($schema);

    return $serialized;
}

1;

# -------------------------------------------------------------------

=pod

=head1 AUTHOR

Paul Harrington E<lt>harringp@deshaw.comE<gt>.

=head1 SEE ALSO

SQL::Translator, SQL::Translator::Schema, Storable.

=cut