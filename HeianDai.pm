package Games::Shogi::HeianDai;

use strict;
use warnings;
use vars qw(@ISA $VERSION);
use Shogi;

@ISA = qw(Games::Shogi);
$VERSION = '0.01';

sub size() { 13 }
sub promotion_zone() { 5 }
sub allow_drop() { undef }
sub capture() { [ 'K', 'CP' ] } # XXX ?

# {{{ Board static data
my @board = (
  #    13  12  11  10   9   8   7   6   5   4   3   2   1
  [qw(  L   N   I   C   S   G   K   G   S   C   I   N   L )],  # 1
  [qw( FC  FD   _   _  FT   _  SM   _  FT   _   _  FD  FC )],  # 2
  [qw(  P   P   P   P   P   P   P   P   P   P   P   P   P )],  # 3
  [qw(  _   _   _   _   _   _  GB   _   _   _   _   _   _ )],  # 4
  [qw(  _   _   _   _   _   _   _   _   _   _   _   _   _ )],  # 5
  [qw(  _   _   _   _   _   _   _   _   _   _   _   _   _ )],  # 6
  [qw(  _   _   _   _   _   _   _   _   _   _   _   _   _ )],  # 7
  [qw(  _   _   _   _   _   _   _   _   _   _   _   _   _ )],  # 8
  [qw(  _   _   _   _   _   _   _   _   _   _   _   _   _ )],  # 9
  [qw(  _   _   _   _   _   _  gb   _   _   _   _   _   _ )],  # 10
  [qw(  p   p   p   p   p   p   p   p   p   p   p   p   p )],  # 11
  [qw( fc  fd   _   _  ft   _  sm   _  ft   _   _  fd  fc )],  # 12
  [qw(  l   n   i   c   s   g   k   g   s   c   i   n   l )] );# 13
# }}}

# {{{ Pieces
my $pieces = {
  # {{{ Copper General
  c => {
    name => 'Copper General',
    romaji => 'dosho',
    promote => 'g',
    neighborhood => [
      q(     ),
      q( ooo ),
      q(  ^  ),
      q(  o  ),
      q(     ) ] },
  # }}}
  # {{{ Fierce Tiger
  ft => {
    name => 'Fierce Tiger',
    promote => 'g',
    neighborhood => [
      q(     ),
      q( o o ),
      q(  ^  ),
      q( o o ),
      q(     ) ] },
  # }}}
  # {{{ Flying Dragon
  fd => {
    name => 'Flying Dragon',
    romaji => 'hiryu',
    promote => '+fd',
    neigborhood => [
      q(     ),
      q( \ / ),
      q(  ^  ),
      q( / \ ),
      q(     ) ] },
  # }}}
  # {{{ Free Chariot
  fc => {
    name => 'Free Chariot',
    promote => 'g',
    neighborhood => [
      q(     ),
      q(  |  ),
      q(  ^  ),
      q(  |  ),
      q(     ) ] },
  # }}}
  # {{{ Go-Between
  gb => {
    name => 'Go-Between',
    romaji => 'chunin',
    promote => 'g',
    move => [
      q(     ),
      q(  o  ),
      q(  ^  ),
      q(  o  ),
      q(     ) ] },
  # }}}
  # {{{ Gold General
  g => {
    name => 'Gold General',
    romaji => 'kinsho',
    neighborhood => [
      q(     ),
      q( ooo ),
      q( o^o ),
      q(  o  ),
      q(     ) ] },
  # }}}
  # {{{ Iron General
  i => {
    name => 'Iron General',
    romaji => 'tessho',
    promote => 'g',
    neighborhood => [
      q(     ),
      q( ooo ),
      q(  ^  ),
      q(     ),
      q(     ) ] },
  # }}}
  # {{{ King
  k => {
    name => 'King',
    romaji => 'osho',
    neighborhood => [
      [qw(     )],
      [qw( ooo )],
      [qw( o^o )],
      [qw( ooo )],
      [qw(     )] ] },
  # }}}
  # {{{ Knight
  n => {
    name => 'Knight',
    romaji => 'keima',
    promote => 'g',
    neighborhood => [
      q( x x ),
      q(     ),
      q(  ^  ),
      q(     ),
      q(     ) ] },
  # }}}
  # {{{ Lance
  l => {
    name => 'Lance',
    romaji => 'kyosha',
    promote => 'g',
    neighborhood => [
      q(     ),
      q(  |  ),
      q(  ^  ),
      q(     ),
      q(     ) ] },
  # }}}
  # {{{ Pawn
  p => {
    name => 'Pawn',
    romaji => 'fuhyo',
    promote => '+p',
    neighborhood => [
      q(     ),
      q(  o  ),
      q(  ^  ),
      q(     ),
      q(     ) ] },
  # }}}
  # {{{ Side Mover
  sm => {
    name => 'Side Mover',
    romaji => 'ogyo',
    promote => 'g',
    neighborhood => [
      q(     ),
      q(  o  ),
      q( -^- ),
      q(  o  ),
      q(     ) ] },
  # }}}
  # {{{ Silver General
  s => {
    name => 'Silver General',
    romaji => 'ginsho',
    promote => 'g',
    neighborhood => [
      q(     ),
      q( ooo ),
      q(  ^  ),
      q( o o ),
      q(     ) ] },
    # }}}

  # {{{ Promoted Flying Dragon
  '+fd' => {
    name => 'Promoted Flying Dragon',
    neighborhood => [
      q(     ),
      q( \o/ ),
      q( o^o ),
      q( /o\ ),
      q(     ) ] },
  # }}}
  # {{{ Promoted Pawn
  '+p' => {
    name => 'Promoted Pawn',
    romaji => 'tokin',
    neighborhood => [
      q(     ),
      q( ooo ),
      q( o^o ),
      q(  o  ),
      q(     ) ] },
  # }}}
};
# }}}

# {{{ new
sub new {
  my $proto = shift;
  my $self = { pieces => $pieces };
  bless $self, ref($proto) || $proto;
  $self->{board} = $self->initial_board(\@board);
  return $self }
# }}}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Games::Shogi - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Games::Shogi;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Games::Shogi, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.

=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Jeffrey Goff, E<lt>jeffreygoff@nonetE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2004 by Jeffrey Goff

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
