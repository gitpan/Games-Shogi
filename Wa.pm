package Games::Shogi::Wa;

use strict;
use warnings;
use vars qw(@ISA $VERSION);
use Shogi;

@ISA = qw(Games::Shogi);
$VERSION = '0.01';

sub size() { 11 }
sub promotion_zone() { 4 }
sub allow_drop() { undef }
sub capture() { [ 'K', 'CP' ] }

# {{{ Board static data
my @board = (
  #    11 10  9  8  7  6  5  4  3  2  1
  [qw( LH CM SO FC VS CK VW FG SC BD  O )],   # a # SC and SO may be reversed?
  [qw(  _ CE  _  _  _ SW  _  _  _ FF  _ )],   # b
  [qw( SP SP SP RR SP SP SP TF SP SP SP )],   # c
  [qw(  _  _  _ SP  _  _  _ SP  _  _  _ )],   # d
  [qw(  _  _  _  _  _  _  _  _  _  _  _ )],   # e
  [qw(  _  _  _  _  _  _  _  _  _  _  _ )],   # f
  [qw(  _  _  _  _  _  _  _  _  _  _  _ )],   # g
  [qw(  _  _  _ sp  _  _  _ sp  _  _  _ )],   # h
  [qw( sp sp sp tf sp sp sp rr sp sp sp )],   # i
  [qw(  _ ff  _  _  _ sw  _  _  _ ce  _ )],   # j
  [qw(  o bd sc fg vw ck vs fc so cm lh )] ), # k
# }}}

