package Games::Shogi::Tori;

use strict;
use warnings;
use vars qw(@ISA $VERSION);
use Shogi;

@ISA = qw(Games::Shogi);
$VERSION = '0.01';

sub size() { 7 }
sub promotion_zone() { 2 }
sub allow_drop() { 1 }
sub capture() { ['PH'] }

# {{{ Board static data
my @board = (
  #     7  6  5  4  3  2  1
  [qw( RQ PT CR PH CR PT LQ )],   # a
  [qw( _  _  _  FA _  _  _  )],   # b
  [qw( SW SW SW SW SW SW SW )],   # c
  [qw( _  _  SW _  sw  _ _  )],   # d
  [qw( sw sw sw sw sw sw sw )],   # e
  [qw( _  _  _  fa _  _  _  )],   # f
  [qw( lq pt cr ph cr pt rq )] ); # g
# }}}

# {{{ Pieces
my $pieces = {
  # {{{ Crane
  cr => {
    name => 'Crane',
    romaji => 'tsuru',
    neighborhood => [
      q(     ),
      q( ooo ),
      q(  ^  ),
      q( ooo ),
      q(     ) ] },
  # }}}
  # {{{ Eagle
  eg => {
    name => 'Eagle',
    romaji => 'washi',
    neighborhood => [
      q(     ),
      q( \ / ),
      q( o^o ),
      q( o|o ),
      q(o   o) ] },
  # }}}
  # {{{ Falcon
  fa => {
    name => 'Falcon',
    romaji => 'taka',
    promote => 'eg',
    neighborhood => [
      q(     ),
      q( ooo ),
      q( o^o ),
      q( o o ),
      q(     ) ] },
  # }}}
  # {{{ Goose
  go => {
    name => 'Goose',
    romaji => 'kari',
    neighborhood => [
      q(x   x),
      q(     ),
      q(  ^  ),
      q(     ),
      q(  x  ) ] },
  # }}}
  # {{{ Pheasant
  pt => {
    name => 'Pheasant',
    romaji => 'kiji',
    neighborhood => [
      q(  x  ),
      q(     ),
      q(  ^  ),
      q( o o ),
      q(     ) ] },
  # }}}
  # {{{ Phoenix
  ph => {
    name => 'Phoenix',
    romaji => 'otori',
    neighborhood => [
      q(     ),
      q( ooo ),
      q( o^o ),
      q( ooo ),
      q(     ) ] },
  # }}}
  # {{{ Left Quail
  lq => {
    name => 'Left Quail',
    romaji => 'uzuru',
    neighborhood => [
      q(     ),
      q(  |  ),
      q(  ^  ),
      q( / o ),
      q(     ) ] },
  # }}}
  # {{{ Right Quail
  rq => {
    name => 'Right Quail',
    romaji => 'uzuru',
    neighborhood => [
      q(     ),
      q(  |  ),
      q(  ^  ),
      q( o \ ),
      q(     ) ] },
  # }}}
  # {{{ Swallow
  sw => {
    name => 'Swallow',
    romaji => 'tsubame',
    promote => 'go',
    neighborhood => [
      q(     ),
      q(  o  ),
      q(  ^  ),
      q(     ),
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
