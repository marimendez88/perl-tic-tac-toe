#!/usr/bin/perl

use strict;
use warnings;

my @board = qw/- - - - - - - - -/;

sub display_board {
  print "\n";
  for my $i (0 .. 8) {
    print "$board[$i] ";
    print "\n" if ($i + 1) % 3 == 0;
  }
  print "\n";
}

sub get_move {
  my ($player) = @_;
  print "Player $player turn: ";
  my $move = <STDIN>;
  chomp $move;
  return $move;
}

sub make_move {
  my ($player, $move) = @_;
  $board[$move] = $player;
}

sub game_over {
  for my $i (0, 3, 6) {
    return 1 if ($board[$i] eq $board[$i + 1] && $board[$i] eq $board[$i + 2] && $board[$i] ne '-');
  }

  for my $i (0 .. 2) {
    return 1 if ($board[$i] eq $board[$i + 3] && $board[$i] eq $board[$i + 6] && $board[$i] ne '-');
  }

  return 1 if ($board[0] eq $board[4] && $board[0] eq $board[8] && $board[0] ne '-');
  return 1 if ($board[2] eq $board[4] && $board[2] eq $board[6] && $board[2] ne '-');

  return 0;
}

sub tic_tac_toe {
  display_board();
  for my $i (0 .. 8) {
    my $player = ($i % 2 == 0) ? 'X' : 'O';
    my $move = get_move($player);
    make_move($player, $move);
    display_board();
    if (game_over()) {
      print "Player $player won!\n";
      last;
    }
  }
  print "It's a draw!\n" if !game_over();
}

tic_tac_toe();
