(*******************************************************************************
 *  Othello module: contains the class othello.
 *)

open ConsoleGame
open HumanPlayer
open TwoPlayersGame
open Colour
open Board;;

(*******************************************************************************
 *  Runs a two-player hotseat game of Othello on the connected terminal.
 *)
class othello (boardSize : int) =
    object
        val theBoard = standardBoard boardSize

        method start =
            print_string "Enter the black player's name: ";
            let player1 = new humanPlayer (read_line ()) BLACK in
            print_string "Enter the white player's name: ";
            let player2 = new humanPlayer (read_line ()) WHITE in
            let theGame = new twoPlayersGame player1 player2 theBoard in
            let interface = new consoleGame theGame in
            print_newline ();
            interface#start
    end;;

let inst = new othello 8 in
inst#start