# {{{ Pieces
my $pieces = {
  # {{{ Blind Dog
  bd => {
    name => 'Blind Dog',
    romaji => 'moken',
    promote => 'vw',
    neighborhod => [
      q(     ),
      q( o o ),
      q( o^o ),
      q(  o  ),
      q(     ) ] },
  # }}}
  # {{{ Climbing Monkey
  cm => {
    name => 'Climbing Monkey',
    romaji => 'toen',
    promote => 'vs',
    neighborhood => [
      q(     ),
      q( ooo ),
      q(  ^  ),
      q(  o  ),
      q(     ) ] },
  # }}}
  # {{{ Cloud Eagle
  ce => {
    name => 'Cloud Eagle',
    romaji => 'unju',
    neighborhood => [
      q(o   o),
      q( 3|3 ),
      q( o^o ),
      q( o o ),
      q(     ) ] },
  # }}}
  # {{{ Crane-King
  ck => {
    name => 'Crane-King',
    romaji => 'kakugyoku',
    neighborhood => [
      q(     ),
      q( ooo ),
      q( o^o ),
      q( ooo ),
      q(     ) ] },
  # }}}
  # {{{ Flying Cock
  fc => {
    name => 'Flying Cock',
    romaji => 'keihi',
    promote => 'rf',
    neighborhood => [
      q(     ),
      q( o o ),
      q( o^o ),
      q(     ),
      q(     ) ] },
  # }}}
  # {{{ Flying Falcon
  ff => {
    name => 'Flying Falcon',
    romaji => 'hiyo',
    promote => 'tfa',
    neighborhood => [
      q(     ),
      q( \o/ ),
      q(  ^  ),
      q( / \ ),
      q(     ) ] },
  # }}}
  # {{{ Flying Goose
  fg => {
    name => 'Flying Goose',
    romaji => 'ganhi',
    promote => 'sw',
    neighborhood => [
      q(     ),
      q( ooo ),
      q(  ^  ),
      q(  o  ),
      q(     ) ] },
  # }}}
  # {{{ Liberated Horse
  lh => {
    name => 'Liberated Horse',
    romaji => 'fuba',
    promote => 'hh',
    neighborhood => [
      q(     ),
      q(  |  ),
      q(  ^  ),
      q(  2  ),
      q(  o  ) ] },
  # }}}
  # {{{ Oxcart
  o => {
    name => 'Oxcart',
    romaji => 'gisha',
    promote => 'po',
    neighborhood => [
      q(     ),
      q(  |  ),
      q(  ^  ),
      q(     ),
      q(     ) ] },
  # }}}
  # {{{ Running Rabbit
  rr => {
    name => 'Running Rabbit',
    romaji => 'soto',
    promote => 'tf', # XXX
    neighborhood => [
      q(     ),
      q( o|o ),
      q(  ^  ),
      q( ooo ),
      q(     ) ] },
  # }}}
  # {{{ Sparrow Pawn
  sp => {
    name => 'Sparrow Pawn',
    romaji => 'jakufu',
    promote => 'gb',
    neighborhood => [
      q(     ),
      q(  o  ),
      q(  ^  ),
      q(     ),
      q(     ) ] },
  # }}}
  # {{{ Strutting Crow
  sc => {
    name => 'Strutting Crow',
    romaji => 'uko',
    promote => 'ff',
    neighborhood => [
      q(     ),
      q(  o  ),
      q(  ^  ),
      q( o o ),
      q(     ) ] },
  # }}}
  # {{{ Swallow's Wings
  sw => {
    name => "Swallow's Wings",
    romaji => "en'u",
    promote => 'gs',
    neighborhood => [
      q(     ),
      q(  o  ),
      q( -^- ),
      q(  o  ),
      q(     ) ] },
  # }}}
  # {{{ Swooping Owl
  so => {
    name => 'Swooping Owl',
    romaji => 'shiku',
    promote => 'ce',
    neighborhood => [
      q(     ),
      q(  o  ),
      q(  ^  ),
      q( o o ),
      q(     ) ] },
  # }}}
  # {{{ Treacherous Fox
  tf => {
    name => 'Treacherous Fox',
    romaji => 'onko',
    neighborhood => [
      q(x x x),
      q( xxx ),
      q(  ^  ),
      q( xxx ),
      q(x x x) ] },
  # }}}
  # {{{ Violent Stag
  vs => {
    name => 'Violent Stag',
    romaji => 'moroku',
    promote => 'rb',
    neighborhood => [
      q(     ),
      q( ooo ),
      q(  ^  ),
      q( o o ),
      q(     ) ] },
  # }}}
  # {{{ Violent Wolf
  vw => {
    name => 'Violent Wolf',
    romaji => 'moro',
    promote => 'be',
    neighborhood => [
      q(     ),
      q( ooo ),
      q( o^o ),
      q(  o  ),
      q(     ) ] },
  # }}}

  # {{{ Bear's Eyes
  be => {
    name => "Bear's Eyes",
    romaji => 'yugan',
    neighborhood => [
      q(     ),
      q( ooo ),
      q( o^o ),
      q( ooo ),
      q(     ) ] },
  # }}}
  # {{{ Gliding Swallow
  gs => {
    name => 'Gliding Swallow',
    romaji => 'enko',
    neighborhood => [
      q(     ),
      q(  |  ),
      q( -^- ),
      q(  |  ),
      q(     ) ] },
  # }}}
  # {{{ Golden Bird
  gb => {
    name => 'Golden Bird',
    romaji => 'kincho',
    neighborhood => [
      q(     ),
      q( ooo ),
      q( o^o ),
      q(  o  ),
      q(     ) ] },
  # }}}
  # {{{ Heavenly Horse
  hh => {
    name => 'Heavenly Horse',
    romaji => 'tenba',
    neighborhood => [
      q( x x ),
      q(     ),
      q(  ^  ),
      q(     ),
      q( x x ) ] },
  # }}}
  # {{{ Plodding Ox
  po => {
    name => 'Plodding Ox',
    romaji => 'sengyu',
    neighborhood => [
      q(     ),
      q( ooo ),
      q( o^o ),
      q( ooo ),
      q(     ) ] },
  # }}}
  # {{{ Raiding Falcon
  rf => {
    name => 'Raiding Falcon',
    romaji => 'enyo',
    neighborhood => [
      q(     ),
      q( o|o ),
      q( o^o ),
      q(  |  ),
      q(     ) ] },
  # }}}
  # {{{ Roaming Boar
  rb => {
    name => 'Roaming Boar',
    romaji => 'kocho',
    neighborhood => [
      q(     ),
      q( ooo ),
      q( o^o ),
      q( o o ),
      q(     ) ] },
  # }}}
  # {{{ Tenacious Falcon
  tfa => {
    name => 'Tenacious Falcon',
    romaji => 'keiyo',
    neighborhood => [
      q(     ),
      q( \|/ ),
      q( o^o ),
      q( /|\ ),
      q(     ) ] }
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
